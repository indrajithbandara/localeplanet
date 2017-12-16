package com.localeplanet.dotnet;

import java.util.*;

/**
 * comparator for DotNetLocales.
 */
public class DotNetLocaleNativeNameComparator
    implements Comparator<DotNetLocale>
{
	static private final DotNetLocaleNativeNameComparator INSTANCE = new DotNetLocaleNativeNameComparator();
	
	private DotNetLocaleNativeNameComparator()
	{
		// use getInstance instead
	}
	
    public int compare(DotNetLocale loc1, DotNetLocale loc2)
    {
        return loc1.getNativeName().compareToIgnoreCase(loc2.getNativeName());
    }
	
	static public DotNetLocaleNativeNameComparator getInstance()
	{
		return INSTANCE;
	}
}
