package com.localeplanet.util;

import java.io.*;
import java.nio.*;
import java.nio.channels.*;
import java.util.*;

/**
 * utility functions for streams, including read and copy
 *
 * @author Andrew Marcuse
 * @version 2003.12.20
 */
public class StreamUtil
{
	/**
	 * copy
	 */
	static public void copy(InputStream in, OutputStream out)
		throws IOException
	{
		int count;
		byte[] buf = new byte[1024];

		while (true)
		{
			count = in.read(buf);

			if (count <= 0)
			{
				break;
			}
			out.write(buf, 0, count);
		}
		out.flush();
	}

	// CAUTION: this has never been tested!
	public void copy(ReadableByteChannel inch, WritableByteChannel ouch)
		throws IOException
	{
		ByteBuffer buf = ByteBuffer.allocateDirect(16 * 1024);

		while (inch.read(buf) != -1)
		{
			buf.flip();
			while (buf.hasRemaining())
			{
				ouch.write (buf);
			}
			buf.clear();
		}
	}

	/**
	 * copy a character stream
	 */
	static public void copy(Reader in, Writer out)
		throws IOException
	{
		int count;
		char[] buf = new char[1024];

		while (true)
		{
			count = in.read(buf);

			if (count <= 0)
			{
				break;
			}
			out.write(buf, 0, count);
		}
		out.flush();
	}

	static public byte[] readBinary(InputStream in)
		throws IOException
	{
		if (in == null)
		{
			return new byte[0];
		}

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		copy(in, out);

		return out.toByteArray() ;
	}

	static public String readString(InputStream in)
		throws IOException
	{
		if (in == null)
		{
			return "";
		}

		StringWriter writer = new StringWriter();
		InputStreamReader reader = new InputStreamReader(in, "UTF-8");

		copy(reader, writer);

		return writer.toString() ;
	}

	static public String[] readStrings(InputStream in)
		throws IOException
	{
		return readStrings(new BufferedReader(new InputStreamReader(in, "UTF-8")));
	}

	static public String[] readStrings(BufferedReader reader)
		throws IOException
	{
		ArrayList<String> lines = new ArrayList<String>();

		while (true)
		{
			String line = reader.readLine();
			if (line == null)
			{
				break;
			}
			lines.add(line);
		}

		return lines.toArray(new String[lines.size()]);
	}
}
