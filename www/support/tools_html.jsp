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

	String baseUrl = "https://github.com/fileformat/lptools/blob/master";

%><!DOCTYPE html>
<html>
<head>
<title>LocalePlanet Translation Tools</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>LocalePlanet Translation Tools</h1>
<p>I use the <a href="http://www.gnu.org/software/gettext/">GNU GetText</a> tools/libraries to deal with the language translations at LocalePlanet.</p>
<p>These are utilities that I wrote to make everything work together. They are command line tools written in python.  You can download them from <a href="https://github.com/fileformat/lptools">github</a>.</p>
<p>They all use the <a href="https://bitbucket.org/izi/polib/wiki/Home">polib</a> by <a href="http://www.izimobil.org/">David Jean Louis</a>.  I included the version of <a href="<%=baseUrl%>/polib.py">polib.py</a> that I used in the repository.</p>
<p>These are all command line tools.  You can get detailed parameter descriptions by running them  with <code>--help</code>.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("File\u00A0name")%></th>
		<th style="text-align:left;"><%=_h("Description")%></th>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/gt4po.py">gt4po.py</a></td>
		<td>Runs untranslated strings through Google Translate.  Results are marked as fuzzy so human translators know what needs to be checked.</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/lpmirror.py">lpmirror.py</a></td>
		<td>Mirrors scripts from LocalePlanet.</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/po2intl.py">po2intl.py</a></td>
		<td>Creates a test translation with all the text converted to <a href="http://www.fileformat.info/convert/text/international.htm">international</a>:
			just switches each plain character to an equivalent Unicode character with some sort of accent/mark.  When you run with this translation, any un-accented
			text has not been properly coded for translation.
		</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/po2js.py">po2js.py</a></td>
		<td>Moves translations from .po files to .js files so they can be included directly in a page.  Very similar to po2json, but
			translations that start with &quot;function(&quot; treated as code instead of strings.
			</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/po2json.py">po2json.py</a></td>
		<td>Moves translations from .po files to .json files so they can be used directly by JavaScript code.</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/po2prop.py">po2prop.py</a></td>
		<td>Moves translations from .po files to Java .properties files so they can be used directly by Java code.  There is a po2prop utility in the translate-toolkit package, but
		it gave me a wierd error on a perfectly valid .po file, and it was easy enough to write my own version.</td>
	</tr>
	<tr>
		<td style="vertical-align:top;"><a href="<%=baseUrl%>/translate.sh">translate.sh</a></td>
		<td>the bash shell script that does everything.  Not directly useful for anyone but me, but a good example of how all the pieces fit together.</td>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
