package com.localeplanet.web;

import java.io.*;

public class FormUtil
{
	static public void writeChecked(Appendable out, boolean ifChecked)
		throws IOException
	{
		if (ifChecked)
		{
			out.append(" checked=\"checked\" ");
		}
	}
	
	static public void writeChecked(Appendable out, String s1, String s2)
		throws IOException
	{
		s1 = s1 == null ? "" : s1;
		s2 = s2 == null ? "" : s2;
		
		writeChecked(out, s1.equals(s2));
	}
}
