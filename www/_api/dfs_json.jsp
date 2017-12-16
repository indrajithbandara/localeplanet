<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.MessageFormat,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
				 com.localeplanet.common.*,
				 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, Object> retVal = new TreeMap<String, Object>(String.CASE_INSENSITIVE_ORDER);
	
	DateFormatSymbols dfs = DateFormatSymbols.getInstance(uloc);
	
	JSONArray AmPmStrings = new JSONArray();
	AmPmStrings.addAll(Arrays.asList(dfs.getAmPmStrings()));
	retVal.put("am_pm", AmPmStrings);
	
	JSONArray Eras = new JSONArray();
	Eras.addAll(Arrays.asList(dfs.getEras()));
	retVal.put("era", Eras);
	
	JSONArray EraNames = new JSONArray();
	EraNames.addAll(Arrays.asList(dfs.getEraNames()));
	retVal.put("era_name", EraNames);
	
	JSONArray Months = new JSONArray();
	Months.addAll(Arrays.asList(dfs.getMonths()));
	retVal.put("month_name", Months);
	
	JSONArray ShortMonths = new JSONArray();
	ShortMonths.addAll(Arrays.asList(dfs.getShortMonths()));
	retVal.put("month_short", ShortMonths);
	
	JSONArray ShortWeekdays = new JSONArray();
	ShortWeekdays.addAll(Arrays.asList(Arrays.copyOfRange(dfs.getShortWeekdays(), 1, 8)));
	retVal.put("day_short", ShortWeekdays);
	
	JSONArray Weekdays = new JSONArray();
	Weekdays.addAll(Arrays.asList(Arrays.copyOfRange(dfs.getWeekdays(), 1, 8)));
	retVal.put("day_name", Weekdays);
	
	Locale jloc = uloc.toLocale();
	for (String code: DatePatternUtil.getStandardCodes())
	{
		retVal.put("order_" + code.toLowerCase(), DatePatternUtil.getOrder(code, jloc));
	}
	
	/*
	 * this is a fair bit of data, and is it really useful client-side???
	JSONArray ZoneStrings = new JSONArray();
	String[][] dfsZoneStrings = dfs.getZoneStrings();
	for (int loop = 0; loop < dfsZoneStrings.length; loop++)
	{
		JSONArray row = new JSONArray();
		row.addAll(Arrays.asList(dfsZoneStrings[loop]));
		ZoneStrings.add(row);
	}
	retVal.put("ZoneStrings", ZoneStrings);
	 */
	 
	String json = JSONValue.toJSONString(retVal);
	
%><%@ include file="../_api/jsonp.inc" %>
