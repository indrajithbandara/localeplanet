<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.google.*,
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
		sort = "code";
	}

	String url = UrlUtil.getLocalUrl(request);

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Google Translate Languages")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="https://www.google.com/jsapi?key=ABQIAAAA5sdMTLAemOuxdk93V7nsLhQKwbX3w_uxoSmSX43jeVa_9q_2oxRbjvEf7phi95dQ2N49J-ECOL-szw" type="text/javascript"></script>
<script type="text/javascript">
	google.load("language", "1");

	function isTranslatable(locale)
	{
		if (google.language.isTranslatable(locale))
		{
			return "<%=_h("Yes")%>";
		}
		return "";
	}
</script></head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=MessageFormat.format(_h("{0}Google Translate{1} Languages"), "<a href=\"/data-sources.html#google-translate\">", "</a>")%></h1>
<table class="table table-bordered table-striped">
	<tr>
		<th><%=_h("ID")%><%=getSort(url, sort, "code")%></th>
		<th style="text-align:left;"><%=_h("Name")%><%=getSort(url, sort, "name")%></th>
		<th style="text-align:left;"><%=_h("Non-Google name")%><%=getSort(url, sort, "icu")%></th>
		<th><%=_h("Translatable?")%></th>
	</tr>
<%
	GoogleTranslateLocale[] ArrLocale = GoogleTranslateCache.getInstance().getAvailableLocales();

	if (sort.equals("code"))
	{
		Arrays.sort(ArrLocale, GoogleTranslateLocaleCodeComparator.getInstance());
	}
	else if (sort.equals("name"))
	{
		Arrays.sort(ArrLocale, GoogleTranslateLocaleNameComparator.getInstance());
	}
	else if (sort.equals("icu"))
	{
		Arrays.sort(ArrLocale, GoogleTranslateLocaleIcuComparator.getInstance(loc));
	}

	for (int loop = 0; loop < ArrLocale.length; loop++)
	{
		out.println("\t<tr>");

		out.print("\t\t<td align=\"center\">");
		out.print("<a href=\"/google-translate/");
		out.print(UrlUtil.encode(ArrLocale[loop].getCode()));
		out.print("/index.html\">");
		HtmlEncoder.encode(out, ArrLocale[loop].getCode());
		out.print("</a>");
		out.println("</td>");

		out.print("\t\t<td>");
		HtmlEncoder.encode(out, ArrLocale[loop].getName());
		out.println("</td>");

		out.print("\t\t<td>");

		String nativeName = CommonLocaleUtil.getName(ArrLocale[loop].getCode(), loc);
		if (nativeName == null)
		{
			out.print("<i>");
			out.print(_h("(not found)"));
			out.print("</i>");
		}
		else if (nativeName.equalsIgnoreCase(ArrLocale[loop].getName()))
		{
			out.print("&nbsp;");
		}
		else
		{
			out.print(h(nativeName));
		}
		out.print("&nbsp;");
		out.println("</td>");

		out.print("\t\t<td align=\"center\">");
		out.print("<script type=\"text/javascript\">document.write(isTranslatable('");
		HtmlEncoder.encode(out, ArrLocale[loop].getCode());
		out.print("'));</script>");
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