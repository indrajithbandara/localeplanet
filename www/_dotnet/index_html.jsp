<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.dotnet.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String localeCode = (String)request.getAttribute("urlparam");

	DotNetLocale target = DotNetLocaleCache.getInstance().getExact(localeCode);
	if (target == null)
	{
		response.sendError(response.SC_NOT_FOUND);
		return;
	}

	String htmlTitle = h(MessageFormat.format(_("Microsoft .NET CultureInfo \u201C{0}\u201D ({1})"), target.getName(), target.getCode()));

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
		<td><%=h(target.getCode())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Language")%></td>
		<td><%=h(target.getLanguage())%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Language")%></td>
		<td><%=h(target.getLanguageName(loc))%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Country")%></td>
		<td><% if (StringUtil.isEmpty(target.getCountry())) { out.print(_h("(none)")); } else { out.print(h(target.getCountry())); } %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Country")%></td>
		<td><% if (StringUtil.isEmpty(target.getCountryName(loc))) { out.print(_h("(none)")); } else { out.print(h(target.getCountryName(loc))); } %></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Other data sources")%></td>
		<td><a href="/compare/<%=UrlUtil.encode(localeCode)%>/index.html"><%=_h("compare")%></a></td>
	</tr>
</table>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
