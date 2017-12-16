<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String queryString = StringUtil.isEmpty(request.getQueryString()) ? "" : ("?" + request.getQueryString());


%><!DOCTYPE html>
<html>
<head>
<title>df.js - Date Format Functions</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
	$(document).ready( function()
		{
			$.ajax({
				url: "dfs.json",
				dataType: 'json',
				success: onDFSLoaded
			});

		});

	function onDFSLoaded(data)
	{
		// normally dfs and the function are part of the i18n object, but hack onto window just for this demo page
		window.dfs = data;
		loadDateFormats();
	}

	function loadDateFormats()
	{
		var codes = <%=JSONValue.toJSONString(Arrays.asList(DatePatternUtil.getDefaultCodes()))%>;
		for (var index = 0; index < codes.length; index++)
		{
			var code = codes[index];

			$.ajax({
				url: "df.js?object=window&pat=" + code,
				dataType: 'text',
				success: makeDateFormatLoad(code)
			});
		}
		var codes = <%

			List<String> jsCodes = new ArrayList<String>();
			for (String code: DatePatternUtil.getDefaultCodes())
			{
				jsCodes.add(DatePatternUtil.codeToJS(code));
			}

			out.print(JSONValue.toJSONString(jsCodes));

		%>;
		for (var index = 0; index < codes.length; index++)
		{
			var code = codes[index];

			$.ajax({
				url: "df.js?object=window&pat=" + code,
				dataType: 'text',
				success: makeDateFormatLoad(code)
			});
		}
	}

	function makeDateFormatLoad(code)
	{
		return function(data)
			{
				var tr = document.createElement("tr");
				var col1 = document.createElement("td");
				col1.appendChild(document.createTextNode(code));
				var col2 = document.createElement("td");
				col2.appendChild(document.createTextNode(data));

				eval("var fn = " + data + ";");
				var col3 = document.createElement("td");
				col3.appendChild(document.createTextNode(fn(new Date())));

				tr.appendChild(col1);
				tr.appendChild(col2);
				tr.appendChild(col3);

				$("#datagrid").append(tr);
			};
	}
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>df.js - Date Format Functions</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>Builds a JavaScript function that formats a date.</p>
<p>Ideally, use a format code (see <a href="datepat.html">datepat.json</a>) to select how verbose the output should be.</p>
<p>You can also use a raw pattern, but then you will have to translate the pattern for each locale you support.</p>
<p>NOTE: Versions with names (vs numbers) require <a href="dfs.html">date format symbols</a>.</p>
<h2><%=_h("Sample")%></h2>
<p><a href="df.js<%=h(queryString)%>">df.js<%=h(queryString)%></a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Pattern")%></th>
		<th style="text-align:left;"><%=_h("Function")%></th>
		<th style="text-align:left;"><%=_h("Output")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
