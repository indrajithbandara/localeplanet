<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	String queryString = StringUtil.isEmpty(request.getQueryString()) ? "" : ("?" + request.getQueryString());

%><!DOCTYPE html>
<html>
<head>
<title>translate.js - Text Translation</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="translate.js"></script>
<script>
//<![CDATA[
	var sampleTranslation =
		{
			"Hello, World": "Bonjour, monde",
			"one": "un",
			"two": "deux",
			"three": "trois",
			"blah": function() { return "blah blah"; },
			"private": "",	// just a sentinel so we stop the simple display loop
			"Your query matched {0} files in {1} directories.": function() {
					var files = arguments[1];
					var dirs = arguments[2];
					//console.log("files=" + files + " dirs=" + dirs + " arguments=" + JSON.stringify(Array.prototype.slice.call(arguments)));
					files = _.format("{0} {1}", files, files == 1 ? 'fichier' : 'fichiers');
					dirs = _.format("{0} {1}", dirs, dirs == 1 ? "r\u00E9pertoire" : "r\u00E9pertoires");
					//console.log("files=" + files + " dirs=" + dirs);
					return _.format("J'ai trouv\u00E9 {0} dans {1}.", files, dirs);
				},
			"end": ""
		};

	$(document).ready( function()
		{
			_.setTranslation(sampleTranslation);

			for (var sample in sampleTranslation)
			{
				if (sample == "private")
				{
					break;
				}
				addRow('_("' + sample + '")', _(sample));
			}
			for (var files = 0; files < 3; files++)
			{
				for (var dirs = 0; dirs < 3; dirs++)
				{
					addRow('_("Your query matched {0} files in {1} directories.", ' + files + ', ' + dirs + ')', _("Your query matched {0} files in {1} directories.", files, dirs));
				}
			}
		});

	function addRow(col1, col2)
	{
		$("#datagrid").append(
			$("<tr>").append($("<td>").text(col1))
				.append($("<td>").text(col2))
				);
	}

//]]>
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>translate.js - Text Translation</h1>
		</div>
<h2><%=_h("Overview")%></h2>
<p>Utility functions for dealing with text translations.</p>
<p>Note: while the default name of the translate object is <code>_</code> (underscore), you can override it by passing in an <code>object</code> parameter.</p>
<h2><%=_h("Details")%></h2>
<p><b>_.translate(text...)</b> - this is the main translate function and is also the base object (i.e. you can call <code>_(text)</code>).  Translates the first parameter.  If called with multiple parameters, it will call a &quot;format&quot; function with the 1st parameter translated followed by the additional parameters.</p>
<p><b>_.setAutoTranslator(fn)</b> - sets a function to call for text that isn't in the translation map.  By default, <code>translate()</code> will return the original text.  Some possible replacements (that you would have to write!):</p>
<ul>
	<li>try to translate it with a different default language</li>
	<li>try to translate it at runtime with a service like Google Translate</li>
	<li>send it to the server so you can log it</li>
	<li>console.log() it</li>
</ul>
<p><b>_.setFormatter(fn)</b> - sets the formatting function that is used when <code>translate()</code> is called with multiple parameters.  The default formatter
replaces squiggly-braced numbers (i.e. <code>{0}</code>) with the corresponding parameter, like a simplified version of the java <a href="http://download.oracle.com/javase/6/docs/api/java/text/MessageFormat.html">MessageFormat</a> function.  </p>
<p><b>_.setTransation(map)</b> - sets the translation map.  Usually this is a map of strings to strings, but the values can also be functions to deal with problems like <a href="http://search.cpan.org/dist/Locale-Maketext/lib/Locale/Maketext/TPJ13.pod">this</a></p>
<h2><%=_h("Usage")%></h2>
<p>The simplest usage in an application would look like:</p>
<ol>
	<li>load the translation API, using the default _ (underscore) object name:<br/>
		<code>&lt;script src=&quot;http://www.localeplanet.com/api/translate.js&quot; /&gt;&lt/script&gt;</code></li>
	<li>load the translated text.  This .js file should call <code>_.setTranslation()</code> with the map:<br/>
		<code>&lt;script src="http://www.example.com/text/en.js" /&gt;&lt;/script&gt;</code></li>
	<li>Wrap all text with a call to <code>_()</code>:<br/>
		<code>alert(_("Put your hands where I can see them!"));<br/>
			  alert(_("You have {0} lives remaining", "3"));</code></li>
</ol>
<h2><%=_h("Examples")%></h2>
<p>This example uses a French translation that is hard-coded on the page.  This isn't the preferred way to do it, but let's me demonstrate everything in
one place.</p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Call")%></th>
		<th style="text-align:left;"><%=_h("Output")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
