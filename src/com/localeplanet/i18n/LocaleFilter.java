package com.localeplanet.i18n;

import java.io.*;
import java.util.*;
import java.util.concurrent.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.google.appengine.api.memcache.*;
import com.localeplanet.util.*;

public class LocaleFilter
    implements Filter
{
    ServletContext application;

    public void init(FilterConfig filterConfig)
    {
        this.application = filterConfig.getServletContext();
    }

    public void destroy()
    {
        this.application = null;
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException
    {
        try
        {
			Locale loc = Localizer.setLocale((HttpServletRequest)request);

            chain.doFilter(request, response);
        }
        finally
        {
			Localizer.setLocale(null);
        }
    }
}