<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 java.util.regex.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();
	ULocale uloc = ULocale.forLocale(loc);

	String title = _("ICU Currency Patterns");

	String url = UrlUtil.getLocalUrl(request);

%><!DOCTYPE html>
<html>
<head>
<title><%=h(title)%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
	<div class="page-header">
		<h1><%=h(title)%></h1>
	</div>

<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th>Locale</th>
			<th style="text-align:center;">Pattern</th>
			<th style="text-align:center;">Positive prefix</th>
			<th style="text-align:center;">Positive suffix</th>
			<th style="text-align:center;">Negative prefix</th>
			<th style="text-align:center;">Negative suffix</th>
		</tr>
	</thead>
	<tbody>
<%
	ULocale[] ArrLocale = ULocale.getAvailableLocales();

	Arrays.sort(ArrLocale, ULocaleCodeComparator.getInstance());

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t\t<tr>");

		out.print("\t\t\t<td><a href=\"");
		out.print(UrlUtil.encode(ULocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString())));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, ArrLocale[loop].toString());
		out.println("</a></td>");


		NumberFormat nf = null;
		try
		{
			nf = NumberFormat.getCurrencyInstance(ArrLocale[loop]);
		}
		catch (Exception e)
		{
			out.print("\t\t\t<td colspan=\"6\">");
			out.print(h("EXCEPTION: " + e.getMessage()));
			out.println("</td>");
			continue;
		}

		if (nf instanceof DecimalFormat)
		{
			String pat = ((DecimalFormat)nf).toPattern();
			out.print("\t\t\t<td style=\"text-align:center;\">");
			out.print(h(pat));
			out.println("</td>");

			int semicolon = pat.indexOf(';');

			String[] positive = getBeforeAfter(semicolon == -1 ? pat : pat.substring(0, semicolon));

			out.print("\t\t\t<td style=\"text-align:center;\"><code>");
			out.print(h(positive[0]));
			out.println("</code></td>");
			out.print("\t\t\t<td style=\"text-align:center;\"><code>");
			out.print(h(positive[1]));
			out.println("</code></td>");
			if (semicolon == -1)
			{
				out.print("\t\t\t<td colspan=\"2\" style=\"text-align:center;\">");
				out.print(_h("Same as positive"));
				out.println("</td>");
			}
			else
			{
				String[] negative = getBeforeAfter(pat.substring(semicolon+1, pat.length()));

				out.print("\t\t\t<td style=\"text-align:center;\"><code>");
				out.print(h(negative[0]));
				out.println("</code></td>");
				out.print("\t\t\t<td style=\"text-align:center;\"><code>");
				out.print(h(negative[1]));
				out.println("</code></td>");
			}
		}
		else
		{
			out.print("\t\t\t<td colspan=\"6\">");
			out.print(h("ERROR: unknown class " + nf.getClass().getName()));
			out.println("</td>");
		}


		out.println("\t\t</tr>");
	}
%>
	</tbody>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	static private Pattern amountPattern = Pattern.compile("^([^#]*)([#,.05]+)(.*)$");

	static private String[] getBeforeAfter(String pattern)
	{
		String[] retVal = new String[2];

		Matcher m = amountPattern.matcher(pattern);

		if (m.matches() == false)
		{
			retVal[0] = "ERROR";
			retVal[1] = "Pattern does not match";
			return retVal;
		}

		retVal[0] = m.group(1);
		retVal[1] = m.group(3);

		return retVal;
	}
%>
