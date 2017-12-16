<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

%><!DOCTYPE html>
<html>
<head>
<title>codelist.json - Locale Code List</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>codelist.json - Locale Code List</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>Just the complete list of standard locale codes.  This should match the <a href="/icu/index.html">normalized ICU list</a>.</p>
<h2><%=_h("Sample")%></h2>
<p><a href="codelist.json">codelist.json</a></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
