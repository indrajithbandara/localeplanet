package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;

/**
 * comparator for ULocales.
 */
public class ULocaleCodeComparator
    implements Comparator<ULocale>
{
	static private final ULocaleCodeComparator INSTANCE = new ULocaleCodeComparator();
	
	private ULocaleCodeComparator()
	{
		// use getInstance instead
	}
	
    public int compare(ULocale loc1, ULocale loc2)
    {
        return loc1.toString().compareToIgnoreCase(loc2.toString());
    }
	
	static public ULocaleCodeComparator getInstance()
	{
		return INSTANCE;
	}
}
