package com.localeplanet.common;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.dotnet.*;
import com.localeplanet.icu.*;
import com.localeplanet.java.*;
import com.localeplanet.google.*;
import com.localeplanet.util.*;

public class CommonLocaleUtil
{
	static private Map<String, GenericLocaleCache> cacheCache;
	
	/*
	 * these must match the directory names 
	 */
	public static final String DOTNET = "dotnet";
	public static final String GOOGLE = "google-translate";
	public static final String ICU = "icu";
	public static final String JAVA = "java";
	
	static
	{
		cacheCache = new LinkedHashMap<String, GenericLocaleCache>();
		cacheCache.put(ICU, ULocaleCache.getInstance());
		cacheCache.put(JAVA, LocaleCache.getInstance());
		cacheCache.put(DOTNET, DotNetLocaleCache.getInstance());
		cacheCache.put(GOOGLE, GoogleTranslateCache.getInstance());
	}
	
	private CommonLocaleUtil()
	{
		// do not instantiate: all methods static
	}
	
	static public GenericLocaleCache getCache(String code)
	{
		if (code == null)
		{
			return null;
		}

		return cacheCache.get(code);		
	}
	
	static public GenericLocaleCache[] getCaches()
	{
		return cacheCache.values().toArray(new GenericLocaleCache[ cacheCache.size() ]);
	}
	
	static public GenericLocale getGeneric(String code)
	{
		for (GenericLocaleCache theCache : getCaches())
		{
			GenericLocale theLocale = theCache.getGeneric(code);
			if (theLocale != null)
			{
				return theLocale;
			}
		}
		
		return null;
	}
	
	static public String getName(String code, Locale loc)
	{
		for (GenericLocaleCache theCache : getCaches())
		{
			GenericLocale theLocale = theCache.getGeneric(code);
			if (theLocale != null)
			{
				String name = theLocale.getName(loc);
				if (StringUtil.isEmpty(name) == false)
				{
					return name;
				}
			}
		}
		return code;
	}
}
