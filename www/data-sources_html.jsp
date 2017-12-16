<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
				 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><!DOCTYPE html>
<html>
<head>
<title>Locale Data Sources</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Data Sources</h1>

<p>These are the data sources for all the data on LocalePlanet: <a href="/compare/index.html">Compare them</a>!</p>

<table class="plain" cellpadding="10" width="100%">
	<tr>
		<td align="center"><a href="/icu/index.html"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/icu.png" alt="ICU logo" /></a></td>
		<td>The <a href="/icu/index.html">ICU data</a> is from IBM's <a href="http://www.icu-project.org/">ICU Project</a> (<a href="/icu/license.html">license</a>).  The list comes from
		<code><a href="http://icu-project.org/apiref/icu4j/com/ibm/icu/util/ULocale.html">com.ibm.icu.util.locale.ULocale</a>.getAvailableLocales()</code> in
		ICU4J version <%=h(com.ibm.icu.util.VersionInfo.ICU_VERSION.toString())%>.  They actually have their own <a href="http://demo.icu-project.org/icu-bin/locexp/locexp">Locale Explorer</a>
		for browsing the low-level ICU locale data.</td>
		<td align="center"><a href="http://www.ibm.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/ibm.png" alt="IBM" /></a></td>
	</tr>
	<tr>
		<td colspan="3"><hr/></td>
	</tr>
	<tr>
		<td align="center"><a href="/java/index.html"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/java.png" alt="Oracle" /></a></td>
		<td>The <a href="/java/index.html">Java data</a> is from <a href="http://www.java.com/">Java</a>.  The list comes from
		<code><a href="http://download.oracle.com/javase/6/docs/api/java/util/Locale.html">java.util.Locale</a>.getAvailableLocales()</code> in version <%=h(System.getProperty("java.version"))%> from  <%=h(System.getProperty("java.vendor"))%>.
		It should match the <a href="http://www.oracle.com/technetwork/java/javase/locales-137662.html">official list</a>.</td>
		<td align="center"><a href="http://www.java.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/oracle.png" alt="Oracle" /></a></td>
	</tr>
	<tr>
		<td colspan="3"><hr/></td>
	</tr>
	<tr>
		<td align="center"><a href="/dotnet/index.html"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/dotnet.png" alt="Microsoft" /></a></td>
		<td>The <a href="/dotnet/index.html">.NET data</a> is from Microsoft's <a href="http://www.microsoft.com/net/">.NET framework</a>.  The list comes from
		<a href="http://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx">System.Globalization.CultureInfo</a>.GetCultures()</code> and should match the
		lists documented <a href="http://msdn.microsoft.com/en-us/goglobal/bb896001.aspx">here</a> and <a href="http://authors.aspalliance.com/aspxtreme/sys/globalization/demos/CultureInfo.aspx">here</a>.
		</td>
		<td align="center"><a href="http://www.microsoft.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/microsoft.png" alt="Microsoft" /></a></td>
	</tr>
	<tr>
		<td colspan="3"><hr/></td>
	</tr>
	<tr>
		<td align="center"><a href="/google-translate/index.html"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/google-translate.png" alt="Google" /></a></td>
		<td>The <a href="/google-translate/index.html">Google Translate data</a> is from (obviously) <a href="http://translate.google.com/">Google Translate</a> (as documented <a href="http://code.google.com/apis/ajaxlanguage/documentation/reference.html#LangNameArray">here</a>).</td>
		<td align="center"><a href="http://www.google.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/google.png" alt="Google" /></a></td>
	</tr>
	<tr>
		<td colspan="3"><hr/></td>
	</tr>
	<tr>
		<td colspan="3">Find <a href="/compare/missing.html">missing locales</a> in each source.</td>
	</tr>
</table>

<h2>Other data sources</h2>
<p>These are some additional sources that may one day be supported.</p>
<table class="plain" cellpadding="10" width="100%">
	<tr>
		<td align="center"><a href="http://joda.sourceforge.net/">Joda.org</a></td>
		<td>Stephen Colebourne's <a href="http://joda-time.sourceforge.net/index.html">Joda Time</a>, <a href="http://joda-time.sourceforge.net/contrib/i18n/index.html">Joda Time i18n</a> and <a href="http://joda-money.sourceforge.net/index.html">Joda Money</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://www.ethnologue.com/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/ethnologue.png" alt="Ethnologue" /></a></td>
		<td><a href="http://www.sil.org/">SIL</a>'s <a href="http://www.ethnologue.com/codes/default.asp">Ethnologue code tables</a>.</td>
	</tr>
	<tr>
		<td align="center"><a href="http://cldr.unicode.org/"><img style="border: 0pt none ; vertical-align: middle;" src="/images/badge/unicode-cldr.png" alt="CLDR" /></a></td>
		<td><a href="http://www.unicode.org/">Unicode Consortium</a>'s <a href="http://cldr.unicode.org/">Common Locale Data Repository</a> (aka CLDR).</td>
	</tr>
</table>
<p>Also see the list of <a href="/support/standards.html">standards applicable to localization</a>.</p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
