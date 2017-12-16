<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	request.setAttribute("titleHtml", _h("Complete List"));

	HttpUtil.Forward(request, response, "_list_html.jsp");
	
	if (1 == 1)
	{
		return;
	}
%>

