<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*"
%><!DOCTYPE html>
<html>
<head>
<title>Contributing to LocalePlanet</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Contributing to LocalePlanet</h1>

<h2>Software</h2>
<p>This is the JSON format for the software comparison database.</p>

<ul>
	<li>vendor</li>
	<li>product - include any relevent version information</li>
	<li>url - official URL for the product, usually at the vendor's website (optional)</li>
	<li>referenceHtml - HTML snippet pointing the original source where the locale support is documented</li>
	<li>locales - array of locale codes</li>
	<li>release-date - the software's date release is ISO 8601 (YYYYMMDD) format</li>
	<li>last-modified - the date this entry was last modified</li>
	<li>creditHtml - HTML snippet for credits (usually hyperlink to email address or website)</li>
</ul>

<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
