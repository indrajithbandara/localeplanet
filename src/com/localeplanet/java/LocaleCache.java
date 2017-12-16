package com.localeplanet.java;

import java.util.*;
import com.localeplanet.common.*;


public class LocaleCache
	extends GenericLocaleCache
{
	static private final LocaleCache INSTANCE = new LocaleCache();
	
	private Map<String, Locale> cache;
	private Map<String, String> normalizeMap;
	
	private LocaleCache()
	{
		cache = new LinkedHashMap<String, Locale>();
		normalizeMap = new HashMap<String, String>();
		
		Locale[] ArrLocale = Locale.getAvailableLocales();
		
		Arrays.sort(ArrLocale, LocaleCodeComparator.getInstance());
		
		for (Locale loc: ArrLocale)
		{
			String key = LocaleNormalizer.normalize(loc.toString());
			
			if (key.startsWith("iw"))
			{
				key = "he" + key.substring(2, key.length());
			}
			else if (key.startsWith("in"))
			{
				key = "id" + key.substring(2, key.length());
			}
			cache.put(key, loc);
			
			normalizeMap.put(loc.toString().toLowerCase(), key);
			normalizeMap.put(key.toLowerCase(), key);
		}
		
		/*
		 * a couple of languages have country-specific and no generic language
		 */
		for (Locale loc: ArrLocale)
		{
			if (normalizeMap.get(loc.getLanguage()) == null)
			{
				normalizeMap.put(loc.getLanguage(), LocaleNormalizer.normalize(loc.toString()));
			}
		}
		normalizeMap.put("zz", "en-US");
	}
	
	public String getCode()
	{
		return "java";
	}
	
	public String[] getCodes()
	{
		return cache.keySet().toArray( new String[ cache.size() ]);
	}
	
	public String getDescription(Locale loc)
	{
		return "Java";
	}
	
	/**
	 * gets an exact match
	 */
	public Locale getExact(String code)
	{
		return cache.get(code);
	}
	
	public GenericLocale getGeneric(String code)
	{
		Locale loc = getExact(code);
		
		if (loc == null)
		{
			return null;
		}
		
		return new GenericLocaleWrapper(loc);
	}
	
	public String getNormalizedCode(String code)
	{
		if (code == null)
		{
			return null;
		}
		return normalizeMap.get(code.toLowerCase());
	}
	
/*
 * static methods
 */
	static public LocaleCache getInstance()
	{
		return INSTANCE;
	}
}

