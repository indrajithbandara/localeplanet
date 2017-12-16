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
<title>Normalized Locale IDs</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Normalized Locale IDs</h1>

<p>The rules for locale identifiers are specified in <a href="http://www.ietf.org/rfc/rfc4646.txt">RFC 4646</a>, and they are pretty loose: order (after the language) and capitalization don't matter.</p>

<p>However, in order to make comparisons possible, I normalize the locale identifiers to be xx-XX-Xxxx.</p>

<p>Also see <a href="http://www.unicode.org/reports/tr35/#Likely_Subtags">Unicode's Normalization Process</a>.</p>

<h2>Specific Changes</h2>

<p>Google Translate: <code>iw</code> to <code>he</code></p>

<p>ICU: underscores to dashes,
		<code>nn</code> to <code>no</code>,
		extraneous script removed if non-script version doesn't exist.
</p>

<p>Java: underscores to dashes,
		reorder script to be at the end,
		<code>iw</code> to <code>he</code>,
		<code>in</code> to <code>id</code>,
		<code>hi</code> has no language-only variant, only <code>hi-IN</code>
</p>

<p>.Net: no changes</p>



<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
