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
		 		 com.localeplanet.web.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, Object> retVal = new TreeMap<String, Object>(String.CASE_INSENSITIVE_ORDER);
	retVal.put("tag_original", localeCode);
	
	retVal.put("tag_icu", uloc.toString());
	retVal.put("tag_ietf", uloc.toLanguageTag());
	retVal.put("name", uloc.getDisplayName(uloc));
	retVal.put("language", uloc.getLanguage());
	retVal.put("language_name", uloc.getDisplayLanguage(uloc));
	retVal.put("language3", uloc.getISO3Language());
	retVal.put("country", uloc.getCountry());
	retVal.put("country_name", uloc.getDisplayCountry(uloc));
	retVal.put("country3", uloc.getISO3Country());
	
	String json = JSONValue.toJSONString(retVal);
	
%><%@ include file="../_api/jsonp.inc" %>
