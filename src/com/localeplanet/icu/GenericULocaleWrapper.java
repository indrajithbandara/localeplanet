package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.common.*;


public class GenericULocaleWrapper
	extends GenericLocale
{
	private ULocale uloc;
	
	public GenericULocaleWrapper(ULocale uloc)
	{
		this.uloc = uloc;
	}
	
	public String getCode()
	{
		return LocaleNormalizer.normalize(uloc);
	}
	
	public String getCountry()
	{
		return uloc.getCountry();
	}
	
	public String getCountryName(Locale loc)
	{
		return uloc.getDisplayCountry(ULocale.forLocale(loc));
	}
	
	public String getDataSource()
	{
		return CommonLocaleUtil.ICU;
	}
	
	public String getDisplayCode()
	{
		return uloc.toString();
	}
	
	public String getLanguage()
	{
		return uloc.getLanguage();
	}
	
	public String getLanguageName(Locale loc)
	{
		return uloc.getDisplayLanguage(ULocale.forLocale(loc));
	}
	
	public String getName(Locale loc)
	{
		return uloc.getDisplayName(ULocale.forLocale(loc));
	}
	
	public String getNativeName()
	{
		return uloc.getDisplayName(uloc);
	}
}

