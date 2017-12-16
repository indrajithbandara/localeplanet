package com.localeplanet.google;

import java.util.*;

/**
 * comparator for GoogleTranslateLocales.
 */
public class GoogleTranslateLocaleCodeComparator
    implements Comparator<GoogleTranslateLocale>
{
	static private final GoogleTranslateLocaleCodeComparator INSTANCE = new GoogleTranslateLocaleCodeComparator();
	
	private GoogleTranslateLocaleCodeComparator()
	{
		// use getInstance instead
	}
	
    public int compare(GoogleTranslateLocale loc1, GoogleTranslateLocale loc2)
    {
        return loc1.getCode().compareToIgnoreCase(loc2.getCode());
    }
	
	static public GoogleTranslateLocaleCodeComparator getInstance()
	{
		return INSTANCE;
	}
}
