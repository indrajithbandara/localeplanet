<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Standards")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Standards")%></h1>
<p>Some standards relevant to localization:</p>
<ul>
	<li>ISO 639-2 Languages: <a href="http://www.loc.gov/standards/iso639-2/php/code_list.php">official list</a> | <a href="http://ftp.ics.uci.edu/pub/ietf/http/related/iso639.txt">IETF list</a> | <a href="http://en.wikipedia.org/wiki/ISO_639">Wikipedia</a> | <a href="/icu/iso639.html">LocalePlanet ICU list</a></li>
	<li>ISO 3166 Countries: <a href="http://www.iso.org/iso/list-en1-semic-3.txt">official list</a> | <a href="http://userpage.chemie.fu-berlin.de/diverse/doc/ISO_3166.html">Free University of Berlin list</a> | <a href="http://en.wikipedia.org/wiki/ISO_3166">Wikipedia</a> | <a href="iso3166.html">LocalePlanet ICU list</a></li>
	<li>ISO 15924 Scripts: <a href="http://unicode.org/iso15924/iso15924-codes.html">Unicode.org</a> | <a href="http://en.wikipedia.org/wiki/ISO_15924">Wikipedia</a></li>
	<li>RFC 4647 Matching of Language Tags : <a href="http://www.ietf.org/rfc/rfc4647.txt">official specification</a> | <a href="http://www.apps.ietf.org/rfc/rfc4647.html">html</a></li>
	<li>RFC 5646 Tags for Identifying Languages : <a href="http://www.ietf.org/rfc/rfc5646.txt">official specification</a> | <a href="http://www.apps.ietf.org/rfc/rfc5646.html">html</a></li>
	<li>BCP 47 (RFC 4647 + RFC 5646): <a href="http://www.rfc-editor.org/rfc/bcp/bcp47.txt">official specification</a> | <a href="http://en.wikipedia.org/wiki/IETF_language_tag">Wikipedia</a></li>
	<li>RFC 6067 BCP 47 Extension U: <a href="http://tools.ietf.org/html/rfc6067">official specification</a></li>
	<li>ISO 8601 Representation of dates and times
		<a href="http://en.wikipedia.org/wiki/ISO_8601">Wikipedia</a>
		| <a href="http://www.w3.org/TR/NOTE-datetime">W3C</a>
		| <a href="http://www.iso.org/iso/date_and_time_format">ISO overview</a>
	</li>
	<li>RFC 3339: Dates and times on the internet:
		<a href="http://www.ietf.org/rfc/rfc3339.txt">text</a>
		| <a href="http://www.apps.ietf.org/rfc/rfc3339.html">html</a>
	</li>
	<li>IETF Language Tag Registry:
		<a href="http://www.langtag.net/">LangTag.Net</a> | 
		<a href="http://en.wikipedia.org/wiki/IETF_language_tag">Wikipedia</a>
	</li>
</ul>
<p><%=_h("Obsolete:")%></p>
<ul>
	<li>RFC 1766 Tags for the Identification of Languages : <a href="http://www.ietf.org/rfc/rfc1766.txt">official specification</a> | <a href="http://www.apps.ietf.org/rfc/rfc1766.html">html</a></li>
	<li>RFC 3066 Tags for the Identification of Languages : <a href="http://www.ietf.org/rfc/rfc3066.txt">official specification</a> | <a href="http://www.apps.ietf.org/rfc/rfc3066.html">html</a></li>
	<li>RFC 4646 Tags for Identifying Languages : <a href="http://www.ietf.org/rfc/rfc4646.txt">official specification</a> | <a href="http://www.apps.ietf.org/rfc/rfc4646.html">html</a></li>
</ul>
<p>Also see the list of <a href="../data-sources.html">sources for locale data</a>.</p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
