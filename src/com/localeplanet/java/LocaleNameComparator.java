package com.localeplanet.java;

import java.util.*;

/**
 * comparator for Locales.
 */
public class LocaleNameComparator
    implements Comparator<Locale>
{
	private Locale loc; 
	
	// use getInstance in case we decide to cache in the future
	private LocaleNameComparator(Locale loc)
	{
		this.loc = loc;
	}
	
    public int compare(Locale loc1, Locale loc2)
    {
        return loc1.getDisplayName(loc).compareToIgnoreCase(loc2.getDisplayName(loc));
    }
	
	static public LocaleNameComparator getInstance(Locale loc)
	{
		return new LocaleNameComparator(loc);
	}
}
