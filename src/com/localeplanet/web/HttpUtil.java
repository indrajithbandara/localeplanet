package com.localeplanet.web;

import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.logging.*;
import com.localeplanet.util.*;

/**
 * wrappers for common HTTP functionality
 *
 */
public class HttpUtil
{
	static public void Forward(HttpServletRequest request, HttpServletResponse response, String target)
	{
		try
		{
			UrlUtil.setOriginal(request);
			//doesn't do any good: you end up with 2!!!! response.setHeader("Content-Location", UrlUtil.getGlobalUrl(request));

			if (target == null)
			{
				Exception e = new NullPointerException("target cannot be null");
				EventLog.log(EventLog.ERROR, "HttpUtil.Forward", e, request, response);
				response.sendError(404);
				return;
			}

			if (target.charAt(0) != '/')
			{
				target = UrlUtil.getLocalDirectory(request) + target;
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher(target);

			if (dispatcher == null)
			{
				Exception e = new IllegalArgumentException("Unable get dispatcher for '" + target + "'");
				EventLog.log(EventLog.ERROR,  "HttpUtil.Forward", e, request, response);
				response.sendError(500);
				return;
			}

			/*if (response.isCommitted())
			{
				Exception e = new Exception("Response already committed during dispatch to '" + target + "'");
				EventLog.log(EventLog.ERROR,  UrlUtil.getLocalPath(request), e, request, response);
				return;
			}
			response.reset();*/

			dispatcher.forward(request, response);
		}
		catch (Exception e)
		{
			if (e instanceof java.io.IOException == false)
			{
				EventLog.log(EventLog.ERROR,  UrlUtil.getLocalPath(request), e, request, response, target);
			}
			//LATER: should we re-throw?
			try
			{
				request.setAttribute("javax.servlet.error.exception", e);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/_err/500.jsp");
				dispatcher.forward(request, response);
				// no: this hides 500's in pages
				//if (response.isCommitted() == false)
				//{
				//    response.sendError(404);
				//}
			}
			catch (Exception nested_e)
			{
				//deliberatly doing nothing
			}
		}
	}

	static public void ForwardName(ServletContext application, HttpServletRequest request, HttpServletResponse response, String target)
	{
		try
		{
			UrlUtil.setOriginal(request);
			RequestDispatcher dispatcher = application.getNamedDispatcher(target);
			dispatcher.forward(request, response);
			return;
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR,  UrlUtil.getLocalPath(request), e, request, response, target);
		}
	}

	static public Cookie getCookie(HttpServletRequest request, String cookieName)
	{
		Cookie[] cookies = request.getCookies();

		if (cookies == null)
		{
			return null;
		}

		for (int loop = 0; loop < cookies.length; loop++)
		{
			if (cookieName.equalsIgnoreCase(cookies[loop].getName()))
			{
				return cookies[loop];
			}
		}
		return null;
	}

	static public void Include(HttpServletRequest request, HttpServletResponse response, String target)
	{
		try
		{
			UrlUtil.setOriginal(request);

			if (target == null)
			{
				Exception e = new NullPointerException("target cannot be null");
				EventLog.log(EventLog.ERROR,  "HttpUtil.Include", e, request, response);
				response.sendError(404);
				return;
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher(target);

			if (dispatcher == null)
			{
				Exception e = new IllegalArgumentException("Unable get dispatcher for '" + target + "'");
				EventLog.log(EventLog.ERROR,  "HttpUtil.Forward", e, request, response);
				response.sendError(500);
				return;
			}

			dispatcher.include(request, response);
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR,  UrlUtil.getLocalPath(request), e, request, response, target);
		}
	}

