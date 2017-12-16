<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.web.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	String queryString = StringUtil.isEmpty(request.getQueryString()) ? "?name=Y" : ("?" + request.getQueryString());

%><!DOCTYPE html>
<html>
<head>
<title>currencymap.json - Currency Map</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
//<![CDATA[
	$(document).ready( function()
		{
			$.ajax({
				url: "currencymap.json<%=queryString /* LATER: why doesn't this need htmlencoding? */ %>",
				dataType: 'json',
				success: onCurrencyLoad
			});
		});

	function onCurrencyLoad(data)
	{
		for (var member in data)
		{
			var currency = data[member];

			$("#datagrid").append(
				$("<tr>").append($("<td>").text(member))
					.append($("<td>").text(currency["symbol"]))
					.append($("<td>").text(currency["name"]))
					.append($("<td>").text(currency["name_plural"]))
					.append($("<td>").attr("style", "text-align:center").text(currency["decimal_digits"]))
					.append($("<td>").attr("style", "text-align:center").text(currency["rounding"]))
					);
		}
	}
//]]>
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>currencymap.json - Currency Map</h1>
		</div>
		<div class="section-header">
			<h2><%=_h("Details")%></h2>
		</div>

		<p>This is the data needed by the currency formatters.</p>
		<p>The currency formatters do not need the actual name of the currency, just the symbol.  If you need it for some other reason, request the file with the <code>name</code>
		parameter set to <code>Y</code></p>

		<div class="section-header">
			<h2><%=_h("Sample")%></h2>
		</div>
<p><a href="currencymap.json<%=h(queryString)%>">currencymap.json<%=h(queryString)%></a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<thead>
		<tr>
			<th><%=_h("Code")%></th>
			<th><%=_h("Symbol")%></th>
			<th><%=_h("Name")%></th>
			<th><%=_h("Plural")%></th>
			<th style="text-align:center;"><%=_h("Decimal\u00A0Digits")%></th>
			<th style="text-align:center;"><%=_h("Rounding")%></th>
		</tr>
	</thead>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
