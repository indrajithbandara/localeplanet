<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
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
<title>datepat.json - Date Patterns</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script>
	$(document).ready( function()
		{
			$.ajax({
				url: "datepat.json<%=queryString /* LATER: why doesn't this need htmlencoding? */ %>",
				dataType: 'json',
				success: onDatePatternLoad
			});
		});

	function onDatePatternLoad(data)
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
			<h1>datepat.json - Date Patterns</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>This is a map of codes to date patterns.  You should not hard-code specific patterns: instead, use this map to get the appropriate pattern for the user's locale.</p>
<p>The code consists of a base pattern code and modifier codes separated by underscores.</p>
<p>Base code is one of <code>SHORT</code>, <code>MEDIUM</code>, <code>LONG</code> and <code>FULL</code>.</p>
<p>Modifier codes are:</p>
<ul>
	<li>CENTURY - use a 4-digit year.  <a href="?pat=SHORT,SHORT_CENTURY">example</a></li>
	<li>NODAY - skip the day portion.  <a href="?pat=SHORT,SHORT_NODAY,MEDIUM,MEDIUM_NODAY,LONG,LONG_NODAY,FULL,FULL_NODAY">example</a></li>
	<li>NOYEAR - skip the year portion. <a href="?pat=SHORT,SHORT_NOYEAR,MEDIUM,MEDIUM_NOYEAR,LONG,LONG_NOYEAR,FULL,FULL_NOYEAR">example</a></li>
	<li>PADDED - pad the day and month to two digits.  <a href="?pat=SHORT,SHORT_PADDED">example</a></li>
	<li>WEEKDAY - add the short version of the day of the week <a href="?pat=SHORT,SHORT_WEEKDAY,MEDIUM,MEDIUM_WEEKDAY,LONG,LONG_WEEKDAY,FULL,FULL_WEEKDAY">example</a></li>
</ul>
<p>The patterns are from Java's <a href="http://download.oracle.com/javase/6/docs/api/java/text/SimpleDateFormat.html">java.text.SimpleDateFormat</a>.</p>
<p>You can use more &quot;JavaScript-style&quot; codes: lower-case with colon (':') separators.</p>
<p>You can view the results across available locales on the <a href="/compare/date-pattern.html">Compare Date Patterns</a> page.</p>
<h2><%=_h("Sample")%></h2>
<p><a href="datepat.json<%=h(queryString)%>">datepat.json<%=h(queryString)%></a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Field")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
