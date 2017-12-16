package com.localeplanet.dotnet;

import java.io.*;
import java.util.*;
import au.com.bytecode.opencsv.*;
import com.localeplanet.common.*;
import com.localeplanet.util.*;


public class DotNetLocaleCache
	extends GenericLocaleCache
{
	static private final DotNetLocaleCache INSTANCE = new DotNetLocaleCache();
	
	private Map<String, DotNetLocale> cache;
	private Map<String, String> normalizeMap;
	
	private DotNetLocaleCache()
	{
		cache = new LinkedHashMap<String, DotNetLocale>();
		normalizeMap = new HashMap<String, String>();
		
		try
		{
			InputStream in = DotNetLocaleCache.class.getResourceAsStream("dotnet.csv");
			
			InputStreamReader reader = new InputStreamReader(in, "UTF-8");
			
			CSVReader csv = new CSVReader(reader);
			
			while (true)
			{
				String[] cols = csv.readNext();
				if (cols == null)
				{
					break;
				}
				
				if (cols.length == 0 || (cols[0].length() > 0 && cols[0].charAt(0) == '#'))
				{
					continue;
				}
				
				DotNetLocale dnl = new DotNetLocale(cols);
				String key = dnl.getCode();
				
				cache.put(key, dnl);
				
				normalizeMap.put(key.toLowerCase(), key);
			}
			
			in.close();
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "DotNetLocaleCache.init", "Unable to load", e);
		}
	}
	
	public DotNetLocale[] getAvailableLocales()
	{
		List<DotNetLocale> retVal = new ArrayList<DotNetLocale>( cache.size() );
		
		retVal.addAll(cache.values());
		
		return retVal.toArray( new DotNetLocale[ retVal.size() ]);
	}
	
	public String getCode()
	{
		return "dotnet";
	}
	
	public String[] getCodes()
	{
		return cache.keySet().toArray( new String[ cache.size() ]);
	}
	
	public String getDescription(Locale loc)
	{
		return "Microsoft\u00A0.NET";
	}
	
	public DotNetLocale getExact(String code)
	{
		return cache.get(code);
	}
	
	public GenericLocale getGeneric(String code)
	{
		DotNetLocale dnl = getExact(code);
		
		if (dnl == null)
		{
			return null;
		}
		
		return new GenericDotNetLocaleWrapper(dnl);
	}
	
	public Map<String, DotNetLocale> getMap()
	{
		return cache;
	}
	
	public String getNormalizedCode(String code)
	{
		return normalizeMap.get(code.toLowerCase());
	}
	
/*
 * static methods
 */
	static public DotNetLocaleCache getInstance()
	{
		return INSTANCE;
	}
}

