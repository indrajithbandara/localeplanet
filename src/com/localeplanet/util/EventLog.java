package com.localeplanet.util;

import java.io.*;
import java.sql.*;
import java.util.logging.*;
import javax.servlet.http.*;
import com.localeplanet.web.*;

public class EventLog
{
	static public Level ERROR = Level.SEVERE;
	
	private static final Logger logger = Logger.getAnonymousLogger();

	static private final String NULL = "(null)";

	static private final int MAX_MESSAGE = 250;

	java.util.logging.Level level;
	String location;
	String message;
	StringBuilder detail;
	int detailCount;

	public EventLog()
	{
		level = Level.SEVERE;
		location = message = null;
		detail = null;
	}

	public EventLog(java.util.logging.Level level, String location, Object... args)
	{
		this.level = level;
		this.location = location;

		if (args == null || args.length == 0)
		{
			return;
		}

		int start = 0;

		if (args[0] instanceof String)
		{
			message = (String)args[0];
			if (message.length() <= MAX_MESSAGE)
			{
				start++;
			}
			else
			{
				message = message.substring(0, MAX_MESSAGE);
			}
		}
		else if (args[0] instanceof Throwable)
		{
			message = ((Throwable)args[0]).getMessage();
			if (message != null && message.length() > MAX_MESSAGE)
			{
				message = message.substring(0, MAX_MESSAGE);
			}
		}

		if (args.length <= start)
		{
			return;
		}

		detail = new StringBuilder();

		for (int loop = start; loop < args.length; loop++)
		{
			if (loop > start)
			{
				detail.append("\n\n");
			}
			addDetail(args[loop]);
		}
	}

	private void addDetail(Object obj)
	{
		if (obj == null)
		{
			detail.append("(null pointer)");
		}
		else if (obj instanceof String)
		{
			detail.append((String)obj);
		}
		else if (obj instanceof Throwable)
		{
			detail.append(DebugUtil.toString((Throwable)obj));
			//detail.append((((Throwable)obj)).toString());
		}
		else if (obj instanceof HttpServletRequest)
		{
			detail.append(HttpUtil.toString((HttpServletRequest)obj));
			//detail.append((((HttpServletRequest)obj)).toString());
		}
		else if (obj instanceof HttpServletResponse)
		{
			detail.append(HttpUtil.toString((HttpServletResponse)obj));
			//detail.append((((HttpServletResponse)obj)).toString());
		}
		else
		{
			detail.append(obj.getClass().getName());
			detail.append(": ");
			detail.append(obj.toString());
		}
	}

	private boolean save()
	{
		boolean retVal = false;
		try
		{
			StringBuilder sb = new StringBuilder();
			sb.append(level.toString());
			sb.append(": ");
			sb.append(message != null ? message : NULL);
			sb.append("\n");

			sb.append("Date:");
			sb.append((new java.util.Date()).toString());
			sb.append("\n");
			sb.append("Location:");
			sb.append(location != null ? location : NULL);
			sb.append("\n");
			sb.append("Details");
			sb.append("\n");
			sb.append("=======");
			sb.append("\n");
			sb.append(detail != null ? detail.toString() : NULL);
			sb.append("\n");

			logger.log(level, sb.toString());

			retVal = true;
		}
		catch (Throwable t)
		{
			System.out.println("EventLog.save: " + t.getMessage());
		}
		return retVal;
	}

	static public void log(java.util.logging.Level level, String location, Object... args)
	{
		EventLog el = new EventLog(level, location, args);
		el.save();
	}
}
