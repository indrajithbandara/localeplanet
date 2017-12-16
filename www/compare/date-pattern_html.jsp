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
		patternCode = "SHORT_PADDED_CENTURY";
	}


%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Compare Date Patterns")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Compare Date Patterns")%></h1>
<p>Pattern: <%

	String[] ArrTest = DatePatternUtil.getDefaultCodes();

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
<p>See the <a href="/api/auto/datepat.html">datepat.json API</a> for documentation on pattern codes.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Locale")%></th>
		<th style="text-align:left;"><%=_h("Date Pattern")%></th>
		<th style="text-align:left;"><%=_h("Today")%></th>
	</tr>
<%
	java.util.Date today = new java.util.Date();

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

		String pattern = DatePatternUtil.getPattern(patternCode, ArrLocale[loop]);
		out.print("\t\t<td>");
		out.print(h(pattern));
		out.println("</td>");

		out.print("\t\t<td>");
		out.print(h(new SimpleDateFormat(pattern, ArrLocale[loop]).format(today)));
		out.println("</td>");

		out.println("\t</tr>");
	}

%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
