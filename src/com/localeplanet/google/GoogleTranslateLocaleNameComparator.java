package com.localeplanet.google;

import java.util.*;

/**
 * comparator for GoogleTranslateLocales.
 */
public class GoogleTranslateLocaleNameComparator
    implements Comparator<GoogleTranslateLocale>
{
	static private final GoogleTranslateLocaleNameComparator INSTANCE = new GoogleTranslateLocaleNameComparator();
	
	private GoogleTranslateLocaleNameComparator()
	{
		// use getInstance instead
	}
	
    public int compare(GoogleTranslateLocale loc1, GoogleTranslateLocale loc2)
    {
        return loc1.getName().compareToIgnoreCase(loc2.getName());
    }
	
	static public GoogleTranslateLocaleNameComparator getInstance()
	{
		return INSTANCE;
	}
}
