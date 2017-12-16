package com.localeplanet.google;

import java.util.*;
import com.localeplanet.common.*;


public class GenericGoogleTranslateWrapper
	extends GenericLocale
{
	private String code;
	private String name;
	
	public GenericGoogleTranslateWrapper(String code, String name)
	{
		this.code = code;
		this.name = name;
	}
	
	public String getCode()
	{
		return code;
	}
	
	public String getDataSource()
	{
		return CommonLocaleUtil.GOOGLE;
	}
	
	public String getName(Locale loc)
	{
		return name;
	}
	
	public String getNativeName()
	{
		return name;
	}
}

