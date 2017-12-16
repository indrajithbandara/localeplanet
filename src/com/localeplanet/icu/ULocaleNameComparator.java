package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;

/**
 * comparator for Locales.
 */
public class ULocaleNameComparator
    implements Comparator<ULocale>
{
	ULocale loc;
	
	public ULocaleNameComparator(ULocale loc)
	{
		this.loc = loc;
	}
	
    public int compare(ULocale loc1, ULocale loc2)
    {
        return loc1.getDisplayName(loc).compareToIgnoreCase(loc2.getDisplayName(loc));
    }
}
