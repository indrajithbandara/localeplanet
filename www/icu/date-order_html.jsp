<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
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
<title><%=_h("Date Order")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Date Order")%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th>Order</th>
		<th style="text-align:right;"># Locales</th>
	</tr>
<%
	ULocale[] ArrLocale = ULocale.getAvailableLocales();

	Map<String, List<ULocale>> orderMap = new TreeMap<String, List<ULocale>>();

	List<ULocale> multiOrder = new ArrayList<ULocale>();

	for (ULocale target : ArrLocale)
	{
		String order = getDateOrder(target, com.ibm.icu.text.DateFormat.SHORT);
		if (order.equals(getDateOrder(target, com.ibm.icu.text.DateFormat.MEDIUM)) == false)
		{
			multiOrder.add(target);
		}
		else if (order.equals(getDateOrder(target, com.ibm.icu.text.DateFormat.LONG)) == false)
		{
			multiOrder.add(target);
		}
		else if (order.equals(getDateOrder(target, com.ibm.icu.text.DateFormat.FULL)) == false)
		{
			multiOrder.add(target);
		}
		List<ULocale> theList = orderMap.get(order);
		if (theList == null)
		{
			theList = new ArrayList<ULocale>();
			orderMap.put(order, theList);
		}
		theList.add(target);
	}

	for (String key: orderMap.keySet())
	{
		out.println("\t<tr>");

		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(key));
		out.println("</td>");

		out.print("\t\t<td style=\"text-align:right;\">");
		out.print("<span style=\"text-decoration:dash;\" title=\"");
		ULocale[] ArrOrder = orderMap.get(key).toArray(new ULocale[0]);
		Arrays.sort(ArrOrder, ULocaleCodeComparator.getInstance());
		for (ULocale target: ArrOrder)
		{
			out.print(h(target.toString()));
			out.print("\u00A0-\u00A0");
			out.print(h(target.getDisplayName(uloc)));
			out.print("\u00A0\n");
		}
		out.print("\">");
		out.print(orderMap.get(key).size());
		out.print("</span>");
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<h2>Locales with different orders for different format lengths:</h2>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;">Locale</th>
		<th>Short</th>
		<th>Medium</th>
		<th>Long</th>
		<th>Full</th>
	</tr>
<%
	ULocale[] ArrMulti = multiOrder.toArray(new ULocale[ multiOrder.size() ]);
	Arrays.sort(ArrMulti, ULocaleCodeComparator.getInstance());
	for (ULocale target: ArrMulti)
	{
		out.print("\t<tr>");
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
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, com.ibm.icu.text.DateFormat.SHORT)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, com.ibm.icu.text.DateFormat.MEDIUM)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, com.ibm.icu.text.DateFormat.LONG)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, com.ibm.icu.text.DateFormat.FULL)));
		out.println("</td>");
		out.println("</tr>");
	}
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	public String getDateOrder(ULocale target, int format)
	{
		com.ibm.icu.text.DateFormat df = null;
		try
		{
			df = com.ibm.icu.text.DateFormat.getDateInstance(format, target);
		}
		catch (Throwable t)
		{
			return t.getMessage();
		}

		if (df == null)
		{
			return "(null)";
		}

		if (df instanceof com.ibm.icu.text.SimpleDateFormat == false)
		{
			return df.getClass().getName();
		}

		String pattern = ((com.ibm.icu.text.SimpleDateFormat)df).toPattern();

		String pure = pattern.replaceAll("([^Mdy]|^)*([Mdy])([^Mdy])*", "$2");

		int year = pure.indexOf('y');
		int month = pure.indexOf('M');
		int day = pure.indexOf('d');

		if (year == -1 || month == -1 || day == -1)
		{
			return  pure;
		}
		else if (year < month && month < day)
		{
			return "YMD";
		}
		else if (month < day && day < year)
		{
			return "MDY";
		}
		else if (day < month && month < year)
		{
			return "DMY";
		}
		else if (year < day && day < month)
		{
			return "YDM";
		}

		return pure;
	}
%>