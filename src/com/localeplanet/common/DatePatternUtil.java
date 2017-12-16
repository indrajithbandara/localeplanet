package com.localeplanet.common;

import java.text.*;
import java.util.*;
import com.localeplanet.dotnet.*;
import com.localeplanet.icu.*;
import com.localeplanet.java.*;
import com.localeplanet.google.*;

public class DatePatternUtil
{
	
	private static List<String> standardCodes = Arrays.asList(new String[] { "SHORT", "MEDIUM", "LONG", "FULL" });
	private static List<String> defaultCodes = Arrays.asList(new String[] { "SHORT_PADDED_CENTURY", "SHORT", "SHORT_NOYEAR", "SHORT_NODAY", "MEDIUM", "MEDIUM_NOYEAR", "MEDIUM_WEEKDAY_NOYEAR", "LONG_NODAY", "LONG", "FULL" });
	
	static private int styleToInt(String code)
	{
		int style = java.text.DateFormat.SHORT;
		if (code != null)
		{
			if (code.equals("FULL"))
			{
				style = java.text.DateFormat.FULL;
			}
			else if (code.equals("LONG"))
			{
				style = java.text.DateFormat.LONG;
			}
			else if (code.equals("MEDIUM"))
			{
				style = java.text.DateFormat.MEDIUM;
			}
		}
		
		return style;
	}
	
	static public String codeToJava(String code)
	{
		return code.toUpperCase().replace(':', '_');
	}
	
	static public String codeToJS(String code)
	{
		return code.toLowerCase().replace('_', ':');
	}
	
	static public String getPattern(int code, Locale loc)
	{
		DateFormat df = DateFormat.getDateInstance(code, loc);
		if (df instanceof SimpleDateFormat)
		{
			return ((SimpleDateFormat)df).toPattern();
		}
		
		return "";
	}
	
	static public String getPattern(String code, Locale loc)
	{
		if (code == null || code.length() == 0)
		{
			return getPattern(DateFormat.SHORT, loc);
		}
		
		String[] ArrCode = codeToJava(code).split("_");
		
		if (ArrCode == null || ArrCode.length == 0)
		{
			return  getPattern(DateFormat.SHORT, loc);
		}
		
		int style = styleToInt(ArrCode[0]);
		
		String pattern = getPattern(style, loc);
		
		if (ArrCode.length == 1)
		{
			return pattern;
		}
		
		for (int loop = 1; loop < ArrCode.length; loop++)
		{
			String modifier = ArrCode[loop];
			if (modifier.equals("CENTURY"))
			{
				pattern = pattern.replaceAll("\\byy\\b", "yyyy");
			}
			else if (modifier.equals("FULLWEEKDAY"))
			{
				if (pattern.indexOf("E") == -1)
				{
					pattern = "EEEE " + pattern;
				}
				else
				{
					pattern = pattern.replaceAll("(, )?E{,3}(, )?", " EEEE ");
				}
			}
			else if (modifier.equals("NODAY"))
			{
				pattern = pattern.replaceAll("((^)|([^'A-Za-z])|('[^']*'))+d{1,2}(([^'A-Za-z])|('[^']*')|($))+", " ");
			}
			else if (modifier.equals("NOYEAR"))
			{
				pattern = pattern.replaceAll("((^)|([^'A-Za-z])|('[^']*'))+y{2,4}(([^'A-Za-z])|('[^']*')|($))+", " ");
			}
			else if (modifier.equals("PADDED"))
			{
				pattern = pattern.replaceAll("\\bM\\b", "MM");
				pattern = pattern.replaceAll("\\bd\\b", "dd");
			}
			else if (modifier.equals("WEEKDAY"))
			{
				if (pattern.indexOf("E") == -1)
				{
					pattern = "EEE " + pattern;
				}
				else
				{
					pattern = pattern.replaceAll("(, )?E{4,}(, )?", " EEE ");
				}
			}
			else
			{
				//LATER: log it
			}
		}
		return pattern.trim();
	}
	
	static public String getOrder(String code, Locale loc)
	{
		String pattern = getPattern(code, loc);
		
		int year = pattern.indexOf('y');
		int month = pattern.indexOf('M');
		int day = pattern.indexOf('d');
		
		if (year == -1 || month == -1 || day == -1)
		{
			return pattern;
		}
		else if (year < month && month < day)
		{
			return "YMD";
		}
		else if (month < day && day < year)
		{
			return "MDY";
		}
		else if (day < month && month < year)
		{
			return "DMY";
		}
		else if (year < day && day < month)
		{
			return "YDM";
		}
		
		return pattern;
	}	
	
	static public String[] getDefaultCodes()
	{
		return defaultCodes.toArray(new String[ defaultCodes.size() ]);
	}
	
	static public String[] getStandardCodes()
	{
		return standardCodes.toArray(new String[ standardCodes.size() ]);
	}
}