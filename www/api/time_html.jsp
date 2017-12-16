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
<title>time.js - JavaScript Time</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="time.js"></script>
<script src="auto/icu.js"></script>
<script>
//<![CDATA[
	$(document).ready( function()
		{
			var ArrIso = [ "000000", "123159", "233159", "010203", "040506" ];
			var nf = icu.getIntegerFormat();

			for (var loop = 0; loop < ArrIso.length; loop++)
			{
				addRow("isoToMillis", ArrIso[loop], nf.format(isoToMillis(ArrIso[loop])));
			}

			for (var loop = 0; loop < ArrIso.length; loop++)
			{
				addRow("isoToTime", ArrIso[loop], timeToJson(isoToTime(ArrIso[loop])));
			}

			var current = new Date();
			addRow("new Date()", "", current.toString());
			addRow("new Date().getTime()", "", nf.format(current.getTime()));
			addRow("millisToTime", nf.format(current.getTime()), timeToJson(millisToTime(current.getTime())));
		});

	function addRow(col1, col2, col3)
	{
		$("#datagrid").append(
			$("<tr>").append($("<td>").text(col1))
				.append($("<td>").text(col2))
				.append($("<td>").text(col3))
				);
	}

	function timeToJson(timeObj)
	{
		return "{hours: " + timeObj.getHours() + ", minutes: " + timeObj.getMinutes() + ", seconds: " + timeObj.getSeconds() + "}";
	}

//]]>
</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>time.js - JavaScript Time</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>Utility functions for dealing with time.  Working, but the design is not finalized.</p>
<p>Note: this time does not have any notion of time zones.  Be careful converting to/from JavaScript dates, which do know about time zones.</p>
<h2><%=_h("Sample")%></h2>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Function")%></th>
		<th style="text-align:left;"><%=_h("Input")%></th>
		<th style="text-align:left;"><%=_h("Output")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
