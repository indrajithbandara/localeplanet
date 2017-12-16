<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%@ include file="param.inc" %><%

	ULocale uloc = ULocale.forLocale(loc);

	String htmlTitle = h(MessageFormat.format("ICU Locale \u201C{0}\u201D ({1})", target.getDisplayNameWithDialect(uloc), target.toString()));

%><!DOCTYPE html>
<html>
<head>
<title><%=htmlTitle%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=htmlTitle%></h1>
<h2><%=_h("General Information")%></h2>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Property")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
	<tr>
		<td valign="top"><%=_h("Base locale ID")%></td>
		<td><%=h(target.getBaseName())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Language")%></td>
		<td><a href="../iso639.html#<%=h(target.getLanguage())%>"><%=h(target.getLanguage())%></a></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Country")%></td>
		<td><% if (StringUtil.isEmpty(target.getCountry())) { out.print(_h("(none)")); } else { %><a href="../iso3166.html#<%=h(target.getCountry())%>"><%=h(target.getCountry())%></a><% } %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Display name")%></td>
		<td><%=h(target.getDisplayName(uloc))%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Display name with dialect")%></td>
		<td><%=h(target.getDisplayNameWithDialect(uloc))%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Character orientation")%></td>
		<td><%=h(target.getCharacterOrientation())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Line orientation")%></td>
		<td><%=h(target.getLineOrientation())%></td>
	</tr>
	<tr>
		<td valign="top">ISO 639-2/T language code</td>
		<td><%=h(target.getISO3Language())%></td>
	</tr>
	<tr>
		<td valign="top">Java Locale</td>
		<td><%
			if (LocaleCache.getInstance().getExact(localeCode) == null)
			{
				out.print("<i>");
				out.print(_h("(no exact match)"));
				out.print("</i>");
			}
			else
			{
				out.print("<a href=\"/java/");
				out.print(h(localeCode));
				out.print("/index.html\">");
				out.print(h(localeCode));
				out.print("</a>");
			}
			%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Other data sources")%></td>
		<td><a href="/compare/<%=UrlUtil.encode(localeCode)%>/index.html"><%=_h("compare")%></a></td>
	</tr>
</table>
<h2><%=_h("Numbers")%></h2>
<%	DecimalFormatSymbols nfs = DecimalFormatSymbols.getInstance(target); %>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Property")%></th>
		<th style="text-align:left;"><%=_h("Value")%></th>
	</tr>
	<tr>
		<td valign="top"><%=_h("Currency symbol")%></td>
		<td><%=h(nfs.getCurrencySymbol())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Decimal separator")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getDecimalSeparator()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Digit")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getDigit()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Exponent separator")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getExponentSeparator()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Grouping separator")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getGroupingSeparator()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Infinity")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getInfinity()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("International currency symbol")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getInternationalCurrencySymbol()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Minus sign")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getMinusSign()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Monetary decimal separator")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getMonetaryDecimalSeparator()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("NaN")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getNaN()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Pad escape")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getPadEscape()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Pattern Separator")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getPatternSeparator()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Percent")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getPercent()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Per mill")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getPerMill()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Plus sign")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getPlusSign()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Significant digit")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getSignificantDigit()); %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Zero digit")%></td>
		<td><% HtmlEncoder.encode(out, nfs.getZeroDigit()); %></td>
	</tr>
</table>

<h2><%=_h("Dates")%></h2>
<%	DateFormatSymbols dfs = DateFormatSymbols.getInstance(target); %>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Property")%></th>
		<th style="text-align:left;"><%=_h("Value(s)")%></th>
	</tr>
	<tr>
		<td valign="top"><%=_h("AM/PM Strings")%></td>
		<td><% printStrings(out, dfs.getAmPmStrings());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Eras")%></td>
		<td><% printStrings(out, dfs.getEras());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Era names")%></td>
		<td><% printStrings(out, dfs.getEraNames());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Months")%></td>
		<td><% printStrings(out, dfs.getMonths());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Short months")%></td>
		<td><% printStrings(out, dfs.getShortMonths());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Short weekdays")%></td>
		<td><% printStrings(out, dfs.getShortWeekdays());%> </td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Weekdays")%></td>
		<td><% printStrings(out, dfs.getWeekdays());%> </td>
	</tr>
	<tr>
		<th style="text-align:left;"><%=_h("Format")%></th>
		<th style="text-align:left;"><%=_h("Pattern")%></th>
	</tr>
