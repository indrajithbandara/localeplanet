package com.localeplanet.java;

import java.util.*;
import com.localeplanet.common.*;


public class GenericLocaleWrapper
	extends GenericLocale
{
	private Locale loc;
	public GenericLocaleWrapper(Locale loc)
	{
		this.loc = loc;
	}
	
	public String getCode()
	{
		return LocaleNormalizer.normalize(loc.toString());
	}
	
	public String getCountry()
	{
		return loc.getCountry();
	}
	
	public String getCountryName(Locale loc)
	{
		return loc.getDisplayCountry(loc);
	}
	
	public String getDataSource()
	{
		return CommonLocaleUtil.JAVA;
	}
	
	public String getDisplayCode()
	{
		return loc.toString();
	}
	
	public String getLanguage()
	{
		return loc.getLanguage();
	}
	
	public String getLanguageName(Locale loc)
	{
		return this.loc.getDisplayLanguage(loc);
	}
	
	public String getName(Locale loc)
	{
		return this.loc.getDisplayName(loc);
	}
	
	public String getNativeName()
	{
		return loc.getDisplayName(loc);
	}
}

