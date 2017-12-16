<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

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
	Locale[] ArrLocale = Locale.getAvailableLocales();

	Map<String, List<Locale>> orderMap = new TreeMap<String, List<Locale>>();

	List<Locale> multiOrder = new ArrayList<Locale>();

	for (Locale target : ArrLocale)
	{
		String order = getDateOrder(target, DateFormat.SHORT);
		if (order.equals(getDateOrder(target, DateFormat.MEDIUM)) == false)
		{
			multiOrder.add(target);
		}
		else if (order.equals(getDateOrder(target, DateFormat.LONG)) == false)
		{
			multiOrder.add(target);
		}
		else if (order.equals(getDateOrder(target, DateFormat.FULL)) == false)
		{
			multiOrder.add(target);
		}
		List<Locale> theList = orderMap.get(order);
		if (theList == null)
		{
			theList = new ArrayList<Locale>();
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
		Locale[] ArrOrder = orderMap.get(key).toArray(new Locale[0]);
		Arrays.sort(ArrOrder, LocaleCodeComparator.getInstance());
		for (Locale target: ArrOrder)
		{
			out.print(h(target.toString()));
			out.print("\u00A0-\u00A0");
			out.print(h(target.getDisplayName(loc)));
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
	Locale[] ArrMulti = multiOrder.toArray(new Locale[ multiOrder.size() ]);
	Arrays.sort(ArrMulti, LocaleCodeComparator.getInstance());
	for (Locale target: ArrMulti)
	{
		out.print("\t<tr>");
		out.print("\t\t<td>");
		out.print(h(target.getDisplayName(loc)));
		out.print(" (");
		out.print("<a href=\"");
		out.print(h(LocaleCache.getInstance().getNormalizedCode(target.toString())));
		out.print("/index.html\">");
		out.print(h(LocaleCache.getInstance().getNormalizedCode(target.toString())));
		out.print("</a>");
		out.print(")");
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, DateFormat.SHORT)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, DateFormat.MEDIUM)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, DateFormat.LONG)));
		out.println("</td>");
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print(h(getDateOrder(target, DateFormat.FULL)));
		out.println("</td>");
		out.println("</tr>");
	}
%>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	public String getDateOrder(Locale target, int format)
	{
		DateFormat df = DateFormat.getDateInstance(format, target);

		if (df == null)
		{
			return "(null)";
		}

		if (df instanceof SimpleDateFormat == false)
		{
			return df.getClass().getName();
		}

		String pattern = ((SimpleDateFormat)df).toPattern();

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