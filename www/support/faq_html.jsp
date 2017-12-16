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
<title>LocalePlanet FAQ</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<style type="text/css">
.question { font-weight: bold; margin-top: 10pt; margin-bottom: 5pt;}
.answer { margin-left: 20pt; }
</style>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>LocalePlanet FAQ</h1>

<div class="question">Where did you get the data?</div>
<div class="answer">See the <a href="../data-sources.html">data sources</a> page!</div>

<div class="question">What tools did you use to build LocalePlanet?</div>
<div class="answer">Check out the <a href="credits.html">credits</a> page for a complete list.  There are also a couple custom <a href="tools.html">translation utility programs</a> that I made that
you can use.</div>

<div class="question">What is locale information is my browser reporting?</div>
<div class="answer">Check our <a href="browser.html">browser info</a> page.</div>

<div class="question">Something is wrong/missing.  Can you fix it?</div>
<div class="answer">I cannot change the original sources.  If you let me know, I will pass on the information, and hopefully 
the original source will fix it and it will eventually trickle down.<br/><br/>
If a translation is wrong (quite likely, since it is all machine-translation), don't say anything unless you are volunteering to do the
translation!<br/><br/>
If something is not displaying correctly, try the <a href="http://demo.icu-project.org/icu-bin/locexp/en/_/help.html#display">ICU's display troubleshooting tips</a>.
If that does not work, <a href="contact.html">let me know</a>!</div>

<div class="question">Non-latin characters looks like gibberish.  What's wrong?</div>
<div class="answer">I do everything in UTF-8.  If your environment does not use (or transparently convert) UTF-8, you are not going to be able to use the API.</div>

<div class="question">There are a million JavaScript libraries that do this.  Why reinvent the wheel?</div>
<div class="answer">I looked at the <a href="alternatives.html">alternatives</a> and did not find one that did what I wanted.</div>

<div class="question">What are you planning to do next?</div>
<div class="answer">Check out the <a href="future.html">upcoming features</a> page.</div>

<div class="question">How do I contact you?</div>
<div class="answer">Fill out the form on the <a href="contact.html">contact</a> page.</div>

<!--
<div class="question"></div>
<div class="answer"></div>

-->

</ul>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>