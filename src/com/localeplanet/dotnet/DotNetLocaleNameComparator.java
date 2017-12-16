package com.localeplanet.dotnet;

import java.util.*;

/**
 * comparator for DotNetLocales.
 */
public class DotNetLocaleNameComparator
    implements Comparator<DotNetLocale>
{
	static private final DotNetLocaleNameComparator INSTANCE = new DotNetLocaleNameComparator();
	
	private DotNetLocaleNameComparator()
	{
		// use getInstance instead
	}
	
    public int compare(DotNetLocale loc1, DotNetLocale loc2)
    {
        return loc1.getName().compareToIgnoreCase(loc2.getName());
    }
	
	static public DotNetLocaleNameComparator getInstance()
	{
		return INSTANCE;
	}
}
