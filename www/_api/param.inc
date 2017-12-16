<%
	Locale loc = Localizer.getLocale();

	String localeCode = (String)request.getAttribute("urlparam");
	
	if ("auto".equals(localeCode))
	{
		localeCode = LocaleCache.getInstance().getNormalizedCode(loc.toString());
	}
	
	ULocale uloc = ULocaleCache.getInstance().getExact(localeCode);
	if (uloc == null)
	{
		uloc = ULocaleCache.getInstance().getExact(ULocaleCache.getInstance().getNormalizedCode(localeCode));
	}
	if (uloc == null)
	{
		uloc = ULocale.forLanguageTag(localeCode);
	}
	
	if (uloc == null)
	{
		String defaultLocale = request.getParameter("default");
		if (defaultLocale != null)
		{
			uloc = ULocaleCache.getInstance().getExact(defaultLocale);
		}
	}
	
	if (uloc == null)
	{
		uloc = ULocaleCache.getInstance().getExact("en-US");
	}
%>