<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.web.*"
%><%@ include file="../_api/param.inc" %><%

	String param = request.getParameter("pat");

	Locale jloc = uloc.toLocale();

	String pattern = null;

	if (param == null)
	{
		pattern = DatePatternUtil.getPattern("SHORT_PADDED_CENTURY", jloc);
	}
	else if (DatePatternUtil.codeToJava(param).matches("((SHORT)|(MEDIUM)|(LONG)|(FULL))(_[A-Z]+)*"))
	{
		pattern = DatePatternUtil.getPattern(param, jloc);
	}
	else
	{
		pattern = param;
	}

	String json = makeFunction(pattern);

%><%@ include file="../_api/jsonp.inc" %><%!


	static Map<String, String> funcMap;

	static
	{
		funcMap = new HashMap<String, String>();

		funcMap.put("y", "d.getFullYear()");
		funcMap.put("yy", "(d.getFullYear()+'').substring(2)");
		funcMap.put("yyyy", "d.getFullYear()");
		funcMap.put("M", "(d.getMonth()+1)");
		funcMap.put("MM", "((d.getMonth()+101)+'').substring(1)");
		funcMap.put("MMM", "dfs.month_short[d.getMonth()]");
		funcMap.put("MMMM", "dfs.month_name[d.getMonth()]");
		funcMap.put("d", "d.getDate()");
		funcMap.put("dd", "((d.getDate()+101)+'').substring(1)");
		funcMap.put("E", "(d.getDay()+1)");
		funcMap.put("EE", "((d.getDay()+101)+'').substring(1)");
		funcMap.put("EEE", "dfs.day_short[d.getDay()]");
		funcMap.put("EEEE", "dfs.day_name[d.getDay()]");
		funcMap.put("a", "dfs.am_pm[0|(d.getHours()/12)]");
		funcMap.put("H", "d.getHours()");
		funcMap.put("HH", "((d.getHours()+100)+'').substring(1)");
		funcMap.put("k", "(((d.getHours()+23)%24)+1)");
		funcMap.put("kk","((((d.getHours()+23)%24)+101)+'').substring(1)");
		funcMap.put("K", "(d.getHours()%12)");
		funcMap.put("KK", "(((d.getHours()%12)+100)+'').substring(1)");
		funcMap.put("h", "((((d.getHours()+11)%12)+101)+'').substring(1)");
		funcMap.put("hh", "(((d.getHours()+11)%12)+1)");
		funcMap.put("m", "d.getMinutes()");
		funcMap.put("mm", "((d.getMinutes()+100)+'').substring(1)");
		funcMap.put("s", "d.getSeconds()");
		funcMap.put("ss", "((d.getSeconds()+100)+'').substring(1)");
		funcMap.put("S", "d.getMilliseconds()");
		funcMap.put("SSS", "((d.getMilliseconds()+1000)+'').substring(1)");
		funcMap.put("z", "");	//LATER:  not supported: z 	Time zone 	General time zone 	Pacific Standard Time; PST; GMT-08:00
		funcMap.put("Z", "");	//LATER:  not supported: Z	RFC 822 time zone
		funcMap.put("F", "");	//LATER:  not supported: F 	Day of week in month 	Number 	2
		funcMap.put("w", "");	//LATER:  not supported: w 	Week in year 	Number 	27
		funcMap.put("W", "");	//LATER:  not supported: W 	Week in month 	Number 	2
		funcMap.put("D", "");	//LATER:  not supported: D 	Day in year 	Number 	189
		funcMap.put("G", "");	//LATER:  not supported: G  Era designator 	Text 	AD
	}

	public String makeFunction(String pattern)
		throws Exception
	{
		StringBuilder sb = new StringBuilder();

		int offset = 0;
		while (offset < pattern.length())
		{
			if (sb.length() != 0)
			{
				sb.append('+');
			}
			char ch = pattern.charAt(offset);
			if (ch == '\'')
			{
				if (pattern.charAt(offset+1) == '\'')
				{
					sb.append("\"'\"");
					offset++;
					continue;
				}
				int quotePos = pattern.indexOf('\'', offset+1);
				if (quotePos == -1)
				{
					throw new Exception("Unclosed quote (opened at offset " + offset + " in pattern \"" + pattern + "\"");
				}
				sb.append("'");
				sb.append(pattern.substring(offset+1, quotePos));
				sb.append("'");
				offset = quotePos + 1;
			}
			else if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))
			{
				char fieldChar = ch;
				int start = offset;
				while (++offset < pattern.length() && pattern.charAt(offset) == fieldChar)
				{
					// do nothing;
				}
				String field = pattern.substring(start, offset);
				String code = funcMap.get(field);
				if (code == null)
				{
					throw new Exception("Unknown field \"" + field + "\" at offset " + start + " in pattern \"" + pattern + "\"");
				}
				sb.append(code);
			}
			else
			{
				sb.append('\'');
				sb.append(ch);
				sb.append('\'');
				offset++;
			}
		}

		sb.insert(0, "function(d){if(d){return(");
		sb.append(");}}");

		return sb.toString();
	}
%>
