<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%@ include file="param.inc" %><%

	ULocale uloc = ULocale.forLocale(loc);

	String htmlTitle = _h("Time Zones");

%><!DOCTYPE html>
<html>
<head>
<title><%=htmlTitle%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=htmlTitle%></h1>
<p>Data version: <%=h(com.ibm.icu.util.TimeZone.getTZDataVersion())%></p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("ID")%></th>
		<!--<th style="text-align:left;"><%=_h("Display Name")%></th>-->
		<th style="text-align:left;"><%=_h("Short Names")%></th>
		<th style="text-align:left;"><%=_h("Long Names")%></th>
		<th style="text-align:left;"><%=_h("Canonical ID")%></th>
	</tr>
<%
	try
	{
		String[] ArrID = com.ibm.icu.util.TimeZone.getAvailableIDs();
		for (String id : ArrID)
		{
			out.println("\t<tr>");

			out.print("\t\t<td>");
			out.print(h(id));
			out.println("</td>");

			com.ibm.icu.util.TimeZone tz = com.ibm.icu.util.TimeZone.getTimeZone(id);

			//out.print("\t\t<td>");
			//out.print(h(tz.getDisplayName(uloc)));
			//out.println("</td>");

			out.print("\t\t<td valign=\"top\">");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.SHORT, uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.SHORT_COMMONLY_USED, uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.SHORT_GENERIC, uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.SHORT_GMT, uloc)));
			if (tz.useDaylightTime())
			{
				out.print("<br/>");
				out.print("<hr/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.SHORT, uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.SHORT_COMMONLY_USED, uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.SHORT_GENERIC, uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.SHORT_GMT, uloc)));
			}
			out.println("</td>");

			out.print("\t\t<td valign=\"top\">");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.GENERIC_LOCATION , uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.LONG, uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.LONG_GENERIC, uloc)));
			out.print("<br/>");
			out.print(h(tz.getDisplayName(false, com.ibm.icu.util.TimeZone.LONG_GMT, uloc)));
			if (tz.useDaylightTime())
			{
				out.print("<br/>");
				out.print("<hr/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.GENERIC_LOCATION , uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.LONG, uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.LONG_GENERIC, uloc)));
				out.print("<br/>");
				out.print(h(tz.getDisplayName(true, com.ibm.icu.util.TimeZone.LONG_GMT, uloc)));
			}
			out.println("</td>");

			out.print("\t\t<td>");
			out.print(h(tz.getCanonicalID(id)));
			out.println("</td>");

			out.println("\t</tr>");
		}
	}
	catch (Throwable t)
	{
		out.print("<tr><td colspan=\"2\">");
		out.print("<pre>");
		out.print(h(DebugUtil.toString(t)));
		out.println("</pre>");
		out.print("</td></tr>");
	}
%>
</table>
