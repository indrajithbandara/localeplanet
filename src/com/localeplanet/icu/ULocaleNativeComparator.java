package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;

/**
 * comparator for ULocales.
 */
public class ULocaleNativeComparator
    implements Comparator<ULocale>
{
	static private final ULocaleNativeComparator INSTANCE = new ULocaleNativeComparator();
	
	private ULocaleNativeComparator()
	{
		// use getInstance instead
	}
	
    public int compare(ULocale loc1, ULocale loc2)
    {
        return loc1.getDisplayName(loc1).compareToIgnoreCase(loc2.getDisplayName(loc2));
    }
	
	static public ULocaleNativeComparator getInstance()
	{
		return INSTANCE;
	}
}
