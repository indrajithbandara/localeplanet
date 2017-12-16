<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	Locale browserLoc = request.getLocale();
	if (browserLoc != null && browserLoc.getLanguage().equals(loc.getLanguage()))
	{
		browserLoc = null;
	}

	String next = request.getParameter("next");
	if (StringUtil.isEmpty(next))
	{
		next = "/index.html";
	}

%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Change Language")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script type="text/javascript">

	function setLanguageCookie(lang)
	{
		document.cookie = "locale=" + escape(lang) + "; path=/";
		//window.location = window.location.pathname + "?nocache=" + new Date().getTime();
		window.location = '<%=next%>';
	}

	function resetLanguageCookie()
	{
	    var d = new Date();
	    document.cookie = "locale=en-US;expires=" + d.toGMTString() + ";path=/;";
		//window.location = window.location.pathname + "?nocache=" + new Date().getTime();
		window.location = '<%=next%>';
	}

	function testLanguageCookie()
	{
	    document.cookie = "locale=zz;;path=/;";
		//window.location = window.location.pathname + "?nocache=" + new Date().getTime();
		window.location = '<%=next%>';
	}

</script>
<style type="text/css">
.rowseparator td {
	border-bottom: 1px solid grey;
}
</style>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
	<div class="page-header">
		<h1><%=_h("Change Language")%></h1>
	</div>

<p>I could use help with the translations!  Currently all the translations are from Google Translate.
I will be happy to give you credit (and a link back).  <a href="contact.html?message=I+can+help+translate+into+" rel="nofollow">Let me know</a>!</p>
<table class="table table-striped">
	<thead>
		<tr>
			<th colspan="<%=4 + (browserLoc == null ? 0 : 1)%>"><%=_h("Supported Languages")%></th>
		</tr>
	</thead>
	<tbody>
<%
	String[] ArrLang = Translation.getLanguages();
	Arrays.sort(ArrLang);

	for (String lang : ArrLang)
	{
		if ("zz".equals(lang))
		{
			continue;
		}
		out.println("\t\t<tr>");

		out.print("\t\t\t<td>");
		out.print(h(lang));
		out.println("</td>");

		out.print("\t\t\t<td>");
		out.print(h(CommonLocaleUtil.getName(lang, loc)));
		out.println("</td>");

		if (browserLoc != null)
		{
			out.print("\t\t\t<td>");
			out.print(h(CommonLocaleUtil.getName(lang, browserLoc)));
			out.println("</td>");
		}

		out.print("\t\t\t<td>");
		out.print(h(CommonLocaleUtil.getName(lang, LocaleCache.getInstance().getExact(LocaleCache.getInstance().getNormalizedCode(lang)))));
		out.println("</td>");

		out.print("\t\t\t<td>");
		if (LocaleCache.getInstance().getNormalizedCode(loc.getLanguage()).equals(lang))
		{
			out.print(_h("(current)"));
		}
		else
		{
			out.print("<input class=\"btn\" type=\"submit\" value=\"");
			out.print(_h("Select"));
			out.print("\" onclick=\"setLanguageCookie('");
			out.print(h(lang));
			out.print("');\" />");
		}
		out.println("</td>");

		out.println("\t\t</tr>");
	}
%>
		<tr>
			<td colspan="<%=3 + (browserLoc == null ? 0 : 1)%>" align="right">&nbsp;<!-- <%=ArrLang.length%>-->
				<input class="btn" type="submit" value="<%=_h("Test mode")%>" onclick="testLanguageCookie();" />
			</td>
			<td><input class="btn" type="submit" value="<%=_h("Reset")%>" onclick="resetLanguageCookie();" /></td>
		</tr>
	</tbody>
</table>

<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
