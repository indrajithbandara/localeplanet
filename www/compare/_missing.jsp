<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
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

	GenericLocaleCache left = CommonLocaleUtil.getCache(request.getParameter("left"));
	GenericLocaleCache right = CommonLocaleUtil.getCache(request.getParameter("right"));

	if (left == null || right == null || left.equals(right))
	{
		request.setAttribute("error", _("You must pick two different data sources to compare"));
		application.getRequestDispatcher("/compare/missing_html.jsp").forward(request, response);
		return;
	}

	String currentCheck = request.getParameter("check");
	if (StringUtil.isEmpty(currentCheck))
	{
		currentCheck = "country";
	}

	boolean showCommon = StringUtil.toBoolean(request.getParameter("common"));

	String check = request.getParameter("check");
	if (StringUtil.isEmpty(check))
	{
		check = "all";
	}

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Missing Locales")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Missing Locales")%></h1>
<table class="table table-bordered table-striped">
	<tr>
	<th width="33%"><%=h(MessageFormat.format(_("Only in {0}"), left.getDescription(loc)))%></th>
		<% if (showCommon) { %><th width="34%"><%=_h("In both")%></th><% } %>
		<th width="33%"><%=h(MessageFormat.format(_("Only in {0}"), right.getDescription(loc)))%></th>
	</tr>
<%
	TreeSet<String> all = new TreeSet<String>();

	all.addAll(Arrays.asList(left.getCodes()));
	all.addAll(Arrays.asList(right.getCodes()));
	String[] codes = all.toArray( new String[ all.size() ]);

	if (check.equals("lang"))
	{
		codes = onlyLanguages(codes);
	}
	else if (check.equals("country"))
	{
		codes = onlyLangCountry(codes);
	}

	int leftCount = 0;
	int rightCount = 0;
	int commonCount = 0;

	for (String code : codes)
	{
		GenericLocale leftLocale = left.getGeneric(code);
		GenericLocale rightLocale = right.getGeneric(code);
		if (showCommon == false && leftLocale != null && rightLocale != null)
		{
			continue;
		}

		out.println("\t<tr>");

		out.print("\t\t<td>");
		if (rightLocale == null)
		{
			out.print("<a href=\"/");
			out.print(UrlUtil.encode(left.getCode()));
			out.print("/");
			out.print(UrlUtil.encode(code));
			out.print("/index.html\">");
			out.print(HtmlEncoder.encode(leftLocale.getDisplayCode(loc)));
			out.print("</a> - ");
			out.print(CommonLocaleUtil.getName(code, loc));
			leftCount++;
		}
		out.println("</td>");

		if (showCommon)
		{
			out.print("\t\t<td>");
			if (leftLocale != null && rightLocale != null)
			{
				out.print("<a href=\"/compare/");
				out.print(UrlUtil.encode(code));
				out.print("/index.html\">");
				out.print(HtmlEncoder.encode(code));
				out.print("</a> - ");
				out.print(CommonLocaleUtil.getName(code, loc));
				commonCount++;
			}
			out.println("</td>");
		}

		out.print("\t\t<td>");
		if (leftLocale == null)
		{
			out.print("<a href=\"/");
			out.print(UrlUtil.encode(right.getCode()));
			out.print("/");
			out.print(UrlUtil.encode(code));
			out.print("/index.html\">");
			out.print(HtmlEncoder.encode(rightLocale.getDisplayCode(loc)));
			out.print("</a> - ");
			out.print(CommonLocaleUtil.getName(code, loc));
			rightCount++;
		}
		out.println("</td>");

		out.println("\t</tr>");
	}
%>	<tr>
		<td>Count: <%=leftCount%></td>
		<%if (showCommon) { %><td>Count: <%=commonCount%></td><% } %>
		<td>Count: <%=rightCount%></td>
	</tr>
</table>
<p><a href="missing.html"><%=_h("Compare again")%></a></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	String[] onlyLanguages(String[] codes)
	{
		List<String> result = new ArrayList<String>();

		for (String code : codes)
		{
			if (code.indexOf('-') == -1)
			{
				result.add(code);
			}
		}

		return result.toArray(new String[ result.size() ]);
	}

	String[] onlyLangCountry(String[] codes)
	{
		List<String> result = new ArrayList<String>();

		for (String code : codes)
		{
			int firstDash = code.indexOf('-');
			if (firstDash == -1)
			{
				continue;
			}

			if (code.indexOf('-', firstDash+1) == -1)
			{
				result.add(code);
			}
		}

		return result.toArray(new String[ result.size() ]);
	}
%>
