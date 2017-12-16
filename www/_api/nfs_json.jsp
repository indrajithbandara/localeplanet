<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
				 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, Object> retVal = new TreeMap<String, Object>(String.CASE_INSENSITIVE_ORDER);
	
	DecimalFormatSymbols nfs = DecimalFormatSymbols.getInstance(uloc);

	//LATER: simple json doesn't deal with chars?!?!
	retVal.put("decimal_separator", new String(new char[] { nfs.getDecimalSeparator() } ));
	retVal.put("grouping_separator", new String(new char[] { nfs.getGroupingSeparator() }));
	retVal.put("minus", new String(new char[] { nfs.getMinusSign() }));
		
	 
	String json = JSONValue.toJSONString(retVal);
	
%><%@ include file="../_api/jsonp.inc" %>