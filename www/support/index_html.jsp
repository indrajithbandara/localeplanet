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
<title>LocalePlanet Support Resources</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Support</h1>
<ul>
	<li><a href="api.html">API FAQ</a></li>
	<li><a href="howto-localize-js.html">JavaScript localization how-to</a></li>
	<li><a href="faq.html">General FAQ</a></li>
	<li><a href="browser.html">Browser test page</a></li>
	<li><a href="alternatives.html">Alternatives</a> - other JavaScript libraries</li>
	<li><a href="credits.html">Credits</a></li>
	<li><a href="future.html">Future plans</a></li>
	<li><a href="links.txt">Links</a> - other localization and JavaScript resources</li>
	<li><a href="standards.html">Standards</a></li>
	<li><a href="tools.html">Tools</a> - home-made tools for translation workflow</li>
	<li><a href="books.html">Books</a> - about localization and internationalization</li>
	<li><a href="contact.html">Contact</a></li>
	<li><a href="http://nodeping.com/reports/checks/vdjgldpl-v6jg-4pes-8629-ohl66q0ahrmd">Uptime</a></li>
<!--
	<li><a href=""></a></li>
-->
</ul>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
