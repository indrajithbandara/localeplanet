<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String localeCode = (String)request.getAttribute("urlparam");

	Locale target = LocaleCache.getInstance().getExact(localeCode);
	if (target == null)
	{
		String normal = LocaleCache.getInstance().getNormalizedCode(localeCode);
		if (normal != null)
		{
			HttpUtil.Redirect(request, response, "../" + UrlUtil.encode(normal) + "/index.html");
			return;
		}

		response.sendError(response.SC_NOT_FOUND);
		return;
	}

	String htmlTitle = h(MessageFormat.format(_("Java Locale \u201C{0}\u201D ({1})"), target.getDisplayName(loc), LocaleCache.getInstance().getNormalizedCode(target.toString())));

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
		<td><%=h(target.toString())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Display name")%></td>
		<td><%=h(target.getDisplayName(loc))%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Display variant")%></td>
		<td><%=h(target.getDisplayVariant(loc))%></td>
	</tr>
	<tr>
		<td valign="top">ISO3 language code</td>
		<td><%=h(target.getISO3Language())%></td>
	</tr>
	<tr>
		<td valign="top">ISO3 country code</td>
		<td><%=h(target.getISO3Country())%></td>
	</tr>
	<tr>
		<td valign="top">ICU Locale</td>
		<td><%
			if (ULocaleCache.getInstance().getExact(localeCode) == null)
			{
				out.print("<i>");
				out.print(_h("(no exact match)"));
				out.print("</i>");
			}
			else
			{
				out.print("<a href=\"/icu/");
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

			out.print("Localized Pattern: ");
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

<h2><%=_h("Time Zones")%></h2>
<%
	String[] ArrZoneID = TimeZone.getAvailableIDs();
	Arrays.sort(ArrZoneID);
%>
<table class="grid">
	<tr>
		<th style="text-align:left;"><%=_h("ID")%></th>
		<th style="text-align:left;"><%=_h("Short/Standard")%></th>
		<th style="text-align:left;"><%=_h("Short/Daylight")%></th>
		<th style="text-align:left;"><%=_h("Long/Standard")%></th>
		<th style="text-align:left;"><%=_h("Long/Daylight")%></th>
	</tr>
<%
	for (String zoneID : ArrZoneID)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		out.print(h(zoneID));
		out.println("</td>");

		TimeZone tz = TimeZone.getTimeZone(zoneID);
		out.print("\t\t<td>");
		out.print(h(tz.getDisplayName(false, TimeZone.SHORT, target)));
		out.println("</td>");
		out.print("\t\t<td>");
		if (tz.useDaylightTime())
		{
			out.print(h(tz.getDisplayName(true, TimeZone.SHORT, target)));
		}
		out.println("</td>");
		out.print("\t\t<td>");
		out.print(h(tz.getDisplayName(false, TimeZone.LONG, target)));
		out.println("</td>");
		out.print("\t\t<td>");
		if (tz.useDaylightTime())
		{
			out.print(h(tz.getDisplayName(true, TimeZone.LONG, target)));
		}
		out.println("</td>");
		out.println("\t</tr>");
	}
%>
</table>
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
