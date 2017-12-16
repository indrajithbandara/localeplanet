<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
				 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String queryString = StringUtil.isEmpty(request.getQueryString()) ? "" : ("?" + request.getQueryString());

%><!DOCTYPE html>
<html>
<head>
<title>icu.js - International Components for JavaScript!</title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="icu.js<%=h(queryString)%>"></script>
<script>
	$(document).ready( function()
		{
			showMembers(icu);
			showDemo();
		});

	function showMembers(data)
	{
		for (var member in data)
		{
			col1 = member;
			coltype = typeof data[member];

			if (coltype == "function")
			{
				col2 = data[member].length;
				try
				{
					col3 = data[member].call();
					if (typeof col3 == "object")
					{
						col3 = JSON.stringify(col3);		//LATER: if object w/methods, show them
					}
				}
				catch (err)
				{
					col3 = "ERROR: " + err.description;
				}
			}
			else
			{
				col2 = coltype;
				col3 = "";
			}



			$("#datagrid").append(
				$("<tr>").append($("<td>").text(col1))
					.append($("<td>").attr("style", "text-align:center").text(col2))
					.append($("<td>").text(col3))
					);
		}
	}

	function showDemo()
	{
		var today = new Date();

		for (var df in icu.getDateFormats())
		{
			addRow("#demogrid", "getDateFormat('" + df + "').format(today)", icu.getDateFormat(df).format(today));
		}

		var testInts = [ -1000, -100, -1, 0, 1, 100, 1000, 100000, 100000000, 1000000000 ];

		for (var loop = 0; loop < testInts.length; loop++)
		{
			var i = testInts[loop];
			addRow("#demogrid", "getIntegerFormat().format(" + i.toString() + ")", icu.getIntegerFormat().format(i));
		}

		for (var loop = 0; loop < testInts.length; loop++)
		{
			var n = testInts[loop] + (testInts[loop] > 0 ? 0.1 : -0.1);
			addRow("#demogrid", "getDecimalFormat(2).format(" + n.toString() + ")", icu.getDecimalFormat(2).format(n));

			n = testInts[loop] + (testInts[loop] > 0 ? 0.9 : -0.9);
			addRow("#demogrid", "getDecimalFormat(2).format(" + n.toString() + ")", icu.getDecimalFormat(2).format(n));
		}
		addRow("#demogrid", "getDecimalFormat(2).format(0)", icu.getDecimalFormat(2).format(0));
	}

	function addRow(grid, text1, text2)
	{
		$(grid).append($("<tr>").append($("<td>").text(text1)).append($("<td>").text(text2)));
	}

</script>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
		<div class="page-header">
			<h1>icu.js - International Components for JavaScript!</h1>
		</div>
<h2><%=_h("Details")%></h2>
<p>This will create member methods that can be used for formatting dates and numbers.  Coming soon: times and currency amounts.</p>
<p>You specify the name of the object by passing an <code>object</code> parameter.  The default object is <code>window.icu</code>. For example, if you are using jQuery, you
could include it as <code>icu.js?object=window.$</code>.</p>
<p>You can add additional <a href="datepat.html">date pattern codes</a> by passing in a <code>datepat</code> parameter with a comma-separated list of date pattern codes.
<a href="icu.html?datepat=MEDIUM_NODAY,FULL_NOYEAR">example</a></p>
<h2><%=_h("Demo")%></h2>
<table class="table table-bordered table-striped" id="demogrid">
	<tr>
		<th style="text-align:left;"><%=_h("Call")%></th>
		<th style="text-align:left;"><%=_h("Result")%></th>
	</tr>
</table>
<h2>Actual Object</h2>
<p><a href="icu.js">icu.js</a></p>
<table class="table table-bordered table-striped" id="datagrid">
	<tr>
		<th style="text-align:left;"><%=_h("Name")%></th>
		<th style="text-align:left;"><%=_h("Arguments")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
