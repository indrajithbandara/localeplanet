package com.localeplanet.web;

import java.io.*;
import com.localeplanet.util.*;

/**
 * encodes string into valid HTML content.  Anything strange (i.e. non-ASCII) is converted
 * to the decimal representation.  Thus the output is 7-bit and is valid UTF-8.
 *
 * See also <a href="http://www.w3.org/TR/html4/charset.html">W3C HTML 4 charset specs</a>
 *
 */
public class HtmlEncoder
{
	private static final int halfShift  = 10; /* used for shifting by 10 bits */

	private static final int halfBase = 0x0010000;
	private static final int halfMask = 0x03FF;

	private static final int UNI_SUR_HIGH_START = 0x0D800;
	private static final int UNI_SUR_HIGH_END   = 0x0DBFF;
	private static final int UNI_SUR_LOW_START  = 0x0DC00;
	private static final int UNI_SUR_LOW_END    = 0x0DFFF;

	/*
	 * this class contains only static functions and should not be instantiated
	 */
	private HtmlEncoder()
	{
	}

	static public void encode(Appendable out, int i)
		throws java.io.IOException
	{
		if (i <= 0x07FFF)
		{
			encode(out, (char)i);
		}
		else
		{
			out.append("&#x");
			out.append(Integer.toHexString(i));
			out.append(';');
		}
	}

	/**
	 * encodes a single character.  Not really Unicode-safe, since some Unicode chars may
	 * be spread across multiple java chars
	 *
	 * @param out the writer that where the valid html will be written
	 * @param ch the character to encode
	 */
	static public void encode(Appendable out, char ch)
		throws java.io.IOException
	{
		if (ch >= 'A' && ch <= 'z')
		{
			out.append(ch);
			return;
		}

		switch (ch)
		{
			case '<':
				out.append("&lt;");
				break;
			case '>':
				out.append("&gt;");
				break;
			case '"':
				out.append("&quot;");
				break;
			case '&':
				out.append("&amp;");
				break;
			case '\n':
				out.append("\n");
				break;
			case '\r':
				out.append("\r");
				break;
			// I don't think this is necessary - AM 2-26-2004
			//case '\'':
			//	out.append("&#039;");
			//    break;
			default:
				if (ch >= ' ' && ch <= '~')
				{
					out.append(ch);
				}
				else
				{
					out.append("&#x");
					out.append(Integer.toHexString(ch));
					out.append(';');
				}
		}
	}

	/**
	 * write html-safe string
	 *
	 * @param out the writer that where the valid html will be written
	 * @param src string to write
	 */
	static public void encode(Appendable out, String src)
		throws IOException
	{
		if (src == null || src.length() == 0)
		{
			return;
		}

		for (int loop = 0; loop < src.length(); loop++)
		{
			char ch = src.charAt(loop);
			if (ch < 0xD800)
			{
				encode(out, ch);
			}
			else if (ch < 0xD8FF && loop < src.length() - 1)
			{
				char ch2 = src.charAt(++loop);
				int uch = ((ch - UNI_SUR_HIGH_START) << halfShift) + (ch2 - UNI_SUR_LOW_START) + halfBase;
				encode(out, uch);
			}
			else
			{
				encode(out, ch);
			}
		}
	}

	static public String encode(String src)
	{
		if (src == null)
		{
			return "";
		}

		StringBuilder out = new StringBuilder(src.length());

		try
		{
			encode(out, src);
		}
		catch (IOException e)
		{
			EventLog.log(EventLog.ERROR, "HtmlEncoder.encode(str)", e, src);
		}

		return out.toString();
	}
}
