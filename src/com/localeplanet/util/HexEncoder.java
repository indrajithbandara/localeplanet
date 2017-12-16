package com.localeplanet.util;

import java.util.regex.*;

import com.localeplanet.util.EventLog;

/**
 * converts bytes to/from strings encoded in hex
 *
 */
public class HexEncoder
{
	static private final String[] bytes = new String[256];

	static
	{
		for (int loop = 0; loop <= 0x0F; loop++)
		{
			bytes[loop] = '0' + Integer.toHexString(loop);
		}
		for (int loop = 0x10; loop <= 0xFF; loop++)
		{
			bytes[loop] = Integer.toHexString(loop);
		}
	}
	/**
	 * encodes a int from 0 to 255 as a 2-character lowercase hex string
	 */
	public static final String toByteString(int i)
	{
		if (i > 0x0FF || i < 0x00)
		{
			throw new IllegalArgumentException("Attempt to encode " + i + " to a single byte");
		}
		return bytes[i] ;
	}

	/**
	 * converts an int from 0 to 255 to a *signed* byte, deal with
	 * signed/unsigned conversion issues
	 */
	public static final byte toByte(int i)
	{
		if (i > 0x0FF || i < 0x00)
		{
			throw new IllegalArgumentException("Attempt to encode " + i + " to a single byte");
		}
		if (i < 0x80)
		{
			return (byte)i;
		}
		return (byte)(-256 + i);
	}

	/**
	 * converts from a byte (-128 to 127) to an int (0 to 255)
	 */
	public static final int toInt(byte b)
	{
		if (b < 0)
		{
			return 256 + b;
		}
		return b;
	}

	/**
	 * converts a byte to a two-character string
	 */
	public static final String encode(byte b)
	{
		if (b < 0)
		{
			return bytes[256 + b];
		}
		return bytes[b];
	}

	/**
	 * converts from an int to a hex-string
	 */
	public static final String encode(int i, int len)
	{
		String result = Integer.toHexString(i);

		if (result.length() < len)
		{
			result = "00000000".substring(0, len - result.length()) + result;
		}

		return result;
	}

	/**
	 * converts from a byte array to hex string (lowercase)
	 */
	public static final String encode(byte[] data)
	{
		return encode(data, "");
	}

	public static final String encode(byte[] data, String separator)
	{
		if (data == null || data.length == 0)
		{
			return "" ;
		}

		StringBuffer buf = new StringBuffer(data.length * 2);

		String hexByte;
		for (int loop = 0; loop < data.length; loop++)
		{
			if (loop > 0)
			{
				buf.append(separator);
			}

			if (data[loop] < 0)
			{
				hexByte = bytes[256 + data[loop]];
			}
			else
			{
				hexByte = bytes[data[loop]];
			}

			buf.append(hexByte);
		}
		return buf.toString();
	}

	static final private Pattern p = Pattern.compile("[^\\p{XDigit}]*(0[xX])?(\\p{XDigit}{1,2})[^\\p{XDigit}]*");
	public static final byte[] decode(String hex)
	{
		if (hex == null || hex.length() == 0)
		{
			return new byte[0] ;
		}

		Matcher m = p.matcher(hex);

		int count = 0;
		int max = 1024;
		byte[] result = new byte[max];
		while (m.find())
		{
			if (count > max)
			{
				max += 100;
				byte[] tmp = new byte[max];
				System.arraycopy(result, 0, tmp, 0, result.length);
				result = tmp;
			}

			String s = m.group(2);

			int value = Integer.parseInt(s, 16);

			if (value < 127)
			{
				result[count++] = (byte)(value);
			}
			else
			{
				result[count++] = (byte)(value - 256);
			}
		}

		if (max != count - 1)
		{
			byte[] tmp = new byte[count];
			System.arraycopy(result, 0, tmp, 0, count);
			result = tmp;
		}

		return result;
	}


	/**
	 * converts from a hex string to a byte array
	 */
	public static final byte[] decodeFast(String hex)
	{
		if (hex == null || hex.length() == 0)
		{
			return new byte[0] ;
		}

		if ((hex.length() % 2) == 1)
		{
			Exception e = new java.lang.IllegalArgumentException("Array length must be a mulitple of 2");
			EventLog.log(EventLog.ERROR, "HexEncoder.decode", e, hex);
			// the extra char will just get ignored below
		}

		byte[] result = new byte[hex.length() / 2];

		try
		{
			for (int loop = 0; loop < result.length; loop++)
			{
				int value = Integer.parseInt(hex.substring(loop * 2, (loop * 2) + 2), 16);

				if (value < 127)
				{
					result[loop] = (byte)(value);
				}
				else
				{
					result[loop] = (byte)(value - 256);
				}
			}
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "HexEncoder.decode", e, hex);
		}
		return result ;
	}
}
