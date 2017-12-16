<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
				 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

%><!DOCTYPE html>
<html>
<head>
<title>Books on Localization and Internationalization</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Books on Localization and Internationalization</h1>
<iframe src="http://astore.amazon.com/localeplanetx-20" width="100%" height="4000" frameborder="0" scrolling="no"></iframe>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
