<%!
	static private Map<String, String> linkMap;
	
	static 
	{
		linkMap = new HashMap<String, String>();
		linkMap.put("Standards", "standards.html");
		linkMap.put("Data Sources", "data-sources.html");
		linkMap.put("Alternatives", "competitor.html");
		linkMap.put("Articles/Information", "links.html");
	}
	
%><p><%=_h("More links:")%> <%

	String current = UrlUtil.getLocalFile(request);
	
	boolean ifFirst = true;
	for (String title : linkMap.keySet())
	{
		if (current.equals(linkMap.get(current)))
		{
			continue;
		}
		if (ifFirst)
		{
			ifFirst = false;
		}
		else
		{
			out.print(" | ");
		}
		
		out.print("<a href=\"");
		out.print(linkMap.get(title));
		out.print("\">");
		out.print(_h(title));		//LATER: i18n
		out.print("</a> ");
	}
%></p>