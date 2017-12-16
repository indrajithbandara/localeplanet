package com.localeplanet.java;

import java.util.*;

/**
 * comparator for Locales.
 */
public class LocaleCodeComparator
    implements Comparator<Locale>
{
	static private final LocaleCodeComparator INSTANCE = new LocaleCodeComparator();
	
	private LocaleCodeComparator()
	{
		// use getInstance instead
	}
	
    public int compare(Locale loc1, Locale loc2)
    {
        return loc1.toString().compareToIgnoreCase(loc2.toString());
    }
	
	static public LocaleCodeComparator getInstance()
	{
		return INSTANCE;
	}
}