	static public void IncludeName(ServletContext application, HttpServletRequest request, HttpServletResponse response, String target)
	{
		try
		{
			UrlUtil.setOriginal(request);
			RequestDispatcher dispatcher = application.getNamedDispatcher(target);
			dispatcher.include(request, response);
			return;
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR,  UrlUtil.getLocalPath(request), e, request, response, target);
		}
	}

	public static void Redirect(HttpServletRequest request, HttpServletResponse response, String url)
	{
		try
		{
			StringBuffer fullUrl = new StringBuffer();
			if (url.startsWith("http:") || url.startsWith("https:"))
			{
				fullUrl.append(url);
			}
			else if (url.charAt(0) == '/' && url.length() > 1 && url.charAt(1) == '/')
			{
				fullUrl.append(request.getScheme());
				fullUrl.append(':');
				fullUrl.append(url);
			}
			else if (url.charAt(0) == '/')
			{
				UrlUtil.addGlobal(fullUrl, request);
				fullUrl.append(url);
			}
			else
			{
				fullUrl.append(UrlUtil.getGlobalDirectory(request));
				fullUrl.append(url);
			}

			if (response.isCommitted())
			{
				EventLog.log(EventLog.ERROR,  "HttpUtil.Redirect", "Response already committed", new Exception("Response already committed for " + UrlUtil.getLocalUrl(request) + " to " + fullUrl.toString()), request, response);
				return;
			}
			response.sendRedirect(fullUrl.toString());
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR,  "HttpUtil.Redirect", "Redirect to '" + url + "' failed: " + e.getMessage(), e, request, response);
		}
	}

	/**
	 * forces a response to be downloaded instead of viewed in the browser
	 */
	static public final void setDownload(HttpServletResponse response, String fileName)
	{
		response.setContentType("application/binary");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
	}

	static public String toString(HttpServletResponse response)
	{
		StringBuffer buf = new StringBuffer();
		try
		{
			buf.append("RESPONSE\n");
			buf.append("========\n");
			buf.append("response.getBufferSize()=");
			buf.append(response.getBufferSize());
			buf.append("\n");
			buf.append("response.getCharacterEncoding()=");
			buf.append(response.getCharacterEncoding());
			buf.append("\n");
			buf.append("response.getClass().getName()=");
			buf.append(response.getClass().getName());
			buf.append("\n");
			buf.append("response.getContentType()=");
			buf.append(response.getContentType());
			buf.append("\n");
			buf.append("response.getLocale()=");
			buf.append(response.getLocale().toString());
			buf.append("\n");
			buf.append("response.isCommitted()=");
			buf.append(response.isCommitted());
			buf.append("\n");
		}
		catch (Exception e)
		{
			// No logging, since logger will call this!
			Logger.getAnonymousLogger().log(Level.SEVERE, "HttpUtil.toString(response): " + e.getMessage(), e);
		}

		return buf.toString();

	}

	static public String toString(HttpServletRequest request)
	{
		StringBuffer buf = new StringBuffer();
		try
		{
			Enumeration enumeration;

			buf.append("BASE INFO\n");
			buf.append("=========\n");

			buf.append("request.getAuthType()=");
			buf.append(request.getAuthType());
			buf.append('\n');
			buf.append("request.getClass().getName()=");
			buf.append(request.getClass().getName());
			buf.append('\n');
			buf.append("request.getCharacterEncoding()=");
			buf.append(request.getCharacterEncoding());
			buf.append('\n');
			buf.append("request.getContentLength()=");
			buf.append(request.getContentLength());
			buf.append('\n');
			buf.append("request.getContentType()=");
			buf.append(request.getContentType());
			buf.append('\n');
			buf.append("request.getContextPath()=");
			buf.append(request.getContextPath());
			buf.append('\n');
			buf.append("request.getLocale()=");
			buf.append(request.getLocale().toString());
			buf.append('\n');
			buf.append("request.getMethod()=");
			buf.append(request.getMethod());
			buf.append('\n');
			buf.append("request.getPathInfo()=");
			buf.append(request.getPathInfo());
			buf.append('\n');
			buf.append("request.getPathTranslated()=");
			buf.append(request.getPathTranslated());
			buf.append('\n');
			buf.append("request.getProtocol()=");
			buf.append(request.getProtocol());
			buf.append('\n');
			buf.append("request.getQueryString()=");
			buf.append(request.getQueryString());
			buf.append('\n');
			buf.append("request.getRemoteAddr()=");
			buf.append(request.getRemoteAddr());
			buf.append('\n');
			//getRemoteHost is skipped because the reverse DNS takes too long
			buf.append("request.getRemotePort()=");
			buf.append(request.getRemotePort());
			buf.append('\n');
			buf.append("request.getRemoteUser()=");
			buf.append(request.getRemoteUser());
			buf.append('\n');
			buf.append("request.getRequestedSessionId()=");
			buf.append(request.getRequestedSessionId());
			buf.append('\n');
			buf.append("request.getRequestURI()=");
			buf.append(request.getRequestURI());
			buf.append('\n');
			buf.append("request.getRequestURL()=");
			buf.append(request.getRequestURL());
			buf.append('\n');
			buf.append("request.getScheme()=");
			buf.append(request.getScheme());
			buf.append('\n');
			buf.append("request.getServerName()=");
			buf.append(request.getServerName());
			buf.append('\n');
			buf.append("request.getServerPort()=");
			buf.append(request.getServerPort());
			buf.append('\n');
			buf.append("request.getServletPath()=");
			buf.append(request.getServletPath());
			buf.append('\n');
			//buf.append("request.getLocalAddr()=");
			//buf.append(request.getLocalAddr());
			//buf.append('\n');
			//buf.append("request.getLocalName()=");
			//buf.append(request.getLocalName());
			//buf.append('\n');
			//buf.append("request.getLocalPort()=");
			//buf.append(request.getLocalPort());
			//buf.append('\n');
			buf.append("request.isSecure()=");
			buf.append(request.isSecure());
			buf.append('\n');

			buf.append("UrlUtil.getGlobalDirectory()=");
			buf.append(UrlUtil.getGlobalDirectory(request));
			buf.append('\n');
			buf.append("UrlUtil.getGlobalPath()=");
			buf.append(UrlUtil.getGlobalPath(request));
			buf.append('\n');
			buf.append("UrlUtil.getGlobalUrl()=");
			buf.append(UrlUtil.getGlobalUrl(request));
			buf.append('\n');
			buf.append("UrlUtil.getLocalDirectory()=");
			buf.append(UrlUtil.getLocalDirectory(request));
			buf.append('\n');
			buf.append("UrlUtil.getLocalFile()=");
			buf.append(UrlUtil.getLocalFile(request));
			buf.append('\n');
			buf.append("UrlUtil.getLocalPath()=");
			buf.append(UrlUtil.getLocalPath(request));
			buf.append('\n');
			buf.append("UrlUtil.getLocalUrl()=");
			buf.append(UrlUtil.getLocalUrl(request));
			buf.append('\n');
			buf.append("UrlUtil.getQueryString()=");
			buf.append(UrlUtil.getQueryString(request));
			buf.append('\n');
			buf.append("UrlUtil.getServletDirectory()=");
			buf.append(UrlUtil.getServletDirectory(request));
			buf.append('\n');
			buf.append("UrlUtil.getServletPath()=");
			buf.append(UrlUtil.getServletPath(request));
			buf.append('\n');

			buf.append('\n');

			buf.append("PARAMETERS\n");
			buf.append("==========\n");
			enumeration = request.getParameterNames();
			if (enumeration == null || enumeration.hasMoreElements() == false)
			{
				buf.append("(none)\n");
			}
			else
			{
				while (enumeration.hasMoreElements())
				{
					String paramName = (String)enumeration.nextElement();
					String[] ArrParamValue = request.getParameterValues(paramName);
					for (String paramValue: ArrParamValue)
					{
						buf.append(paramName);
						buf.append('=');
						buf.append(paramValue);
						buf.append('\n');
					}
				}
			}
			buf.append('\n');

			buf.append("HEADERS\n");
			buf.append("=======\n");
			enumeration = request.getHeaderNames();
			if (enumeration == null || enumeration.hasMoreElements() == false)
			{
				buf.append("(none)\n");
			}
			else
			{
				while (enumeration.hasMoreElements())
				{
					String paramName = (String)enumeration.nextElement();
					buf.append(paramName);
					buf.append('=');
					buf.append(request.getHeader(paramName));
					buf.append('\n');
				}
			}
			buf.append('\n');

			buf.append("ATTRIBUTES\n");
			buf.append("==========\n");
			enumeration = request.getAttributeNames();
			if (enumeration == null || enumeration.hasMoreElements() == false)
			{
				buf.append("(none)\n");
			}
			else
			{
				ArrayList<String> attrList = new ArrayList<String>();

				while (enumeration.hasMoreElements())
				{
					attrList.add((String)enumeration.nextElement());
				}

				String[] attrArray = attrList.toArray(new String[ attrList.size() ]);
				Arrays.sort(attrArray);
				for (String attrName : attrArray)
				{
					buf.append(attrName);
					buf.append('=');
					buf.append(request.getAttribute(attrName).toString());
					buf.append(" (type=");
					buf.append(request.getAttribute(attrName).getClass().getName());
					buf.append(")\n");
				}
			}
			buf.append('\n');

			HttpSession session = request.getSession(false);
			buf.append("SESSION\n");
			buf.append("=======\n");
			if (session == null)
			{
				buf.append("(no session)\n");
			}
			else
			{
				buf.append("created on ");
				buf.append(new java.util.Date(session.getCreationTime()).toString());
				buf.append('\n');
				enumeration = session.getAttributeNames();
				if (enumeration == null || enumeration.hasMoreElements() == false)
				{
					buf.append("(none)\n");
				}
				else
				{
					while (enumeration.hasMoreElements())
					{
						String paramName = (String)enumeration.nextElement();
						buf.append(paramName);
						buf.append('=');
						Object attrValue = session.getAttribute(paramName);
						if (attrValue == null)
						{
							buf.append("(null)");
						}
						else
						{
							buf.append(attrValue.toString());
							buf.append(" (type=");
							buf.append(attrValue.getClass().getName());
							buf.append(")");
						}
						buf.append("\n");
					}
				}
			}
			buf.append('\n');
		}
		catch (Exception e)
		{
			//no logging, since that could be who is calling us
			Logger.getAnonymousLogger().log(Level.SEVERE, "HttpUtil.toString(request): " + e.getMessage(), e);
		}

		return buf.toString();
	}


}
