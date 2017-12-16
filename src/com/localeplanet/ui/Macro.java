package com.localeplanet.ui;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.localeplanet.i18n.*;
import com.localeplanet.web.*;

public class Macro
{
	private Macro()
	{
		// all members are static
	}
	
	static public String _(String original)
	{
		return Translation.getTranslation(Localizer.getLocaleCode().substring(0, 2), original);
	}
	
	static public String _h(String original)
	{
		return h(_(original));
	}
	
	static public String h(String original)
	{
		return HtmlEncoder.encode(original);
	}
	
	static public String t(String original, Locale loc)
	{
		return original;
	}
	
	/**
	 * marks a string for translation, but doesn't actually do the translation. It will be done on a variable farther up the stack.
	 */
	static public String _x(String original)
	{
		return original;
	}
}
