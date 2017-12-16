package com.localeplanet.dotnet;

import java.util.*;
import com.localeplanet.common.*;

public class GenericDotNetLocaleWrapper
	extends GenericLocale
{
	private DotNetLocale dnl;
	
	public GenericDotNetLocaleWrapper(DotNetLocale dnl)
	{
		this.dnl = dnl;
	}
	
	public String getCode()
	{
		return dnl.getCode();
	}
	
	public String getCountry()
	{
		return dnl.getCountry();
	}
	
	public String getDataSource()
	{
		return CommonLocaleUtil.DOTNET;
	}
	
	public String getLanguage()
	{
		return dnl.getLanguage();
	}
	
	public String getLanguageName(Locale loc)
	{
		return dnl.getLanguageName(loc);
	}
	
	public String getName(Locale loc)
	{
		return dnl.getName();
	}
	
	public String getNativeName()
	{
		return dnl.getNativeName();
	}
}

