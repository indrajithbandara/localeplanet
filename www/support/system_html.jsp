<%@ page buffer="16kb"
		 contentType="text/html;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*"
%><%

%><!DOCTYPE html>
<html>
<head>
<title>LocalePlanet System Information</title>
<meta name="robots" content="noindex" />
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>System Information</h1>

<table class="table table-bordered table-striped">
<tr>
	<th align="left">Property</th>
	<th align="left">Value</th>
</tr>
<%
	TreeMap tree = new TreeMap(System.getProperties());

	Iterator iterprop = tree.keySet().iterator();

	int row = 0;

	while (iterprop.hasNext())
	{
		String key = (String)iterprop.next();
		out.print("\t<tr class=\"row");
		out.print(row++ % 2);
		out.println("\">");
		out.print("\t\t<td valign=top>");
		HtmlEncoder.encode(out, key);
		out.print("</td>\n\t\t<td valign=\"top\">");
		HtmlEncoder.encode(out, (String)tree.get(key));
		out.println("</td>\n\t</tr>");
	}
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
