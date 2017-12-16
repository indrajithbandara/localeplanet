package com.localeplanet.dotnet;

import java.util.*;

/**
 * comparator for DotNetLocales.
 */
public class DotNetLocaleCodeComparator
    implements Comparator<DotNetLocale>
{
	static private final DotNetLocaleCodeComparator INSTANCE = new DotNetLocaleCodeComparator();
	
	private DotNetLocaleCodeComparator()
	{
		// use getInstance instead
	}
	
    public int compare(DotNetLocale loc1, DotNetLocale loc2)
    {
        return loc1.getCode().compareToIgnoreCase(loc2.getCode());
    }
	
	static public DotNetLocaleCodeComparator getInstance()
	{
		return INSTANCE;
	}
}
