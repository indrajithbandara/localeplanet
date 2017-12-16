package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.common.*;


public class ULocaleCache
	extends GenericLocaleCache
{
	static private final ULocaleCache INSTANCE = new ULocaleCache();
	
	private Map<String, ULocale> cache;
	private Map<String, String> normalizeMap;
	
	private ULocaleCache()
	{
		cache = new LinkedHashMap<String, ULocale>();
		normalizeMap = new HashMap<String, String>();
		
		ULocale[] ArrLocale = ULocale.getAvailableLocales();
		
		Arrays.sort(ArrLocale, ULocaleCodeComparator.getInstance());
		
		for (ULocale loc: ArrLocale)
		{
			String key = LocaleNormalizer.normalize(loc.toString());
			cache.put(key, loc);
			
			normalizeMap.put(loc.toString().toLowerCase(), key);
			normalizeMap.put(key.toLowerCase(), key);
		}
		
		// this list should include everything for which ULocale.forLocale() doesn't return the best ULocale: see /support/icu4j-missing.html
		normalizeMap.put("in", "id");
		normalizeMap.put("in_id", "id-ID");
		normalizeMap.put("iw", "he");
		normalizeMap.put("iw_il", "he_IL");
		//nearest.put("ja_JP_JP", cache.get(""));
		normalizeMap.put("no_no", "nn_NO");
		normalizeMap.put("no_no_ny", "nn_NO");
		normalizeMap.put("sr_ba", "sr_Cyrl_BA");
		normalizeMap.put("sr_cs", "sr_Cyrl_CS");
		normalizeMap.put("sr_me", "sr_Cyrl_ME");
		normalizeMap.put("sr_rs", "sr_Cyrl_RS");
		//nearest.put("th_TH_TH", cache.get(""));
		normalizeMap.put("zh_cn", "zh_Hant_CN");
		normalizeMap.put("zh_hk", "zh_Hant_HK");
		normalizeMap.put("zh_sg", "zh_Hant_SG");
		normalizeMap.put("zh_tw", "zh_Hant_TW");
		//nearest.put("", cache.get(""));
	}
	
	public ULocale[] getChildren(String code)
	{
		List<ULocale> result = new ArrayList<ULocale>();
		
		for (String target : cache.keySet())
		{
			if (target.startsWith(code) == false)
			{
				continue;
			}
			
			if (target.equals(code))
			{
				continue;
			}
			result.add(cache.get(target));
		}
		
		return result.toArray(new ULocale[ result.size() ]);
	}
	
	public String getCode()
	{
		return "icu";
	}
	
	public String[] getCodes()
	{
		return cache.keySet().toArray( new String[ cache.size() ]);
	}
	
	public String getDescription(Locale loc)
	{
		return "ICU";
	}
	
	/**
	 * gets an exact match
	 */
	public ULocale getExact(String code)
	{
		return cache.get(code);
	}
	
	
	public GenericLocale getGeneric(String code)
	{
		ULocale uloc = getExact(code);
		
		if (uloc == null)
		{
			return null;
		}
		
		return new GenericULocaleWrapper(uloc);
	}

	public ULocale[] getLanguage(String langCode)
	{
		String target = langCode + "_";
		List<ULocale> result = new ArrayList<ULocale>();
		
		for (String key : cache.keySet())
		{
			if (key.startsWith(target))
			{
				result.add(cache.get(key));
			}
		}
		
		return result.toArray( new ULocale[ result.size() ]);
	}
	
	public String getNormalizedCode(String code)
	{
		return normalizeMap.get(code.toLowerCase());
	}
	
	public ULocale getParent(String code)
	{
		int pos = code.lastIndexOf('_');
		if (pos == -1)
		{
			return null;
		}
		
		return getExact(code.substring(0, pos));
	}
	
	public ULocale[] getSiblings(String code)
	{
		List<ULocale> result = new ArrayList<ULocale>();
		
		int pos = code.lastIndexOf('_');
		if (pos > 0)
		{
			String start = code.substring(0, pos+1);
			
			for (String target : cache.keySet())
			{
				if (target.startsWith(start) == false)
				{
					continue;
				}
				
				if (target.equals(code))
				{
					continue;
				}
				result.add(cache.get(target));
			}
		}
		
		return result.toArray(new ULocale[ result.size() ]);
	}
	
/*
 * static methods
 */
	static public ULocaleCache getInstance()
	{
		return INSTANCE;
	}
}

