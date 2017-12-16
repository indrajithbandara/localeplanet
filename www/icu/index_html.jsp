<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
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

	String sort = request.getParameter("sort");
	if (sort == null)
	{
		sort = "id";
	}

	String titleHtmlFormat = _("International Components for Unicode ({0}ICU{1}) Data");

	String url = UrlUtil.getLocalUrl(request);

%><!DOCTYPE html>
<html>
<head>
<title><%=java.text.MessageFormat.format(titleHtmlFormat, "", "")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
	<div class="page-header">
		<h1><%=java.text.MessageFormat.format(titleHtmlFormat, "<a href=\"/data-sources.html#icu\">", "</a>")%></h1>
	</div>
<div class="section-header">
	<h2>Data</h2>
</div>
<ul>
	<li><a href="iso639.html">ISO 639</a> - <%=_h("Standard list of languages")%></li>
	<li><a href="iso3166.html">ISO 3166</a> - <%=_h("Standard list of countries")%></li>
	<li><a href="currency.html">Currencies</a>, <a href="currency-pattern.html">Currency patterns</a></li>
</ul>
	<div class="section-header">
		<h2>ULocale List</h2>
	</div>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="text-align:left;">ID<sup><a style="text-decoration:none;" href="/support/normal.html">&dagger;</a></sup><%=getSort(url, sort, "id")%></th>
			<!--<th style="text-align:left;">Language Tag<%=getSort(url, sort, "langtag")%></th>-->
			<th style="text-align:left;">Formal name<%=getSort(url, sort, "name")%></th>
			<th style="text-align:left;">Native name<%=getSort(url, sort, "native")%></th>
			<th style="text-align:left;">Common name<%=getSort(url, sort, "dialect")%></th>
		</tr>
	</thead>
	<tbody>
<%
	ULocale[] ArrLocale = ULocale.getAvailableLocales();

	if (sort.equals("id"))
	{
		Arrays.sort(ArrLocale, ULocaleCodeComparator.getInstance());
	}
	else if (sort.equals("name"))
	{
		Arrays.sort(ArrLocale, new ULocaleNameComparator(uloc));
	}
	else if (sort.equals("dialect"))
	{
		Arrays.sort(ArrLocale, new ULocaleDialectComparator(uloc));
	}
	else if (sort.equals("native"))
	{
		Arrays.sort(ArrLocale, ULocaleNativeComparator.getInstance());
	}

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		String common = ArrLocale[loop].getDisplayNameWithDialect(uloc);
		String formal = ArrLocale[loop].getDisplayName(uloc);
		String nativeName = ArrLocale[loop].getDisplayName(ArrLocale[loop]);
		out.println("\t\t<tr>");

		out.print("\t\t\t<td><a href=\"");
		out.print(UrlUtil.encode(ULocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString())));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, ArrLocale[loop].toString());
		out.println("</a></td>");

		/*
		out.print("\t\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].toLanguageTag());
		out.println("</td>");
		*/

		out.print("\t\t\t<td>");
		HtmlEncoder.encode(out, formal);
		out.println("</td>");

		out.print("\t\t\t<td>");
		HtmlEncoder.encode(out, nativeName);
		out.println("</td>");

		out.print("\t\t\t<td>");
		if (formal.equals(common) == false)
		{
			HtmlEncoder.encode(out, common);
		}
		out.println("</td>");

		out.println("\t\t</tr>");
	}
%>
	</tbody>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	public String getSort(String url, String current, String target)
	{
		if (current.equals(target))
		{
			return "";
		}

		StringBuilder sb = new StringBuilder();
		sb.append("&nbsp;<a href=\"");
		sb.append(HtmlEncoder.encode(UrlUtil.setParam(url, "sort", target)));
		sb.append("\" rel=\"nofollow\" style=\"text-decoration:none;\">");
		sb.append("&#x25bc;");
		sb.append("</a>");

		return sb.toString();
	}
%>
