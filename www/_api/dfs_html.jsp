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
<title>dfs.json - Date Format Symbols</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
	$(document).ready( function()
		{
			$.ajax({
				url: "dfs.json",
				dataType: 'json',
				success: onDfsLoad
			});
		});

	function onDfsLoad(data)
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
			<h1>dfs.json - Date Format Symbols</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>Used for <a href="df.html">date formatting</a>.</p>
<p>Note: the weekday arrays starts at 0 like JavaScript, but unlike Java and ICU.</p>
<h2><%=_h("Sample")%></h2>
<p><a href="dfs.json">dfs.json</a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Field")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
