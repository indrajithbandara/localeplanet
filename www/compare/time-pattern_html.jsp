<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.dotnet.*,
		 		 com.localeplanet.google.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String patternCode = request.getParameter("pat");
	if (patternCode == null)
	{
		patternCode = "SHORT";
	}

	Map<String, Integer> codeMap = new LinkedHashMap<String, Integer>();
	codeMap.put("SHORT", DateFormat.SHORT);
	codeMap.put("MEDIUM", DateFormat.MEDIUM);
	codeMap.put("LONG", DateFormat.LONG);
	codeMap.put("FULL", DateFormat.FULL);

	java.util.Calendar now = java.util.Calendar.getInstance();
	java.util.Date nowDate = now.getTime();
	//java.util.TimeZone tz = now.getTimeZone();
	//java.util.TimeZone tz = java.util.TimeZone.getTimeZone("America/New_York");
	java.util.TimeZone tz = java.util.Calendar.getInstance(request.getLocale()).getTimeZone();

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Compare Time Patterns")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Compare Time Patterns")%></h1>
<p>Pattern: <%

	String[] ArrTest = codeMap.keySet().toArray(new String[0]);

	for (int loop = 0; loop < ArrTest.length; loop++)
	{
		if (loop > 0)
		{
			out.print(" | ");
		}
		if (patternCode.equals(ArrTest[loop]))
		{
			out.print("<b>");
			out.print(h(ArrTest[loop]));
			out.print("</b>");
		}
		else
		{
			out.print("<a href=\"?pat=");
			out.print(h(ArrTest[loop]));
			out.print("\">");
			out.print(h(ArrTest[loop]));
			out.print("</a>");
		}
	}

%></p>
<p>See the <a href="/api/auto/timepat.html">timepat.json API</a> for documentation on pattern codes.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Locale")%></th>
		<th style="text-align:left;"><%=_h("Time Pattern")%></th>
		<th style="text-align:left;"><%=h(MessageFormat.format(_("Now ({0})"), "UTC"))%></th>
		<th style="text-align:left;"><%=h(MessageFormat.format(_("Now ({0})"), tz.getDisplayName(tz.inDaylightTime(nowDate), java.util.TimeZone.SHORT, loc)))%></th>
	</tr>
<%

	Locale[] ArrLocale = Locale.getAvailableLocales();
	Arrays.sort(ArrLocale, LocaleNameComparator.getInstance(loc));

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getDisplayName(loc));
		out.print(" (");
		out.print("<a href=\"");
		out.print(UrlUtil.encode(LocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString())));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, LocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString()));
		out.print("</a>");
		out.print(")");
		out.println("</td>");

		SimpleDateFormat df = (SimpleDateFormat)DateFormat.getTimeInstance(codeMap.get(patternCode), ArrLocale[loop]);
		out.print("\t\t<td>");
		out.print(h(df.toPattern()));
		out.println("</td>");

		out.print("\t\t<td>");
		out.print(h(df.format(nowDate)));
		out.println("</td>");

		df.setTimeZone(tz);
		out.print("\t\t<td>");
		out.print(h(df.format(nowDate)));
		out.println("</td>");

		out.println("\t</tr>");
	}

%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
