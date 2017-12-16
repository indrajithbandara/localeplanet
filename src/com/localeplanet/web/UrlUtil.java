package com.localeplanet.web;

import java.io.*;
import java.nio.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.localeplanet.util.*;

/**
 * utility functions for dealing with URL's.
 *
 *
 * to understand the naming convention:

<table>
	<tr>
		<th>Name</th>
		<th>Meaning</th>
		<th>Example</th>
	</tr>
	<tr>
		<td>Global</td>
		<td>fully-qualified, including the protocol, host and port</td>
		<td>http://www.host.com/path/to/file.htm?query=string</td>
	</tr>
	<tr>
		<td>Local</td>
		<td>valid only for the current server</td>
		<td>/path/to/file.htm?query=string</td>
	</tr>
	<tr>
		<td>Url</td>
		<td>complete URL</td>
		<td>/path/to/file.htm?query=string</td>
	</tr>
	<tr>
		<td>Path</td>
		<td>everything but the querystring</td>
		<td>/path/to/file.htm</td>
	</tr>
	<tr>
		<td>Directory</td>
		<td>just the directories</td>
		<td>/path/to/</td>
	</tr>
	<tr>
		<td>File</td>
		<td>just the filename (including extension)</td>
		<td>file.htm</td>
	</tr>
	<tr>
		<td>QueryString</td>
		<td>just the querystring (including the &amp;'s but not the ?)</td>
		<td>query=string</td>
	</tr>
</table>
 *
 */
public class UrlUtil
{
	/*
	 * constants for request attribute names
	 */
	private static final String ATTR_QUERY = "javax.servlet.forward.query_string";
	private static final String ATTR_PATH = "javax.servlet.forward.request_uri";

	/*
	 * this class contains only static functions and should not be instantiated
	 */
	private UrlUtil()
	{
	}

	/**
	 * adds the protocol/host/port information
	 *
	 * NOTE: it does not include a trailing '/'
	 */
	public static final void addGlobal(StringBuffer buf, HttpServletRequest request)
	{
		String sScheme = request.getScheme();
		buf.append(sScheme);
		buf.append("://");

		buf.append(request.getServerName());

		addPort(buf, request);
	}

	/**
	 * adds the port to the url but only if it is a non-standard port
	 */
	static public void addPort(StringBuffer buf, ServletRequest request)
	{
		int iPort = request.getServerPort();
		String sScheme = request.getScheme();

		if ((iPort == 80  && sScheme.equalsIgnoreCase("http")) ||
			(iPort == 443 && sScheme.equalsIgnoreCase("https")))
		{
			// no port required
		}
		else
		{
			buf.append(':');
			buf.append(iPort);
		}
	}

	/**
	 * appends a parameter to the querystring but does not remove any existing
	 * values
	 */
	static public String appendParam(String url, String param, String value)
	{
		StringBuffer buf = new StringBuffer();

		buf.append(url);

		if (url.indexOf('?') < 0)
		{
			buf.append('?');
		}
		else
		{
			buf.append('&');
		}
		buf.append(makeParam(param, value));

		return buf.toString();
	}

