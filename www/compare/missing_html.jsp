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
	
	if (request.getParameter("cancel") != null)
	{
		HttpUtil.Redirect(request, response, "index.html");
		return;
	}
	
	if (request.getParameter("left") != null && request.getParameter("right") != null && request.getAttribute("error") == null)
	{
		application.getRequestDispatcher("/compare/_missing.jsp").forward(request, response);
		return;
	}
	
	GenericLocaleCache[] caches = CommonLocaleUtil.getCaches();
	String currentCheck = request.getParameter("check");
	if (StringUtil.isEmpty(currentCheck))
	{
		currentCheck = "country";
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
<p><%
	if (request.getAttribute("error") == null)
	{
		out.print(_h("Compare two data sources and see which locales that are in one but not the other."));
	}
	else
	{
		out.print(h(MessageFormat.format("ERROR: {0}", (String)request.getAttribute("error"))));
	}
%></p>

<form action="missing.html" method="get">
<table class="dataentry">
	<tr>
		<th colspan="2"><%=_h("Options")%></th>
	</tr>
	<tr>
		<td><%=h(MessageFormat.format(_("Data Source {0}"), 1))%>:</td>
		<td><%=getSelect(loc, "left", caches, request.getParameter("left"))%></td>
	</tr>
	<tr>
		<td><%=h(MessageFormat.format(_("Data Source {0}"), 2))%>:</td>
		<td><%=getSelect(loc, "right", caches, request.getParameter("right"))%></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Locales to check:")%></td>
		<td>
			<input type="radio" id="checklang" name="check" value="lang" <% FormUtil.writeChecked(out, "lang", currentCheck); %> /><label for="checklang"> <%=_h("Languages")%></label><br/>
			<input type="radio" id="checkcountry" name="check" value="country" <% FormUtil.writeChecked(out, "country", currentCheck); %> /><label for="checkcountry"> <%=_h("Languages with Countries")%></label><br/>
			<input type="radio" id="checkall" name="check" value="all" <% FormUtil.writeChecked(out, "all", currentCheck); %> /><label for="checkall"> <%=_h("All")%></label><br/>
		</td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Options:")%></td>
		<td><input type="checkbox" id="common" name="common" value="Y" <% FormUtil.writeChecked(out, StringUtil.toBoolean(request.getParameter("common"))); %>/><label for="common"> <%=_h("Show locales in common")%></label></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="submit" value="<%=_h("Compare")%>" />
			<input type="submit" name="cancel" value="<%=_h("Cancel")%>" />
		</td>
	</tr>
</table>
</form>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!

	String getSelect(Locale loc, String name, GenericLocaleCache[] caches, String current)
	{
		StringBuilder sb = new StringBuilder();
		
		sb.append("<select name=\"");
		sb.append(name);
		sb.append("\">");
		
		for (GenericLocaleCache theCache : caches)
		{
			sb.append("<option value=\"");
			sb.append(HtmlEncoder.encode(theCache.getCode()));
			sb.append("\">");
			sb.append(HtmlEncoder.encode(theCache.getDescription(loc)));
			sb.append("</option>");
		}
		
		sb.append("</select>");
		
		return sb.toString();
	}
%>
