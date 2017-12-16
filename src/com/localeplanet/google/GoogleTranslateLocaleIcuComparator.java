package com.localeplanet.google;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.icu.*;

/**
 * comparator for GoogleTranslateLocales.
 */
public class GoogleTranslateLocaleIcuComparator
    implements Comparator<GoogleTranslateLocale>
{
	ULocale uloc;
	
	private GoogleTranslateLocaleIcuComparator(Locale loc)
	{
		this.uloc = ULocale.forLocale(loc);
		// use getInstance instead
	}
	
    public int compare(GoogleTranslateLocale loc1, GoogleTranslateLocale loc2)
    {
    	ULocale uloc1 = ULocaleCache.getInstance().getExact(loc1.getCode());
    	ULocale uloc2 = ULocaleCache.getInstance().getExact(loc2.getCode());
    	
    	if (uloc1 == null)
    	{
    		if (uloc2 == null)
    		{
    			return loc1.getName().compareToIgnoreCase(loc2.getName());
    		}
    		return -1;
    	}
    	else if (uloc2 == null)
    	{
    		return 1;
    	}
    	
    	return uloc1.getDisplayName(uloc).compareToIgnoreCase(uloc2.getDisplayName(uloc));
    }
	
	static public GoogleTranslateLocaleIcuComparator getInstance(Locale loc)
	{
		return new GoogleTranslateLocaleIcuComparator(loc);
	}
}
