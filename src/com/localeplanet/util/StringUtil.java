package com.localeplanet.util;

import java.io.*;
import java.util.*;

/**
 * string utility functions
 *
 */
public class StringUtil
{
	static public final String EMPTY = "";

	static public final String fromArray(String[] array)
	{
		return fromArray(array, "\n");
	}

	static public final String fromArray(String[] array, String delim)
	{
		if (array == null || array.length == 0)
		{
			return EMPTY;
		}

		StringBuffer buf = new StringBuffer();

		for (int loop = 0; loop < array.length; loop++)
		{
			buf.append(array[loop]);
			buf.append(delim);
		}

		return buf.toString();
	}

	static public final String getUniqueKey()
	{
		String uuid = UUID.randomUUID().toString();
		StringBuilder sb = new StringBuilder(32);
		sb.append(uuid.substring(0, 8));
		sb.append(uuid.substring(9, 13));
		sb.append(uuid.substring(14, 18));
		sb.append(uuid.substring(19, 23));
		sb.append(uuid.substring(24, uuid.length()));
		return sb.toString();
	}

	static public final String intern(String s)
	{
		return s == null ? null : s.intern();
	}

	static public final boolean isEmpty(String s)
	{
		if (s == null || s.length() == 0)
		{
			return true;
		}

		for (int loop = 0; loop < s.length(); loop++)
		{
			if (Character.isWhitespace(s.charAt(loop)) == false)
			{
				return false;
			}
		}
		return true;
	}

	static public final String pad(String target, int length, char ch)
	{
		if (target.length() >= length)
		{
			return target;
		}

		StringBuffer buf = new StringBuffer(length);
		int pad = length - target.length();
		for (int loop = 0; loop < pad; loop++)
		{
			buf.append(ch);
		}
		buf.append(target);

		return buf.toString();
	}
	/**
	 * converts a string to a boolean, allowing just about anything
	 */
	static public final boolean toBoolean(String s)
	{
		return toBoolean(s, false);
	}

	static public final boolean toBoolean(String s, boolean defaultValue)
	{
		if (s == null || s.length() == 0)
		{
			return defaultValue;
		}

		char ch = s.charAt(0);
		switch (ch)
		{
			case 't':
			case 'T':
			case '1':
			case '-':
			case 'Y':
			case 'y':
				return true;

			case 'F':
			case 'f':
			case 'N':
			case 'n':
			case '0':
				return false;
		}
		return defaultValue;
	}
	/**
	 * converts a CRLF (or CR or LF) string to array
	 */
	static public String[] toLines(String s)
	{
		if (s == null || s.length() == 0)
		{
			return new String[0];
		}

		ArrayList<String> lines = new ArrayList<String>();

		try
		{
			return StreamUtil.readStrings(new BufferedReader(new StringReader(s)));
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "StringUtil.toLines", e, s);
		}

		return new String[0];
	}

	static public Set<String> toSet(String s)
	{
		HashSet<String> set = new HashSet<String>();
		if (s != null)
		{
			String[] strings = s.split(",");
			if (strings != null)
			{
				for (int loop = 0; loop < strings.length; loop++)
				{
					set.add(strings[loop]);
				}
			}
		}
		return set;
	}

	static public String toString(byte[] bytes)
	{
		if (bytes == null)
		{
			return null;
		}

		try
		{
			return new String(bytes, "UTF-8");
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "StringUtil.toString", e.getMessage(), e);
		}

		return null;
	}

	static public String trim(String s)
	{
		if (s == null)
		{
			return EMPTY;
		}
		return s.trim();
	}

	static public String trimNull(String s)
	{
		if (s == null)
		{
			return null;
		}
		String result = s.trim();
		if (result.length() == 0)
		{
			return null;
		}
		
		return result;
	}

	static public String truncate(String s, int max)
	{
		if (s == null || max <= 0)
		{
			return EMPTY;
		}
		if (s.length() <= max)
		{
			return s;
		}

		return s.substring(0, max) + "\u2026";
	}
}
