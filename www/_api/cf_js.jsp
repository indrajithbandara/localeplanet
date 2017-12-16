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

	String param = request.getParameter("pat");

	Locale jloc = uloc.toLocale();

	String pattern = null;




	String json = "";

%>
