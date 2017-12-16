package com.localeplanet.util;

import java.util.*;
import java.util.concurrent.*;

public class CounterMap<T>
{
	class Counter
	{
		int count = 0;
	}
	
	private ConcurrentHashMap<T, Counter> theMap = new ConcurrentHashMap<T, Counter>();
	
	public int increment(T theObj)
	{
		Counter c = theMap.get(theObj);
		if (c == null)		
		{
			theMap.putIfAbsent(theObj, new Counter());
			c = theMap.get(theObj);
		}
		
		return c.count++;
	}
	
	public int get(T theObj)
	{
		Counter c = theMap.get(theObj);
		if (c == null)
		{
			return 0;
		}
		
		return c.count;
	}
	
	public Set<T> keySet()
	{
		return theMap.keySet();
	}
}