<%
	Date today = new java.util.Date();

	int[] dateFormats = new int[] { DateFormat.SHORT, DateFormat.MEDIUM, DateFormat.LONG, DateFormat.FULL };

	for (int style : dateFormats)
	{
		DateFormat df = null;
		try
		{
			df = DateFormat.getDateInstance(style, target);
		}
		catch (Throwable t)
		{
			out.println("\t<tr>");
			out.print("\t\t<td colspan=\"2\">ERROR: ");
			HtmlEncoder.encode(out, t.getMessage());
			out.println("</td>");
			out.println("\t</tr>");
			continue;
		}


		out.println("\t<tr>");

		out.print("\t\t<td valign=\"top\">Date.");
		out.print(style);
		out.println("</td>");

		out.print("\t\t<td>");
		out.print("Example: ");
		out.print(h(df.format(today)));
		out.print("<br/>");
		if (df instanceof SimpleDateFormat)
		{
			SimpleDateFormat sdf = (SimpleDateFormat)df;
			out.print("Pattern: ");
			out.print(h(sdf.toPattern()));
			out.print("<br/>");

			out.print("Local Pattern: ");
			out.print(h(sdf.toLocalizedPattern()));
			out.print("<br/>");

		}
		else
		{
			out.print("<i>");
			out.print(_h("not a SimpleDateFormat"));
			out.print("</i>");
		}
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<p>Also see the list of <a href="timezone.html">time zones</a>.</p>

<h2><%=_h("Related ICU Locales")%></h2>
<%
	ULocale parent = ULocaleCache.getInstance().getParent(target.toString());
	if (parent != null)
	{
		out.print("<p>");
		out.print(_h("Parent:"));
		out.print(" ");
		out.print(h(parent.getDisplayNameWithDialect(uloc)));
		out.print(" (<a href=\"../");
		out.print(h(parent.toString()));
		out.print("/index.html\">");
		out.print(h(parent.toString()));
		out.print("</a>)");
		out.println("</p>");
	}

	ULocale[] ArrSibling = ULocaleCache.getInstance().getSiblings(target.toString());
	if (ArrSibling != null && ArrSibling.length > 0)
	{
		out.print("<p>");
		out.print(_h("Siblings:"));
		out.println("</p>");
		out.println("<ul>");
		for (ULocale sibling : ArrSibling)
		{
			out.print("\t<li>");
			out.print(h(sibling.getDisplayNameWithDialect(uloc)));
			out.print(" (<a href=\"../");
			out.print(h(sibling.toString()));
			out.print("/index.html\">");
			out.print(h(sibling.toString()));
			out.print("</a>)");
			out.println("</li>");
		}
		out.println("</ul>");
	}

	ULocale[] ArrChild = ULocaleCache.getInstance().getChildren(target.toString());
	if (ArrChild != null && ArrChild.length > 0)
	{
		out.print("<p>");
		out.print(_h("Children:"));
		out.println("</p>");
		out.println("<ul>");
		for (ULocale child : ArrChild)
		{
			out.print("\t<li>");
			out.print(h(child.getDisplayNameWithDialect(uloc)));
			out.print(" (<a href=\"../");
			out.print(h(child.toString()));
			out.print("/index.html\">");
			out.print(h(child.toString()));
			out.print("</a>)");
			out.println("</li>");
		}
		out.println("</ul>");
	}
%>

<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	void printStrings(JspWriter out, String[] ArrData)
		throws Exception
	{
		boolean first = true;
		for (String str : ArrData)
		{
			if (str == null || str.length() == 0)
			{
				continue;
			}
			if (first == true)
			{
				first = false;
			}
			else
			{
				out.print(", ");
			}
			out.print(h(str));
		}
	}
%>
