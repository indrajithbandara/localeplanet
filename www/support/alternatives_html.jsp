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
<title>Alternative Localization/Internationalization APIs for JavaScript</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Alternative APIs</h1>
<p>JavaScript does not have <i>any</i> decent localization/internationalization support built-in, and it is a difficult but necessary problem
to address, so all sorts of APIs and approaches are floating around.</p>
<p>This is my take on them, and why I decided to try to make my own.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Library")%></th>
		<th style="text-align:left;"><%=_h("Description")%></th>
	</tr>
	<tr>
		<td><a href="http://www.datejs.com/">date.js</a></td>
		<td>Great, but only handles dates.  Hasn't been updated since 2008.</td>
	</tr>
	<tr>
		<td><a href="https://bitbucket.org/pellepim/jstimezonedetect/wiki/Home">jsTimezoneDetect</a></td>
		<td>Useful utility to detect the browser's time zone.</td>
	</tr>
	<tr>
		<td><a href="http://code.google.com/webtoolkit/overview.html">GWT</a></td>
		<td><a href="http://code.google.com/webtoolkit/doc/latest/DevGuideI18n.html">i18n Guide</a> - lots of support, but only useful if you are using GWT,
			and yet it is very different from the standard Java libraries. And each additional locale lengthens compile times.</td>
	</tr>
	<tr>
		<td><a href="http://code.google.com/closure/library/docs/overview.html">Closure&nbsp;Library</a></td>
		<td><a href="http://closure-library.googlecode.com/svn/docs/namespace_goog_i18n.html">goog.i18n</a> - only a couple of languages, coupled to Closure</td>
	</tr>
	<tr>
		<td><a href="http://dojotoolkit.org/">dojo</a></td>
		<td><a href="http://dojotoolkit.org/reference-guide/quickstart/internationalization/index.html">dojo.i18n</a> - Comprehensive, but tightly coupled to the rest of dojo.</td>
	</tr>
	<tr>
		<td><a href="https://github.com/jquery/jquery-global">jquery.global</a></td>
		<td><a href="http://weblogs.asp.net/scottgu/archive/2010/06/10/jquery-globalization-plugin-from-microsoft.aspx">from Microsoft</a> and uses MS terminology (Cultures vs Locales).  Cryptic (and limited) format codes for dates and numbers.</td>
	</tr>
<!--
	<tr>
		<td></td>
		<td></td>
	</tr>
-->
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
