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
<title>API FAQ</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<style type="text/css">
.question { font-weight: bold; margin-top: 10pt; margin-bottom: 5pt;}
.answer { margin-left: 20pt; }
.answer li { margin-bottom: 10pt; }
</style>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>API FAQ</h1>

<div class="question">How do I use the LocalePlanet API to internationalize my JavaScript application?</div>
<div class="answer">See the <a href="howto-localize-js.html">HOWTO: How to localize a JavaScript Application</a>.</div>

<div class="question">What APIs are available?</div>
<div class="answer">See the <a href="/api/index.html">complete list</a>.</div>

<div class="question">Can I get the JSON data via JSONP?</div>
<div class="answer">Yes.  Pass a <code>callback</code> parameter.</div>

<div class="question">Can I get it to use the user's locale without hard-coding or server-side processing?</div>
<div class="answer">Yes.  Use <code>auto</code> instead of a locale code in the URL and it will take the locale from the user's browser settings.<br/><br/>
Here's an example:  If you have server-side processing, you can just link to <code>/api/en-US/icu.js</code> and use server-side code 
to fill in the correct locale instead of <code>en-US</code>.<br/><br/>
But you can't do that if it is a static page without server-side code, so make the link
be <code>/api/auto/icu.js</code> instead.  The LocalePlanet server will look at the browser settings and send the correct version.</div>

<div class="question">I do not trust LocalePlanet and want to host the files myself.</div>
<div class="answer">Absolutely.  This is strongly encouraged.  Check out the <code>lpmirror.py</code> script (in the <a href="tools.html">tools</a> sections) to get started.</div>

<div class="question">I trust LocalePlanet and want to hot-link to files on LocalePlanet.</div>
<div class="answer">No problem for reasonable usage. Reasonable is a deliberately vague term, but unless you are doing a gazillion hits a day, you are okay.<br/><br/>
If you are using it in a production environment, please <a href="/support/contact.html">let me know who you are</a> in case anything changes.
</div>

<!--
<div class="question"></div>
<div class="answer"></div>

-->
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
