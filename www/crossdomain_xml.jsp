<%@ page buffer="16kb"
		 contentType="text/xml;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.io.*,
		 		 java.util.*,
				 java.util.regex.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*"
%><?xml version="1.0" ?>
<cross-domain-policy>
	<site-control permitted-cross-domain-policies="master-only"/>
	<allow-access-from domain="*"/>
	<allow-http-request-headers-from domain="*" headers="*"/>
</cross-domain-policy>
