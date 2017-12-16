<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 java.util.regex.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	String target = (String)request.getAttribute("urlparam");
	
	if (target.matches("[a-z]{2,3}") == false)
	{
		String language = target.replaceAll("(([a-z]{2,3}).*)", "$2");
		if (language.matches("[a-z]{2,3}"))
		{
			HttpUtil.Redirect(request, response, "../" + language + "/country.html");
		}
		else
		{
			response.sendError(response.SC_NOT_FOUND);
		}
		return;	
	}
	
	String name = CommonLocaleUtil.getName(target, Localizer.getLocale());
	
	request.setAttribute("titleHtml", h(MessageFormat.format(_("Countries with language {0} ({1})"), name, target)));
	request.setAttribute("filter", Pattern.compile(target + ".+"));

	HttpUtil.Forward(request, response, "/compare/_list_html.jsp");
	
	if (1 == 1)
	{
		return;
	}
%>