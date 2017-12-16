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
<title>LocalePlanet API</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>LocalePlanet API</h1>
		</div>

<p>See the <a href="/support/api.html">API FAQ</a> for common parameters and help.</p>

<p>See <a href="/support/howto-localize-js.html">How to localize a JavaScript application</a> for an overview of how everything fits together.</p>

<div class="section-header">
	<h2>High-level API</h2>
</div>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="text-align:left;"><%=_h("File name")%></th>
			<th style="text-align:left;"><%=_h("Description")%></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><a href="auto/icu.html">icu.js</a></td>
			<td>International Components for JavaScript: all the functions for a single locale.</td>
		</tr>
		<tr>
			<td><a href="auto/langmap.html">langmap.json</a></td>
			<td>Language map: list available languages.  Perfect for making a simple drop-down language picker.</td>
		</tr>
		<tr>
			<td><a href="translate.html">translate.js</a></td>
			<td>Text translation functions</td>
		</tr>
	</tbody>
</table>

<div class="section-header">
	<h2>Low-level API</h2>
</div>
<p>You should not need to use these directly, but they are useful for understanding how the main API works.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("File\u00A0name")%></th>
		<th style="text-align:left;"><%=_h("Description")%></th>
	</tr>
	<tr>
		<td><a href="codelist.html">codelist.json</a></td>
		<td>Locale code list: loop through all the available locales</td>
	</tr>
	<tr>
		<td><a href="auto/currencymap.html">currencymap.json</a></td>
		<td>Currency data map: currency data</td>
	</tr>
	<tr>
		<td><a href="auto/df.html">df.js</a></td>
		<td>Date format: date formatting functions</td>
	</tr>
	<tr>
		<td><a href="auto/datepat.html">datepat.json</a></td>
		<td>Date patterns: date format patterns</td>
	</tr>
	<tr>
		<td><a href="auto/dfs.html">dfs.json</a></td>
		<td>Date format symbols: do your own date formatting or data entry widget</td>
	</tr>
	<tr>
		<td><a href="auto/info.html">info.json</a></td>
		<td>Info: figure out which locale is being used</td>
	</tr>
	<tr>
		<td><a href="auto/nfs.html">nfs.json</a></td>
		<td>Number format symbols: do your own number formatting</td>
	</tr>
</table>
<div class="section-header">
	<h2>Experimental APIs</h2>
</div>
<p>Not ready for production use.</p>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("File\u00A0name")%></th>
		<th style="text-align:left;"><%=_h("Description")%></th>
	</tr>
	<tr>
		<td><a href="time.html">time.js</a></td>
		<td>Time utility functions</td>
	</tr>
	<tr>
		<td><a href="auto/gae-country.html">gae-country.json</a></td>
		<td>Country as determined by Google AppEngine</td>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
