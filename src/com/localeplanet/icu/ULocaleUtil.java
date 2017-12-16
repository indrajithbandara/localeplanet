package com.localeplanet.icu;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.web.*;


public class ULocaleUtil
{
	private ULocaleUtil()
	{
		// all static methods
	}

	/**
	 * returns localized name & hyperlink for a ULocale
	 */
	static public String getHtml(ULocale loc, ULocale target)
	{
		StringBuilder sb = new StringBuilder();
		
		sb.append(target.getDisplayName(loc));
		sb.append(" (<a href=\"/locale/");
		sb.append(UrlUtil.encode(target.toString()));
		sb.append("/index.html\">");
		sb.append(HtmlEncoder.encode(target.toString()));
		sb.append("</a>)");
		
		return sb.toString();
	}
}
