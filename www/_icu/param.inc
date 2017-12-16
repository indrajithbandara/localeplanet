<%

	Locale loc = Localizer.getLocale();
	
	String localeCode = (String)request.getAttribute("urlparam");
	
	if (localeCode == null || localeCode.length() == 0 || localeCode.equals("auto"))
	{
		HttpUtil.Redirect(request, response, "/icu/" + UrlUtil.encode(loc.toString()) + "/" + UrlUtil.getLocalFile(request));
		return;
	}
	
	ULocale target = ULocaleCache.getInstance().getExact(localeCode);
	if (target == null)
	{
		String normalized = ULocaleCache.getInstance().getNormalizedCode(localeCode);
		if (normalized != null)
		{
			HttpUtil.Redirect(request, response, "/icu/" + UrlUtil.encode(normalized) + "/" + UrlUtil.getLocalFile(request));
		}
		else
		{
			response.sendError(response.SC_NOT_FOUND);
		}
		return;
	}
	
%>
