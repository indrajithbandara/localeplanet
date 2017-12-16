package com.localeplanet.common;

import java.util.*;
import static com.localeplanet.ui.Macro.*;

public abstract class GenericLocale
{
	abstract public String getCode();
	abstract public String getDataSource();
	abstract public String getName(Locale loc);
	abstract public String getNativeName();
	
	public char[] getDateOrder()
	{
		throw new UnsupportedOperationException();
	}
	
	public String[] getDayNames(Locale loc)
	{
		throw new UnsupportedOperationException();
	}
	
	public String getCountry()
	{
		return "";
	}
	
	public String getCountryName(Locale loc)
	{
		return getCountry();
	}
	
	public String getDisplayCode(Locale loc)
	{
		String code = getCode();
		if (code.equals(""))
		{
			return t("(blank)", loc);
		}
		return code;
	}
	
	public String getLanguage()
	{
		return "";
	}
	
	public String getLanguageName(Locale loc)
	{
		return getLanguage();
	}
	
	public String[] getMonthNames(Locale loc)
	{
		throw new UnsupportedOperationException();
	}
	
	public boolean hasDateOrder()
	{
		return false;
	}
	
	public boolean hasDayNames()
	{
		return false;
	}
	
	public boolean hasMonthNames()
	{
		return false;
	}
	
}
