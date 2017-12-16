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
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();
	
%><!DOCTYPE html>
<html>
<head>
<title><%=_h("Compare Locale Data Sources")%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=_h("Compare Locale Data Sources")%></h1>
<p><%=_h("Lists:")%> 
	<a href="/compare/all.html"><%=_h("all")%></a>
	| <a href="/compare/language.html"><%=_h("languages")%></a>
	| <a href="/compare/simple.html"><%=_h("simple locales")%></a>
	| <a href="/compare/extended.html"><%=_h("complex locales")%></a>
</p>
<p><a href="missing.html"><%=_h("Missing")%></a> - <%=_h("compare two data sources to see which locales are missing.")%></p>
<p><%=_h("Compare:")%> 
	<a href="currency-pattern.html"><%=_h("currency patterns")%></a>  
	| <a href="date-pattern.html"><%=_h("date patterns")%></a>  
	| <a href="time-pattern.html"><%=_h("time patterns")%></a>
</p>
<p><a href="country.html">Countries</a></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
