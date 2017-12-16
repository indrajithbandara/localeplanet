<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
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

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Countries")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Countries")%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th style="text-align:left;"><%=_h("Code")%></th>
		<th style="text-align:left;"><%=_h("Name")%></th>
<%
	for (GenericLocaleCache theCache : caches)
	{
		if (theCache.hasCountry() == false)
		{
			continue;
		}
		out.print("\t\t<th style=\"text-align:left;\">");
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
	TreeMap<String, String> all = new TreeMap<String, String>();
	int total = 0;
	CounterMap<GenericLocaleCache> counterMap = new CounterMap<GenericLocaleCache>();

	for (GenericLocaleCache theCache : caches)
	{
		if (theCache.hasCountry() == false)
		{
			continue;
		}

		String[] codes = theCache.getCodes();
		for (String code: codes)
		{
			GenericLocale gLoc = theCache.getGeneric(code);
			String country = gLoc.getCountry();
			if (StringUtil.isEmpty(country))
			{
				continue;
			}
			if (all.get(country) == null)
			{
				all.put(country, gLoc.getCountryName(loc));
			}
		}
	}

	for (String code : all.keySet())
	{
		total++;

		out.println("\t<tr>");

		out.print("\t\t<td style=\"vertical-align:top;text-align:center;\">");
		out.print("<a name=\"");
		HtmlEncoder.encode(out, code);
		out.print("\">");
		HtmlEncoder.encode(out, code);
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td style=\"vertical-align:top;\">");
		HtmlEncoder.encode(out, all.get(code));
		out.println("</td>");

		for (GenericLocaleCache theCache : caches)
		{
			if (theCache.hasCountry() == false)
			{
				continue;
			}

			boolean empty = true;

			out.print("\t\t<td style=\"vertical-align:top;\">");

			String[] codes = theCache.getCodes();
			for (String ccode: codes)
			{
				GenericLocale gLoc = theCache.getGeneric(ccode);
				String country = gLoc.getCountry();
				if (StringUtil.isEmpty(country) || country.equals(code) == false)
				{
					continue;
				}
				out.print(h(gLoc.getLanguageName(loc)));
				out.print(" (");
				out.print("<a href=\"/");
				out.print(theCache.getCode());
				out.print("/");
				out.print(h(ccode));
				out.print("/index.html\">");
				out.print(h(ccode));
				out.print("</a>");
				out.print(")");
				out.print("<br/>");
				empty = false;
			}

			if (empty)
			{
				out.print("&nbsp;");
			}
			else
			{
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
		if (theCache.hasCountry() == false)
		{
			continue;
		}
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
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
