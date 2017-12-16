<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.ibm.icu.util.Currency,
				 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

%><!DOCTYPE html>
<html>
<head>
<title>ICU Currencies</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
	<div class="page-header">
		<h1>ICU Currencies</h1>
	</div>

<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="text-align:center;">Currency Code</th>
			<th>Display Name</th>
			<th style="text-align:center;">Symbol</th>
			<th style="text-align:center;">Default Fraction Digits</th>
			<th style="text-align:center;">Rounding Increment</th>
			<th style="text-align:center;">ISO 4217 Code</th>
		</tr>
	</thead>
	<tbody>
<%
	Currency[] ArrCurrency = Currency.getAvailableCurrencies().toArray(new Currency[0]);
	Arrays.sort(ArrCurrency, new CurrencyComparator());
	for (Currency theCurrency: ArrCurrency)
	{
		out.println("\t<tr>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(theCurrency.getCurrencyCode()));
		out.println("</td>");

		out.print("\t\t<td>");
		out.print(h(theCurrency.getDisplayName()));
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(theCurrency.getSymbol(loc)));
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(theCurrency.getDefaultFractionDigits());
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(theCurrency.getRoundingIncrement() );
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(theCurrency.getNumericCode());
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
	</tbody>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	class CurrencyComparator
		implements Comparator<Currency>
	{
		public int compare(Currency a, Currency b)
		{
			return a.getCurrencyCode().compareTo(b.getCurrencyCode());
		}
	}
%>
