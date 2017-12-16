package com.localeplanet.common;

import java.util.*;
import com.ibm.icu.util.*;
import com.localeplanet.dotnet.*;
import com.localeplanet.icu.*;
import com.localeplanet.java.*;
import com.localeplanet.google.*;
import com.localeplanet.util.*;

public class LocaleNormalizer
{
	static public String normalize(Locale loc)
	{
		return normalize(loc.toString());
	}
	
	static public String normalize(ULocale loc)
	{
		return normalize(loc.toString());
	}
	
	static public String normalize(String code)
	{
		return code.replace('_', '-');
	}
}

