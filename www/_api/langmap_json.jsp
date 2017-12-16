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
%><%@ include file="../_api/param.inc" %><%

	LinkedHashMap<String, String> retVal = new LinkedHashMap<String, String>();
	
	ULocaleCache theCache = ULocaleCache.getInstance();

	boolean nativeName = StringUtil.toBoolean(request.getParameter("native"));	
	
	String[] ArrCode = theCache.getCodes();
	String langParam = request.getParameter("lang");
	if (StringUtil.isEmpty(langParam))
	{
		ArrCode = theCache.getCodes();
	}
	else
	{
		ArrCode = langParam.split(",");
	}
	
	Map<String, String> codeMap = new HashMap<String, String>();
	for (String code : ArrCode)
	{
		if (code.matches("[a-z]*") == false)
		{
			continue;
		}
		ULocale current = theCache.getExact(code);
		if (current == null)
		{
			continue;
		}
		codeMap.put(code, current.getDisplayName(nativeName ? current : uloc));
	}
	
	ArrCode = codeMap.keySet().toArray(new String[ codeMap.size() ]);
	
	Arrays.sort(ArrCode, new MapValueComparator(codeMap));
	
	for (String code : ArrCode)
	{
		retVal.put(code, codeMap.get(code));
	}
	
	out.print(JSONValue.toJSONString(retVal));
	
	
%>
