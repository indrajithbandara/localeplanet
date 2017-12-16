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
<title>Credits</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Credits</h1>

<p>These are the tools I used to build LocalePlanet.  Also see the <a href="../data-sources.html">locale data sources</a>.</p>

<table class="plain" cellpadding="10" width="100%">
	<tr>
		<td align="center"><a href="http://www.styleshout.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/styleshout.png" alt="StyleShout badge" /></a></td>
		<td>The website design is the <a href="http://www.styleshout.com/templates/preview/Refresh11/index.html">Refresh</a> template from <a href="http://www.styleshout.com/">StyleShout</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://www.languageicon.org/index-icon.php"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/languageicon.png" alt="Language Icon badge" /></a></td>
		<td>The switch language icon is from the <a href="http://www.languageicon.org/index-icon.php">Language Icon Project</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://jetty.codehaus.org/jetty/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/jetty.png" alt="Powered by Jetty" /></a></td>
		<td>LocalePlanet runs on the <a href="http://jetty.codehaus.org/jetty/">Jetty WebServer</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://tuckey.org/urlrewrite/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/urf.png" alt="UrlRewriteFilter badge" /></a></td>
		<td>I use <a href="http://tuckey.org/urlrewrite/">UrlRewriteFilter</a> to make pretty URLs.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://java.sun.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/java.png" alt="Java badge" /></a></td>
		<td>I wrote all the code for LocalePlanet in <a href="http://www.java.com/">Java</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://ant.apache.org/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/ant.png" alt="Java badge" /></a></td>
		<td>I build and deploy using <a href="http://ant.apache.org/">Apache Ant</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://validator.w3c.org/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/valid-xhtml10.png" alt="W3C Validator badge" /></a></td>
		<td>HTML and CSS validation using the <a href="http://validator.w3c.org/">W3C's Validator</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://www.unicode.org/"><img alt="Unicode badge" src="/images/badge/unicode.png" style="vertical-align:middle;border:0;"/></a></td>
		<td>Files are stored and served using the <a href="http://www.unicode.org/">Unicode</a> standard UTF-8 encoding.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://tango.freedesktop.org/Tango_Desktop_Project"><img alt="Tango Project badge" src="/images/badge/tango.png" style="vertical-align:middle;border:0;"/></a></td>
		<td>Icons are from the <a href="http://tango.freedesktop.org/Tango_Desktop_Project">Tango Project</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://recaptcha.net/"><img alt="ReCaptcha logo" src="/images/badge/recaptcha.png" style="vertical-align:middle;border:0;"/></a></td>
		<td>The CAPTCHA on the <a href="/support/contact.html">contact page</a> is from <a href="http://recaptcha.net/">ReCaptcha</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://appengine.google.com/"><img style="vertical-align:middle;border:0" src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif" alt="Powered by Google App Engine" /></a></td>
		<td>Hosting is provided by <a href="http://appengine.google.com/">Google AppEngine</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://www.lduhtrp.net/image-2269669-10379071" target="_top"><img src="/images/badge/godaddy.png" alt="www.godaddy.com" style="vertical-align:middle;border:0;"/></a></td>
		<td>I use <a href="http://www.dpbolvw.net/click-2269669-10378406">GoDaddy</a> for domain names and DNS hosting.</td>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