	/**
	 * encodes a value for inclusion in a URL.  wrapper for java.net.URLEncoder
	 */
	static public String encode(String param)
	{
		if (param == null)
		{
			return "";
		}
		try
		{
			return java.net.URLEncoder.encode(param, "UTF-8");
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "UrlUtil.encode", e, param);
		}
		return "";
	}

	/**
	 * custom encoding for strings that will be used a path elements in a URL since
	 * different containers/browsers handle path encoding differently.
	 *
	 * these strings are very innocuous
	 *
	 * @param target string to encode (nulls okay)
	 * @return encoded string (never null)
	 */
	static public String encodeSegment(String target)
	{
		if (target == null || target.length() == 0)
		{
			return "";
		}
		byte[] bytes = null;
		try
		{
			bytes = target.getBytes("UTF-8");
		}
		catch (Exception e)
		{
			// never thrown: UTF-8 must be supported
		}

		StringBuffer buf = new StringBuffer();
		for (int loop = 0; loop < bytes.length; loop++)
		{
			if ((bytes[loop] >= 0x30 && bytes[loop] <= 0x39) ||	// numbers
				(bytes[loop] >= 0x41 && bytes[loop] <= 0x5a) ||	// upper case
				(bytes[loop] >= 0x61 && bytes[loop] <= 0x7a) ||	// lower case
				bytes[loop] == 0x2d ||							// hyphen
				bytes[loop] == 0x2e ||							// period
				bytes[loop] == 0x5f	||							// underscore
				bytes[loop] == 0x7e								// tilde
				)
			{
				buf.append((char)bytes[loop]);
			}
			else
			{
				buf.append('%');
				buf.append(HexEncoder.encode(bytes[loop]));
			}
		}

		return buf.toString();
	}

	/* decoder for strings encoded with encodeSegment.
	 *
	 * bad characters (anything other than 0-9A-Za-z and underscore) will be eaten.
	 * Mis-encoded strings will probably throw an exception (LATER: fix to eat them)
	 *
	 * @param target string to encode (nulls okay)
	 * @return encoded string (never null)
	 */
	static public String decodeSegment(String encoded)
	{
		if (encoded == null || encoded.length() == 0)
		{
			return "";
		}

		ByteBuffer buf = ByteBuffer.allocate(encoded.length());
		char[] chars = encoded.toCharArray();
		int count = 0;
		for (int loop = 0; loop < chars.length; loop++)
		{
			char ch = chars[loop];
			if (ch == '_')
			{
				String hex = new String(chars, loop+1, 2);
				byte[] b = HexEncoder.decode(hex);
				buf.put(b[0]);
				loop += 2;
				count++;
			}
			else if ((ch >= '0' && ch <= '9') ||
					 (ch >= 'A' && ch <= 'Z') ||
					 (ch >= 'a' && ch <= 'z') ||
					 ch == '.' ||
					 ch == '-')
			{
				buf.put((byte)ch);
				count++;
			}
			else
			{
				// eat it LATER: is this appropriate?
			}
		}
		buf.rewind();
		String result = "";
		try
		{
			result = new String(buf.array(), 0, count, "UTF-8");
		}
		catch (Exception e)
		{
			// never thrown: UTF-8 is always supported
		}
		return result;
	}

	/**
	 * Decodes an <code>application/x-www-form-urlencoded</code> string.
	 * A wrapper for <code>java.net.URLDecoder</code>.
	 *
	 * @param param the encoded string.
	 * @return the decoded string.
	 */
	static public String decode(String param)
	{
		if (param == null)
		{
			return null;
		}
		try
		{
			return java.net.URLDecoder.decode(param, "UTF-8");
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "UrlUtil.decode", e.getMessage(), e);
		}
		return null;
	}

	/**
	 * gets the website (including http:// and port (if not default), but not a trailing slash
	 */
	public static final String getGlobalSite(HttpServletRequest request)
	{
		StringBuffer buf = new StringBuffer();
		addGlobal(buf, request);

		return buf.toString();
	}

	/**
	 * global version of getLocalDirectory
	 */
	public static final String getGlobalDirectory(javax.servlet.http.HttpServletRequest request)
	{
		StringBuffer buf = new StringBuffer();
		addGlobal(buf, request);

		buf.append(getLocalDirectory(request));

		return buf.toString();
	}

	/**
	 * global version of getLocalPath
	 */
	public static final String getGlobalPath(HttpServletRequest request)
	{
		StringBuffer buf = new StringBuffer();
		addGlobal(buf, request);

		buf.append(getLocalPath(request));

		return buf.toString();
	}

	/**
	 * gets the full URL of a request
	 */
	public static final String getGlobalUrl(HttpServletRequest request)
	{
		StringBuffer buf = new StringBuffer();
		addGlobal(buf, request);

		buf.append(getLocalUrl(request));

		return buf.toString();
	}

	/**
	 * gets just the directory portion of the URL
	 *
	 * the returned string will include a trailing backslash
	 * the root directory will be "/"
	 */
	public static final String getLocalDirectory(HttpServletRequest request)
	{
		String path = getLocalPath(request);

		int pos = path.lastIndexOf('/');
		if (pos == -1)
		{
			return "/";
		}
		return path.substring(0, pos+1);
	}

	/**
	 * gets the extension of the file
	 *
	 * the returned string will *not* include the period
	 */
	public static final String getLocalExtension(HttpServletRequest request)
	{
		String file = UrlUtil.getLocalFile(request);

		int periodPos = file.lastIndexOf('.');
		if (periodPos == -1 || periodPos == file.length() - 1)
		{
			return "";
		}
		return file.substring(periodPos + 1);
	}

	/**
	 * gets just the file portion of the URL
	 *
	 * the returned string will *not* include a leading backslash
	 * the default page in a directory will be &quot;&quot;
	 */
	public static final String getLocalFile(HttpServletRequest request)
	{
		String path = getLocalPath(request);

		int pos = path.lastIndexOf('/');
		if (pos < 0 || pos == path.length() - 1)
		{
			return "";
		}
		return path.substring(pos+1);
	}

	/**
	 * gets the base name of the file (i.e. not including the extension)
	 *
	 * the returned string *will* include the period
	 */
	public static final String getLocalFileBase(HttpServletRequest request)
	{
		String file = UrlUtil.getLocalFile(request);

		int periodPos = file.lastIndexOf('.');
		if (periodPos == -1)
		{
			return file;
		}
		return file.substring(0, periodPos + 1);
	}

	/**
	 * gets the base URL of a request: this includes the path and page, but
	 * neither the prototol/host/port nor querystring
	 */
	public static final String getLocalPath(javax.servlet.http.HttpServletRequest request)
	{
		String original = (String)request.getAttribute(ATTR_PATH);
		if (original != null)
		{
			return original;
		}

		return request.getRequestURI();
	}

	/**
	 * gets the url of a page, including the querystring, but not including the protocol, host and port.
	 */
	public static final String getLocalUrl(javax.servlet.http.HttpServletRequest request)
	{
		String path = getLocalPath(request);
		String queryString = getQueryString(request);

		if (queryString == null || queryString.length() == 0)
		{
			return path;
		}
		
		return path + "?" + queryString;
	}

	/**
	 * gets the query string of a request even if it has been forwarded
	 */
	public static final String getQueryString(HttpServletRequest request)
	{
		String queryString = (String)request.getAttribute(ATTR_QUERY);
		if (queryString != null)
		{
			return queryString;
		}

		return request.getQueryString();
	}

	static public final String getServletPath(HttpServletRequest request)
	{
		return request.getServletPath();
	}

	static public final String getServletDirectory(HttpServletRequest request)
	{
		String path = getServletPath(request);

		int pos = path.lastIndexOf('/');
		if (pos == -1)
		{
			return "/";
		}
		return path.substring(0, pos+1);
	}

	/**
	 * gets the inputstream for a physical file corresponding to a request.
	 * Wrapper so it works when deployed as files and as a .WAR.
	 */
	static public final InputStream getRealInputStream(ServletContext application, HttpServletRequest request)
	{
		return application.getResourceAsStream(request.getServletPath());
	}

	/**
	 * gets the inputstream for a physical file corresponding to a request.
	 * Wrapper so it works when deployed as files and as a .WAR.
	 */
	static public final InputStream getRealInputStream(ServletContext application, String localUrl)
	{
		return application.getResourceAsStream(localUrl);
	}

	static public boolean isInclude(HttpServletRequest request)
	{
		return request.getAttribute("javax.servlet.include.request_uri") != null ;
	}

	/**
	 * makes a parameter string that can be added to a URL.  Really
	 * all it does is not make it if the value is null.
	 */
	public static final String makeParam(String paramName, String value)
	{
		if (value == null || value.length() == 0)
		{
			return "";
		}

		return UrlUtil.encode(paramName) + "=" + UrlUtil.encode(value);
	}

	public static final String makeParam(String paramName, String[] ArrValue)
	{
		if (ArrValue == null || ArrValue.length == 0)
		{
			return "";
		}

		StringBuffer buf = new StringBuffer();

		for (int loop = 0; loop < ArrValue.length; loop++)
		{
			buf.append(UrlUtil.encode(paramName));
			buf.append('=');
			buf.append(UrlUtil.encode(ArrValue[loop]));
			buf.append('&');
		}
		buf.deleteCharAt(buf.length() - 1);   // delete the extra &

		return buf.toString();
	}

	static public StringBuilder pathJoin(StringBuilder buf, LinkedList<String> list)
	{
		for (Iterator<String> iter = list.iterator(); iter.hasNext(); )
		{
			buf.append('/');
			buf.append(iter.next());
		}

		return buf;
	}

	static public LinkedList<String> pathSplit(String path)
	{
		LinkedList<String> result = new LinkedList<String>();
		if (path != null)
		{
			boolean slash = true;
			for (StringTokenizer tokenizer = new StringTokenizer(path, "/", true); tokenizer.hasMoreTokens(); )
			{
				slash = true; // provisional
				String token = tokenizer.nextToken();
				if ("..".equals(token))
				{
					if (result.size() > 0)
					{
						result.removeLast();
					}
				}
				else if (!("/".equals(token) || ".".equals(token)))
				{
					result.addLast(token);
					slash = false;
				}
			}
			if (slash)
			{
				// if the url ends with a slash, add on the welcome file
				result.addLast("index.jsp");
			}
		}
		return result;
	}

	/**
	 * called by any servlet/jsp that want the recieving page to pretend that
	 * is at the URL the user requested.  This should be called by anything that
	 * does a Forward
	 *
	 */
	static public final void setOriginal(javax.servlet.http.HttpServletRequest request)
	{
		/*
		 * don't overwrite existing original settings
		 */
		if (request.getAttribute(ATTR_PATH) != null)
		{
			return;
		}

		String path = request.getRequestURI();
		String queryString = request.getQueryString();

		request.setAttribute(ATTR_PATH, path);
		if (queryString != null)
		{
			request.setAttribute(ATTR_QUERY, queryString);
		}
	}

	/**
	 * special version for dealing with third party code that does Forwards
	 * (such as the standard error handlers)
	 */
	static public final void setOriginal(HttpServletRequest request, String url)
	{
		/*
		 * don't overwrite existing original settings
		 */
		if (request.getAttribute(ATTR_PATH) != null)
		{
			return;
		}

		if (url != null && url.length() > 0)
		{
			request.setAttribute(ATTR_PATH, url);
		}
	}

	static public final String setParam(String url, String param, String value)
	{
		StringBuffer buf = new StringBuffer();
		String newParam = makeParam(param, value);

		buf.append(url);

		if (url.indexOf('?') < 0)
		{
			/*
			 * no query string, so just append one
			 */
			if (newParam != null && newParam.length() > 0)
			{
				buf.append('?');
				buf.append(newParam);
			}
		}
		else
		{

			int pos;
			pos = url.indexOf('?' + param + '=');
			if (pos < 0)
			{
				pos = url.indexOf("&" + param + "=");
			}

			if (pos < 0)
			{
				/*
				 * it isn't there, so we can append it
				 */
				if (newParam != null && newParam.length() > 0)
				{
					buf.append('&');
					buf.append(newParam);
				}
			}
			else
			{
				int end = url.indexOf('&', pos+1);
				if (end > 0)
				{
					if (newParam != null && newParam.length() > 0)
					{
						buf.replace(pos+1, end, newParam);
					}
					else
					{
						// nuke it (included the following &)
						buf.replace(pos+1, end, newParam);
					}
				}
				else
				{
					if (newParam != null && newParam.length() > 0)
					{
						buf.replace(pos+1, buf.length(), newParam);
					}
					else
					{
						// nuke it (including the previous & or ?)
						buf.replace(pos, buf.length(), newParam);
					}
				}
			}
		}

		return buf.toString();
	}
}


