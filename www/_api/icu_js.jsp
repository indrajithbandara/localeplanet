<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.ibm.icu.util.*,
				 org.json.simple.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.icu.*,
		 		 com.localeplanet.java.*,
		 		 com.localeplanet.web.*"
%><%@ include file="../_api/param.inc" %><%

	String objName = request.getParameter("object");
	if (objName == null || objName.matches("[_a-zA-z$][a-zA-Z.-_]*") == false)
	{
		objName = "window.icu";
	}
		
%>(function() {

	var dfs = <% pageContext.include("dfs_json.jsp"); %>;
	var nfs = <% pageContext.include("nfs_json.jsp"); %>;
	var df = {<%
		
		Set<String> dfList = new LinkedHashSet<String>();
		dfList.addAll(Arrays.asList(DatePatternUtil.getDefaultCodes()));
		
		String customDF = request.getParameter("datepat");
		if (customDF != null)
		{
			String[] ArrCustomDF = customDF.split("\\,");
			for (String code : ArrCustomDF)
			{
				dfList.add(DatePatternUtil.codeToJava(code));
			}
		}
			
		String[] ArrDateFormat = dfList.toArray(new String[ dfList.size() ]);
		for (int loop = 0; loop < ArrDateFormat.length; loop++)
		{
			String dateFormat = ArrDateFormat[loop];
			if (loop > 0)
			{
				out.print(",");
			}
			out.print(dateFormat + ":");
			pageContext.include("df_js.jsp?pat=" + dateFormat);
		}
	%>};
	
	<%=objName%> = <%=objName%> || new Object();
	var icu = <%=objName%>;	
		
	icu.getCountry = function() { return "<%=uloc.getCountry()%>" };
	icu.getCountryName = function() { return "<%=uloc.getDisplayCountry(uloc)%>" };
	icu.getDateFormat = function(formatCode) { var retVal = {}; retVal.format = df[formatCode]; return retVal; };
	icu.getDateFormats = function() { return df; };
	icu.getDateFormatSymbols = function() { return dfs; };
	icu.getDecimalFormat = function(places) { var retVal = {}; retVal.format = function(n) { var ns = n < 0 ? Math.abs(n).toFixed(places) : n.toFixed(places); var ns2 = ns.split('.'); s = ns2[0]; var d = ns2[1]; var rgx = /(\d+)(\d{3})/;while(rgx.test(s)){s = s.replace(rgx, '$1' + nfs["grouping_separator"] + '$2');} return (n < 0 ? nfs["minus"] : "") + s + nfs["decimal_separator"] + d;}; return retVal; };
	icu.getDecimalFormatSymbols = function() { return nfs; };
	icu.getIntegerFormat = function() { var retVal = {}; retVal.format = function(i) { var s = i < 0 ? Math.abs(i).toString() : i.toString(); var rgx = /(\d+)(\d{3})/;while(rgx.test(s)){s = s.replace(rgx, '$1' + nfs["grouping_separator"] + '$2');} return i < 0 ? nfs["minus"] + s : s;}; return retVal; };
	icu.getLanguage = function() { return "<%=uloc.getLanguage()%>" };
	icu.getLanguageName = function() { return "<%=uloc.getDisplayLanguage(uloc)%>" };
	icu.getLocale = function() { return "<%=ULocaleCache.getInstance().getNormalizedCode(uloc.toString())%>" };
	icu.getLocaleName = function() { return "<%=uloc.getDisplayName(uloc) /* LATER: this is not safe */ %>" };

})();