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

	String target = (String)request.getAttribute("urlparam");

	String htmlTitle = h(MessageFormat.format(_("Data Source Comparison for {0}"), target));

%><!DOCTYPE html>
<html>
<head>
<title><%=htmlTitle%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=htmlTitle%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Data source")%></th>
		<th><%=_h("Supported?")%></th>
		<th style="text-align:left;"><%=_h("Name in data source")%></th>
	</tr>
<%
	GenericLocaleCache[] caches = CommonLocaleUtil.getCaches();

	for (GenericLocaleCache theCache : caches)
	{
		out.println("\t<tr>");
		out.print("\t\t<td>");
		out.print(h(theCache.getDescription(loc)));
		out.println("</td>");

		GenericLocale theLocale = theCache.getGeneric(target);

		out.print("\t\t<td style=\"text-align:center;\">");
		if (theLocale == null)
		{
			out.print(_h("No"));
		}
		else
		{
			out.print("<a href=\"/");
			out.print(UrlUtil.encode(theCache.getCode()));
			out.print("/");
			out.print(UrlUtil.encode(target));
			out.print("/index.html\">");
			out.print(_h("Yes"));
			out.print("</a>");
		}
		out.println("</td>");

		out.print("\t\t<td>");
		if (theLocale == null)
		{
			out.print("&nbsp;");
		}
		else
		{
			out.print(h(theLocale.getName(loc)));
		}
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
