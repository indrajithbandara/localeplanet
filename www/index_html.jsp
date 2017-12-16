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
<title><%=_h("LocalePlanet: L10N and I18N for JavaScript")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
<meta name="google-site-verification" content="zuTW5iV7v6LWKV-Zlx_lVB86ZlJ7N7n9MpOX8sQKYx8" />
<meta name="msvalidate.01" content="E90DBA4A9D3D37F1056E64E5604A7A0D" />
<meta name="y_key" content="0b39b5a3c445a93e" />
<meta name="description" content="L10N and I18N for JS (Localization and Internationalization for JavaScript)" />
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1><%=_h("Localization and Internationalization for JavaScript")%></h1>
		</div>

<p>When I started to localize an application with a lot of client-side JavaScript code, I discovered the
truth about localization in JavaScript: there is none.</p>

<p>LocalePlanet is the library and procedures that I came up with to add it.</p>

<p>Where to begin?</p>
<ol>
	<li>Read the <a href="/support/howto-localize-js.html">How-to</a> guide and <a href="/support/api.html">API FAQ</a>.</li>
	<li>Dive into the <a href="/api/index.html">detailed API docs</a>.</li>
	<li>Check out the <a href="/support/tools.html">translation tools</a>.</li>
	<li>See what <a href="/support/alternatives.html">alternative libraries</a> are available, and why I did not use them.</li>
	<li>What do you think? <a href="/support/contact.html">Let me know</a>!</li>
</ol>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>