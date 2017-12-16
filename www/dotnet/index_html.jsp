<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.localeplanet.dotnet.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String sort = request.getParameter("sort");
	if (sort == null)
	{
		sort = "code";
	}

	String url = UrlUtil.getLocalUrl(request);

%><!DOCTYPE html>
<html>
<head>
<title>Microsoft .NET CultureInfos</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><a href="/data-sources.html#dotnet">Microsoft .NET</a> CultureInfos</h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Code")%><%=getSort(url, sort, "code")%></th>
		<th style="text-align:left;"><%=_h("Name")%><%=getSort(url, sort, "name")%></th>
		<th style="text-align:left;"><%=_h("Local Name")%><%=getSort(url, sort, "native")%></th>
	</tr>
<%
	DotNetLocale[] ArrLocale = DotNetLocaleCache.getInstance().getAvailableLocales();

	if (sort.equals("code"))
	{
		Arrays.sort(ArrLocale, DotNetLocaleCodeComparator.getInstance());
	}
	else if (sort.equals("name"))
	{
		Arrays.sort(ArrLocale, DotNetLocaleNameComparator.getInstance());
	}
	else if (sort.equals("native"))
	{
		Arrays.sort(ArrLocale, DotNetLocaleNativeNameComparator.getInstance());
	}

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td>");
		out.print("<a href=\"/dotnet/");
		out.print(UrlUtil.encode(ArrLocale[loop].getCode()));
		out.print("/index.html\">");

		if (ArrLocale[loop].getCode().length() == 0)
		{
			out.print("<i>");
			out.print(h("(blank)"));
			out.print("</i>");
		}
		else
		{
			HtmlEncoder.encode(out, ArrLocale[loop].getCode());
		}
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getName());
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getNativeName());
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<p><%=h(MessageFormat.format(_("# of languages: {0}"), ArrLocale.length))%></p>
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