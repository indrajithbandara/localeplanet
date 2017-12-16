<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.web.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, Object> retVal = new TreeMap<String, Object>(String.CASE_INSENSITIVE_ORDER);
	
	String[] ArrCode = null;
	
	String param = request.getParameter("pat");
	if (param != null)
	{
		ArrCode = param.split("\\,");
	}
	
	if (ArrCode == null)
	{
		ArrCode = DatePatternUtil.getDefaultCodes();
	}
	
	Locale jloc = uloc.toLocale();
	
	for (String code: ArrCode)
	{
		retVal.put(code, DatePatternUtil.getPattern(code, jloc));
	}
	
	String json = JSONValue.toJSONString(retVal);
	
%><%@ include file="../_api/jsonp.inc" %><%!

%>
