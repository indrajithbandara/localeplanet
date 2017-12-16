<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 java.util.regex.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.dotnet.*,
		 		 com.localeplanet.google.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	GenericLocaleCache[] caches = CommonLocaleUtil.getCaches();

	String titleHtml = (String)request.getAttribute("titleHtml");
	Pattern filter = (Pattern)request.getAttribute("filter");

%><!DOCTYPE html>
<html>
<head>
<title><%=titleHtml%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=titleHtml%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("ID")%><sup><a style="text-decoration:none;" href="/support/normal.html">&dagger;</a></sup></th>
		<th style="text-align:left;"><%=_h("Name")%></th>
<%
	for (GenericLocaleCache theCache : caches)
	{
		out.print("\t\t<th>");
		out.print("<a href=\"/");
		out.print(UrlUtil.encode(theCache.getCode()));
		out.print("/index.html\">");
		out.print(h(theCache.getDescription(loc)));
		out.print("</a>");
		out.println("</th>");
	}
%>
	</tr>
<%
	TreeSet<String> all = new TreeSet<String>();
	int total = 0;
	CounterMap<GenericLocaleCache> counterMap = new CounterMap<GenericLocaleCache>();

	for (GenericLocaleCache theCache : caches)
	{
		all.addAll(Arrays.asList(theCache.getCodes()));
	}

	for (String code : all)
	{
		if (filter != null)
		{
			if (filter.matcher(code).matches() == false)
			{
				continue;
			}
		}
		total++;

		out.println("\t<tr>");

		out.print("\t\t<td><a href=\"/compare/");
		out.print(UrlUtil.encode(code));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, code);
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, CommonLocaleUtil.getName(code, loc));
		out.println("</td>");

		for (GenericLocaleCache theCache : caches)
		{
			out.print("\t\t<td style=\"text-align:center;\">");

			if (theCache.getGeneric(code) == null)
			{
				out.print("&nbsp;");
			}
			else
			{
				out.print("<a href=\"/");
				out.print(UrlUtil.encode(theCache.getCode()));
				out.print("/");
				out.print(UrlUtil.encode(code));
				out.print("/index.html\">");
				out.print(_h("Yes"));
				out.print("</a>");
				counterMap.increment(theCache);
			}
			out.println("</td>");
		}

		out.println("\t</tr>");
	}
%>
	<tr>
		<td colspan="2" style="text-align:right;"><%=_h("Total:")%></td>
<%
	for (GenericLocaleCache theCache : caches)
	{
		out.print("\t\t<td style=\"text-align:center;\">");
		out.print("<a href=\"/");
		out.print(UrlUtil.encode(theCache.getCode()));
		out.print("/index.html\">");
		out.print(h(NumberFormat.getIntegerInstance(loc).format(counterMap.get(theCache))));
		out.print("</a>");
		out.println("</td>");
	}
%>
	</tr>
</table>
<p><%=h(MessageFormat.format(_("Grand total: {0}"), NumberFormat.getIntegerInstance(loc).format(total)))%></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>