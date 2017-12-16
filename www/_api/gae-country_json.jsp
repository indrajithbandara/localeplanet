<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
		 		 static com.localeplanet.ui.Macro.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, Object> retVal = new TreeMap<String, Object>(String.CASE_INSENSITIVE_ORDER);
	
	String gae = request.getHeader("X-AppEngine-Country");
	if (StringUtil.isEmpty(gae))
	{
		retVal.put("country", "");
		retVal.put("country_name", _("unknown"));
	}
	else
	{
		retVal.put("country", gae);
		retVal.put("country_name", gae);
		
		for (ULocale loop : ULocale.getAvailableLocales())
		{
			if (loop.getCountry().equals(gae))
			{
				retVal.put("country_name", loop.getDisplayCountry(uloc));
				break;
			}
		}
	}
	
	String json = JSONValue.toJSONString(retVal);
	
%><%@ include file="../_api/jsonp.inc" %>
