<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.ibm.icu.util.Currency,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.util.*"
%><%@ include file="../_api/param.inc" %><%

	Map<String, JSONObject> retVal = new TreeMap<String, JSONObject>();

	boolean showName = StringUtil.toBoolean(request.getParameter("name"));
	boolean showPattern = StringUtil.toBoolean(request.getParameter("pattern"));

	Date today = new Date();

	for (ULocale target: Currency.getAvailableULocales())
	{
		String[] ArrCode = Currency.getAvailableCurrencyCodes(target, today);

		if (ArrCode == null)
		{
			continue;
		}

		for (String code: ArrCode)
		{
			if (retVal.get(code) != null)
			{
				continue;
			}

			Currency theCurrency = Currency.getInstance(code);
			NumberFormat nf = NumberFormat.getCurrencyInstance(uloc);
			JSONObject jsonCurrency = new JSONObject();
			jsonCurrency.put("code", theCurrency.getCurrencyCode());
			jsonCurrency.put("symbol", theCurrency.getSymbol(uloc));
			jsonCurrency.put("symbol_native", theCurrency.getSymbol(target));
			if (showName)
			{
				jsonCurrency.put("name", theCurrency.getName(uloc, Currency.LONG_NAME, new boolean[] { false }));
				jsonCurrency.put("name_plural", theCurrency.getName(uloc, Currency.PLURAL_LONG_NAME, "", new boolean[] { false }));
			}
			jsonCurrency.put("decimal_digits", theCurrency.getDefaultFractionDigits());
			jsonCurrency.put("rounding", theCurrency.getRoundingIncrement());
			retVal.put(code, jsonCurrency);
		}
	}

	out.print(JSONValue.toJSONString(retVal));


%>
