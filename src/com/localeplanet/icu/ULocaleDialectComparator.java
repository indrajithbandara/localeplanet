package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;

/**
 * comparator for Locales.
 */
public class ULocaleDialectComparator
    implements Comparator<ULocale>
{
	ULocale loc;
	
	public ULocaleDialectComparator(ULocale loc)
	{
		this.loc = loc;
	}
	
    public int compare(ULocale loc1, ULocale loc2)
    {
        return loc1.getDisplayNameWithDialect(loc).compareToIgnoreCase(loc2.getDisplayNameWithDialect(loc));
    }
}
