package com.localeplanet.i18n;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.localeplanet.java.*;
import com.localeplanet.util.*;

public class Translation
{
    private static final Map<String, Properties> propCache = new HashMap<String, Properties>();

    static
    {
        try
        {
        	List<String> codes = new ArrayList<String>();
        	codes.addAll(Arrays.asList(LocaleCache.getInstance().getCodes()));
        	codes.add("zz");
            for (String code : codes)
            {
            	if (code.equals("hi-IN"))
            	{
            		code = "hi";
            	}
            	
                InputStream in = Localizer.class.getResourceAsStream("text/" + code + ".properties");
                if (in == null)
                {
                    continue;
                }

                Properties props = new Properties();
                props.load(in);
                in.close();
                
                propCache.put(code, props);
            }
        }
        catch (Exception e)
        {
            EventLog.log(EventLog.ERROR, "Localizer.init", e);
        }
    }
    
    static public String getTranslation(String lang, String text)
    {
    	Properties props = propCache.get(lang);
    	if (props == null)
    	{
    		return text;
    	}
    	
    	String translation = props.getProperty(text);
    	if (translation == null)
    	{
    		return text;
    	}
    	
    	return translation;
    }
    
    static public String[] getLanguages()
    {
    	return propCache.keySet().toArray(new String[ propCache.size() ]);
    }
}