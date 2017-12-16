package com.localeplanet.dotnet;

import java.util.Locale;

public class DotNetLocale
{
	String code;
	String name;
	String nativeName;
	
	DotNetLocale(String[] cols)
	{
		this.code = cols[3];
		this.name = cols[1];
		this.nativeName = cols[4];
	}
	
	public String getCode()
	{
		return code;
	}
	
	public String getCountry()
	{
		int dash = code.lastIndexOf('-');
		if (dash == -1)
		{
			return "";
		}
		
		return code.substring(dash+1, code.length());
	}
	
	public String getCountryName(Locale loc)
	{
		int last = name.lastIndexOf(')');
		int first = name.lastIndexOf('(', last-1);
		
		if (first == -1 || last == -1)
		{
			return getLanguage();
		}
		
		return name.substring(first+1, last);
	}
	
	public String getLanguage()
	{
		int dash = code.indexOf('-');
		if (dash == -1)
		{
			return code;
		}
		
		return code.substring(0, dash);
	}
	
	public String getLanguageName(Locale loc)
	{
		int first = name.indexOf('(');
		
		if (first == -1)
		{
			return name;
		}
		
		return name.substring(0, first);
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getNativeName()
	{
		return nativeName;
	}
}
