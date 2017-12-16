package com.localeplanet.i18n;

import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.localeplanet.java.*;

public class Localizer
{
	private static final String DEBUG_SUFFIX = "-intl";
	
    private static final ThreadLocal<Locale> threadLocale = new ThreadLocal<Locale>();
    private static final ThreadLocal<String> threadLocaleCode = new ThreadLocal<String>();
    
    /**
     * gets the current locale that is being used
     */
    static public Locale getLocale()
    {
        Locale loc = threadLocale.get();

        if (loc == null)
        {
            return Locale.US;
        }

        return loc;
    }

    /**
     * gets the current locale that is being used
     */
    static public String getLocaleCode()
    {
        String code = threadLocaleCode.get();

        if (code == null)
        {
            return Locale.US.toString();
        }

        return code;
    }

    static public String getLocaleCode(HttpServletRequest request)
    {
        if (request == null)
        {
            return Locale.US.toString();
        }
        
		String code = getNormalizedCode(request.getParameter("locale"));
		if (code != null)
		{
			return code;
		}

        Cookie[] ArrCookie = request.getCookies();
        if (ArrCookie != null)
        {
            for (Cookie theCookie : ArrCookie)
            {
                if ("locale".equals(theCookie.getName()))
                {
                    code = getNormalizedCode(theCookie.getValue());
                    if (code != null)
                    {
                        return code;
                    }
                }
            }
        }

        Locale loc = request.getLocale();
        if (loc != null)
        {
            code = getNormalizedCode(loc.toString());
        }

        return code == null ? Locale.US.toString() : code;
    }
    
    static private String getNormalizedCode(String code)
    {
    	if ("zz".equals(code))
    	{
    		return code;
    	}
    	return LocaleCache.getInstance().getNormalizedCode(code);
    }

    static public Locale setLocale(HttpServletRequest request)
    {
    	String code = getLocaleCode(request);
    	threadLocaleCode.set(code);
    	Locale loc = "zz".equals(code) ? Locale.US : LocaleCache.getInstance().getExact(code);
        threadLocale.set(loc);
        
        return loc;
    }
}
