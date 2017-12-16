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
<title>langmap.json - Language Map</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
//<![CDATA[
	$(document).ready( function()
		{
			$.ajax({
				url: "langmap.json<%=queryString /* LATER: why doesn't this need htmlencoding? */ %>",
				dataType: 'json',
				success: onLanguageLoad
			});
		});

	function onLanguageLoad(data)
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
//]]>
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>langmap.json - Language Map</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>To list only a few languages, add a <code>lang</code> parameter with a comma-separated list to filter to just those languages.  <a href="langmap.html?lang=es,en,fr">Try it</a>!</p>
<p>To display the language names in their native language, pass <code>native=Y</code>.  <a href="langmap.html?native=Y&lang=en,ar,th,zh">Try it</a>!</p>
<h2><%=_h("Sample")%></h2>
<p><a href="langmap.json<%=h(queryString)%>">langmap.json<%=h(queryString)%></a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Field")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
