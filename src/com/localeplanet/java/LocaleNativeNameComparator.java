package com.localeplanet.java;

import java.util.*;

/**
 * comparator for Locales.
 */
public class LocaleNativeNameComparator
    implements Comparator<Locale>
{
	static private final LocaleNativeNameComparator INSTANCE = new LocaleNativeNameComparator();
	
	private LocaleNativeNameComparator()
	{
		// use getInstance instead
	}
	
    public int compare(Locale loc1, Locale loc2)
    {
        return loc1.getDisplayName(loc1).compareToIgnoreCase(loc2.getDisplayName(loc2));
    }
	
	static public LocaleNativeNameComparator getInstance()
	{
		return INSTANCE;
	}
}
