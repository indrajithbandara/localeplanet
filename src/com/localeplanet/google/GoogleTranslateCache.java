package com.localeplanet.google;

import java.io.*;
import java.util.*;
import org.json.simple.*;
import com.localeplanet.common.*;
import com.localeplanet.icu.*;
import com.localeplanet.util.*;


public class GoogleTranslateCache
	extends GenericLocaleCache
{
	static private final GoogleTranslateCache INSTANCE = new GoogleTranslateCache();
	
	private Map<String, String> cache;
	private Map<String, String> normalizeMap;
	
	private GoogleTranslateCache()
	{
		cache = new LinkedHashMap<String, String>();
		normalizeMap = new LinkedHashMap<String, String>();
		
		try
		{
			InputStream in = GoogleTranslateCache.class.getResourceAsStream("google-translate.json");
			String strData = StreamUtil.readString(in);
			in.close();
			
			strData = strData.replace('\'', '"');
			
			JSONObject jsonMap = (JSONObject)JSONValue.parseWithException(strData);
			
			for (Object keyObj: jsonMap.keySet())
			{
				String key = keyObj.toString();
				String value = jsonMap.get(keyObj).toString();
				
				cache.put(value, key);
				
				normalizeMap.put(value.toLowerCase(), key);
			}
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "GoogleTranslateCache.init", "Unable to load", e);
		}
	}
	
	public GoogleTranslateLocale[] getAvailableLocales()
	{
		List<GoogleTranslateLocale> retVal = new ArrayList<GoogleTranslateLocale>( cache.size() );
		
		for (String code : cache.keySet())
		{
			retVal.add( new GoogleTranslateLocale(code, cache.get(code)));
		}
		
		return retVal.toArray( new GoogleTranslateLocale[ retVal.size() ]);
	}
	
	public String getCode()
	{
		return "google-translate";
	}
	
	public String[] getCodes()
	{
		return cache.keySet().toArray( new String[ cache.size() ]);
	}
	
	public String getDescription(Locale loc)
	{
		return "Google\u00A0Translate";
	}
	
	public GenericLocale getGeneric(String code)
	{
		if (code == null || cache.get(code) == null)
		{
			return null;
		}
		
		return new GenericGoogleTranslateWrapper(code, cache.get(code));
	}
	
	public Map<String, String> getMap()
	{
		return cache;
	}
	
	public String getNormalizedCode(String code)
	{
		return normalizeMap.get(code.toLowerCase());
	}
	
	public boolean hasCountry()
	{
		return false;
	}
	
/*
 * static methods
 */
	static public GoogleTranslateCache getInstance()
	{
		return INSTANCE;
	}
}

