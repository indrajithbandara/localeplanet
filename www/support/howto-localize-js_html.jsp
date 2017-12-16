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
<title>HOWTO: How to localize a JavaScript application</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<style type="text/css">
.question { font-weight: bold; margin-top: 10pt; margin-bottom: 5pt;}
.answer { margin-left: 20pt; }
.answer li { margin-bottom: 10pt; }
</style>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>HOWTO: How to localize a JavaScript application</h1>

<p>Using <a href="http://www.gnu.org/software/gettext/">GNU GetText</a> and the <a href="/api/index.html">LocalePlanet API</a></p>

<h2>Step by Step</h2>
<ol>
	<li>Add the LocalePlanet scripts to your pages:<br/>
	<code>&lt;script src=&quot;http://www.localeplanet.com/api/auto/icu.js&quot;&gt;&lt;/script&gt;<br/>
	&lt;script src=&quot;http://www.localeplanet.com/api/translate.js&quot;&gt;&lt;/script&gt;</code><br/>
	</li>
	
	<li>Everywhere you display a number or date, use one of the <a href="/api/auto/icu.html">icu.js</a> functions to format it first.<br/>
	For example, you would change<br/>
	<code>today.getDay() + '/' + today.getMonth() + '/' + today.getFullYear()</code><br/>
	to<br/>
	<code>icu.getDateFormat('SHORT_CENTURY').format(today)</code>
	</li>
	
	<li>Everywhere you display text, pass it to the <code>_()</code> function.<br/>
	For example, you would change<br/> 
	<code>alert('Hello, world!');</code><br/>
	to<br/>
	<code>alert(_('Hello, world!'));</code>.</li>
	<li>
	You can use the previous two steps together.  For example, you would change<br/>
	<code>alert('Today is ' + today.getDay() + '/' + today.getMonth() + '/' + today.getFullYear());</code><br/>
	to<br/>
	<code>alert(_("Today is {0}", icu.getDateFormat('SHORT_CENTURY').format(today)));</code>
	</li>
	
	<li>Use the <a href="http://www.gnu.org/software/gettext/">GNU gettext</a> programs to extract the text from your pages.  You end up with a <code>.po</code>
	file with just the text strings in your native language.</li>
	
	<li>Translate the <code>.po</code> file.  Most translators/services/etc. can work with them.  I recommend <a href="http://www.poedit.net/">poedit</a>, 
	a simple GUI program that works on Windows/Mac/Linux. You will end up with an additional <code>.po</code> file for each translated language.</li>
	
	<li>Use the <a href="tools.html">po2js</a> or <a href="tools.html">po2json</a> scripts to convert the <code>.po</code> files to something usable by JavaScript.  Put these 
	files on your website and add the appropriate one to your pages.</li>
	
	<li>Call <code>_.setTranslation()</code> with the JSON data from the previous step.</li>
</ol>

<h2>Notes</h2>
<ul>
	<li>You can change the global names.  See the  <a href="/api/auto/icu.html">icu.js</a> and <a href="/api/translate.html">translate.js</a> script documentation for details.</li>
	<li>You can try <a href="tools.html">gt4po</a> to use Google Translate on your <code>.po</code> file, but results are &ldquo;mixed&rdquo;, especially for short or unusual strings.</li>
</ul>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
