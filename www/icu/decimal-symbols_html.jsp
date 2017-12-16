<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();
	ULocale uloc = ULocale.forLocale(loc);

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Decimal Symbols")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Decimal Symbols")%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Locale")%></th>
		<th><%=_h("Decimal\u00A0Separator")%></th>
		<th><%=_h("Grouping\u00A0Separator")%></th>
		<th><%=_h("Minus\u00a0Sign")%></th>
	</tr>
<%
	ULocale[] ArrLocale = ULocale.getAvailableLocales();

	Map<String, List<ULocale>> orderMap = new TreeMap<String, List<ULocale>>();

	List<ULocale> multiOrder = new ArrayList<ULocale>();

	for (ULocale target : ArrLocale)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		out.print(h(target.getDisplayName(uloc)));
		out.print(" (");
		out.print("<a href=\"");
		out.print(h(ULocaleCache.getInstance().getNormalizedCode(target.toString())));
		out.print("/index.html\">");
		out.print(h(ULocaleCache.getInstance().getNormalizedCode(target.toString())));
		out.print("</a>");
		out.print(")");
		out.println("</td>");

		DecimalFormatSymbols dfs = DecimalFormatSymbols.getInstance(target);

		out.print("\t\t<td style=\"text-align:center;\">");
		HtmlEncoder.encode(out, dfs.getDecimalSeparator());
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		HtmlEncoder.encode(out, dfs.getGroupingSeparator());
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:center;\">");
		HtmlEncoder.encode(out, dfs.getMinusSign());
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>