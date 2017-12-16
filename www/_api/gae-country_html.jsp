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

	Locale loc = Localizer.getLocale();

%><!DOCTYPE html>
<html>
<head>
<title>gae-country.json</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
	$(document).ready( function()
		{
			$.ajax({
				url: "gae-country.json",
				dataType: 'json',
				success: onInfoLoad
			});
		});

	function onInfoLoad(data)
	{
		for (var member in data)
		{
			var tr = document.createElement("tr");
			var col1 = document.createElement("td");
			col1.appendChild(document.createTextNode(member));
			var col2 = document.createElement("td");
			col2.appendChild(document.createTextNode(data[member]));

			tr.appendChild(col1);
			tr.appendChild(col2);

			$("#datagrid").append(tr);
		}
	}
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>gae-country.json</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>Google AppEngine (v1.5.1 or later) adds a request header <code>X-AppEngine-Country</code> to every request.  This is just a little helper
JSON script so you can incorporate Google's country-determination database into your own JavaScript application.</p>
<h2><%=_h("Sample")%></h2>
<p><a href="gae-country.json">gae-country.json</a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Field")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
