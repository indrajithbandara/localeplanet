<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.ibm.icu.util.Currency,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.dotnet.*,
		 		 com.localeplanet.google.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	Set<Currency> currencies = new LinkedHashSet<Currency>();

	currencies.add(Currency.getInstance("USD"));
	currencies.add(Currency.getInstance("EUR"));
	currencies.add(Currency.getInstance("GBP"));
	currencies.add(Currency.getInstance("JPY"));
	currencies.add(Currency.getInstance(loc));

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Compare Currency Patterns")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Compare Currency Patterns")%></h1>
<!--<p>See the <a href="/api/auto/">xxx API</a> for documentation on pattern codes.</p>-->
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Locale")%></th>
<% for (Currency theCurrency : currencies) { %>
		<th style="text-align:right;"><%=h(theCurrency.getName(loc, Currency.LONG_NAME, new boolean[] { false, false }))%></th>
<% } %>
	</tr>
<%

	Locale[] ArrLocale = Locale.getAvailableLocales();
	Arrays.sort(ArrLocale, LocaleNameComparator.getInstance(loc));

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getDisplayName(loc));
		out.print(" (");
		out.print("<a href=\"");
		out.print(UrlUtil.encode(LocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString())));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, LocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString()));
		out.print("</a>");
		out.print(")");
		out.println("</td>");

		for (Currency theCurrency: currencies)
		{
			NumberFormat nf = NumberFormat.getCurrencyInstance(ArrLocale[loop]);
			nf.setCurrency(theCurrency);
			out.print("\t\t<td>");
			out.print(h(nf.format(1234.56)));
			out.println("</td>");
		}

		out.println("\t</tr>");
	}

%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
