package com.localeplanet.common;

import java.io.*; 
import java.util.logging.*;
import javax.servlet.*; 
import javax.servlet.http.*; 

/**
 * insures that the caches are loaded
 */
public class WarmupServlet 
	extends HttpServlet 
{ 
    public void init() throws ServletException 
    { 
        log("INFO: Warmup init completed in " + loadCache() + "ms"); 
    } 
     
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        response.setContentType("text/plain");
        response.getWriter().print("Warmup get completed in " + loadCache() + "ms");
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	doGet(request, response);
    }
    
    private long loadCache()
    {
        long start = System.currentTimeMillis();
        
        CommonLocaleUtil.getCaches();
        
        return System.currentTimeMillis() - start;
	}
}