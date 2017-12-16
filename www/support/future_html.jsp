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
<title>Future Plans</title>
<meta name="robots" content="noindex" />
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Future Plans</h1>

<p>This is just my to-do list.  If you have any needs/ideas/criticisms, <a href="contact.html?subject=Suggestion">let me know</a>!</p>

<p>java/xx/index.html - split time zones to separate page</p>

<p>java/xx/currency.html</p>

<p>compare/currency.html</p>

<p>Links page to pull from pinboard.in</p>

<p>Date order: <a href="/icu/date-order.html">ICU</a>, <a href="/java/date-order.html">Java</a></p>

<p>Time zones: <a href="/icu/en-US/timezone.html">ICU</a></p>

<p>Remove most calls to LocaleNormalizer.</p>

<p>Credits:</p>
<ul>
	<li>Icon and link to http://code.google.com/p/json-simple/</li>
	<li>separate page for translation: GNU GetText, polib, Google Translate (and hopefully human contributors)</li>
</ul>

<p>Change language: guess country for each language.  Advanced option that lets you enter a locale</li>

<p>Add daggars to all locale IDs that have been normalized (expect underline to dash).  Encapsulate dagger html.</p>

<p>Java: normalize! iw to he, in to id, note in normalize.html</p>

<p>Java: fill in details</p>

<p>API:</p>
<ul>
	<li>getDateFormat() with no param to return most common form</li>
	<li>NOCURRENTYEAR option for date formats</li>
	<li>currency.json</li>
	<li>drf.js - date range formatting (drop duplicate month/year)</li>
	<li>dtf.js - date+time formatting</li>
	<li>tf.js - time formatting</li>
	<li>timepat.json - time patterns</li>
	<li>langlist.json (array with multiple descriptions: browser, native, specific)</li>
	<li>units of measurement</li>
	<li>ordinal numbers - both numeric (1st), text (first) and mixed (first if short, else 101st)</li>
	<li>spelled numbers</li>
	<li>formatted strings: MessageFormat (<a href="http://closure-library.googlecode.com/svn/docs/class_goog_i18n_MessageFormat.html">closure version</a>)</li>
	<li>Date classes (see <a href="http://www.opengamma.com/blog/2011/jsr-310-experience">JSR 310</a>)</li>
</ul>

<p>API: minimized versions of js files (on the fly <a href="http://www.ioncannon.net/programming/1447/using-the-google-closure-compiler-in-java/">Google Closure compiler</a>?)</p>

<p>API: GWT library that wraps API</p>

<p>API: default country parameter</p>

<p>API: ICU lists in normalized and raw versions</p>

<p>API: should <code>auto</code> redirect instead of forward?  Slower on initial hit, but will the 2nd hit stay cached???</p>

<p>API: ability to add an &quot;edit&quot; button/link/etc if there isn't a translation</p>

<p>Data sources: resolve different codes for Tagalog (icu=fil, google=tl)</p>

<p>i18n: more language translations when supported by Google Translate: Bengali (bn), Punjabi (pa), Teluga (te), Marathi (mr), Tamil (ta).</p>

<p>i18n: how do I display languages w/translations but no Java locale: Afrikaans (af), Persian (fa), Welsh (cy), Filipino (tl)?  Maybe switch to ULocale?</p>

<p>i18n: use API to display language choices in the UI header</p>

<p>i18n: po2xx to make <a href="http://www.fileformat.info/convert/text/international.htm">testing</a> text.</p>

<p>i18n: gtrans is screwing up fancy quotes, MessageFormat stuff.</p>

<p>i18n: use gtrans for full-page translation: support/index.html, support/api.html</p>

<p>i18n: gt4po.py: if text has &lt;&gt; then pass html flag</p>

<p>i18n: gt4po.py: creating duplicate fuzzy labels</p>

<p>Website: Add <code>Vary: accept-language</code> header</p>

<p>Website: Infinite caching headers for non-auto API pages</p>

<p>Support: Collection of related links</p>

<p>Support: note about translations (and ask for volunteers)</p>

<p>gt4po.py</p>
<ul>
	<li>problems with html-escaped single quotes</li>
	<li>problems with smart quotes</li>
	<li>problems with {n} format parameters</li>
</ul>

<p>Separate python website for online .po utilities</p>
<ul>
	<li>convert po to properties</li>
	<li>convert properties to po</li>
	<li>convert po to test</li>
	<li>convert plain text to test</li>
	<li>convert html text to test</li>
</ul>

<p>Utility scripts:</p>
<ul>
	<li>lpmirror.py</li>
</ul>

<p>More data sources:</p>
<ul>
	<li>CLDR</li>
	<li>SIL</li>
	<li>Linux</li>
	<li>IANA</li>
	<li>Mozilla</li>
	<li>POSIX</li>
</ul>

<p>Compare: non-ISO languages/countries</p>

<p>Fill in the .NET data (including LCID)</p>

<p>Version info for .NET</p>

<p>Slurp data for day names, month names for Google Translate</p>

<p>Software: list locales supported by various software packages</p>
<ul>
	<li>Microsoft Windows</li>
	<li>Microsoft Office</li>
	<li>OpenOffice</li>
	<li>Ubuntu</li>
</ul>

<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
