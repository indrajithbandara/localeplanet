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
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	NumberFormat nf = NumberFormat.getIntegerInstance(loc);

	List<String> theList = new ArrayList<String>();
	for (Locale theLocale : Locale.getAvailableLocales())
	{
		theList.add(theLocale.toString());
	}

	//Map<String, Object> counterMap = theMemcache.getAll(theList);

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Visitor Locale Statistics")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Visitor Locale Statistics")%></h1>
<p>Note that these stats are only for this particular instance, and are reset when the instance is restarted.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;">Locale</th>
		<th style="text-align:right;"># of hits</th>
	</tr>
<%
	out.println("<tr><td colspan=\"2\">LATER: pull from Google Analytics</td></tr>");
 	/*
	for (String locCode : counterMap.keySet())
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		out.print(h(LocaleCache.getInstance().getNormalizedCode(locCode)));
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:right;\">");

		Long count = 0; //(Long)counterMap.get(locCode);

		out.print(h(nf.format(count.longValue())));
		out.println("</td>");

		out.println("\t</tr>");
	}
	*/
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>