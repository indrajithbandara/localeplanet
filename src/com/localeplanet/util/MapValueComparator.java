package com.localeplanet.util;

import java.io.*;
import java.util.*;

public class MapValueComparator
	implements Comparator<String>
{
	Map<String, String> theMap;

	public MapValueComparator(Map<String, String> newMap)
	{
		theMap = newMap;
	}

	public int compare(String key1, String key2)
    {
        String value1 = theMap.get(key1);
		String value2 = theMap.get(key2);

        return(value1.compareToIgnoreCase(value2));
    }

	public boolean equals(Object o)
	{
		return false;
	}
}
