<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
				 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();
	ULocale uloc = ULocale.forLocale(loc);

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("ISO 639 Language List")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("ISO 639 Language List")%></h1>
<p><%=_("This is the list of ISO 639 languages via <code>ULocale.getISOLanguages()</code>.")%></p>
<p><a href="/support/standards.html"><%=_h("Additional relevant standards")%></a></p>
<table class="table table-bordered table-striped">
	<tr>
		<th><%=_h("ID")%></th>
		<th><%=_h("ICU locales using this language")%></th>
	</tr>
<%
	String[] ArrLanguage = ULocale.getISOLanguages();
	Arrays.sort(ArrLanguage);
	for (int loop = 0; loop < ArrLanguage.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td valign=\"top\">");
		out.print("<a name=\"");
		HtmlEncoder.encode(out, ArrLanguage[loop]);
		out.print("\">");
		HtmlEncoder.encode(out, ArrLanguage[loop]);
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td>");
		boolean first = true;
		for (ULocale target : ULocale.getAvailableLocales())
		{
			if (ArrLanguage[loop].equals(target.getLanguage()))
			{
				if (first)
				{
					first = false;
				}
				else
				{
					//out.print(", ");
				}
				out.print(h(target.getDisplayName(uloc)));
				out.print("&nbsp;(<a href=\"/icu/");
				out.print(UrlUtil.encode(LocaleNormalizer.normalize(target)));
				out.print("/index.html\">");
				out.print(h(LocaleNormalizer.normalize(target)));
				out.print("</a>)");
				out.print("<br/>");
			}
		}
		out.println("</td>");

		out.println("\t</tr>");
	}
%>
</table>
<p>Count: <%=h(NumberFormat.getIntegerInstance(loc).format(ArrLanguage.length))%></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
