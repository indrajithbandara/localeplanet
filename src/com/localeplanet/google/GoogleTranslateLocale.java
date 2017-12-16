package com.localeplanet.google;


public class GoogleTranslateLocale
{
	String code;
	String name;
	
	GoogleTranslateLocale(String code, String name)
	{
		this.code = code;
		this.name = name;
	}
	
	public String getCode()
	{
		return code;
	}
	
	public String getName()
	{
		return name;
	}
}
