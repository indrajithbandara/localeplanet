package com.localeplanet.common;

import java.util.*;


public abstract class GenericLocaleCache
{
	/**
	 * this must match the directory name
	 */
	abstract public String getCode();
	
	/**
	 * list of all (normalized) locale codes from this data source
	 */
	abstract public String[] getCodes();
	
	/**
	 * get the description of this cache in the given language
	 */
	abstract public String getDescription(Locale loc);
	
	/**
	 * gets a generic interface to a locale
	 */
	abstract public GenericLocale getGeneric(String code);
	
	/**
	 * gets a valid (=existing) locale code for a given code
	 */
	abstract public String getNormalizedCode(String code);
	
	public boolean hasCountry()
	{
		return true;
	}
	
}
