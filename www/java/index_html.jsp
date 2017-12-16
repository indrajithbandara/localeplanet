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

	String sort = request.getParameter("sort");
	if (sort == null)
	{
		sort = "id";
	}

	String url = UrlUtil.getLocalUrl(request);

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Java Locales")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=MessageFormat.format(_h("{0}Java{1} Locales"), "<a href=\"/data-sources.html#java\">", "</a>")%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("ID")%><sup><a style="text-decoration:none;" href="/support/normal.html">&dagger;</a></sup><%=getSort(url, sort, "id")%></th>
		<th style="text-align:left;"><%=_h("Name")%><%=getSort(url, sort, "name")%></th>
		<th style="text-align:left;"><%=_h("Local name")%><%=getSort(url, sort, "native")%></th>
	</tr>
<%
	Locale[] ArrLocale = Locale.getAvailableLocales();
	if (sort.equals("id"))
	{
		Arrays.sort(ArrLocale, LocaleCodeComparator.getInstance());
	}
	else if (sort.equals("name"))
	{
		Arrays.sort(ArrLocale, LocaleNameComparator.getInstance(loc));
	}
	else if (sort.equals("native"))
	{
		Arrays.sort(ArrLocale, LocaleNativeNameComparator.getInstance());
	}

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		out.print("<a href=\"");
		out.print(UrlUtil.encode(LocaleCache.getInstance().getNormalizedCode(ArrLocale[loop].toString())));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, ArrLocale[loop].toString());
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getDisplayName(loc));
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getDisplayName(ArrLocale[loop]));
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<p>Count: <%=h(NumberFormat.getIntegerInstance(loc).format(ArrLocale.length))%></p>
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