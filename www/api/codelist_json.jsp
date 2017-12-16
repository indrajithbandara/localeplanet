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
		 		 com.localeplanet.util.*"
%><%

	ULocaleCache theCache = ULocaleCache.getInstance();

	String[] ArrCode = theCache.getCodes();
	
	Arrays.sort(ArrCode);
	
	out.print(JSONValue.toJSONString(Arrays.asList(ArrCode)));
%>
