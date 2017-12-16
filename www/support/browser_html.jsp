<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 com.localeplanet.i18n.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%
	Locale jloc = request.getLocale();
%><!DOCTYPE html>
<html>
<head>
<title>Browser Locale Information</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>Your Browser Information</h1>
<h2>JavaScript Information</h2>
<pre><script type="text/javascript">
	var today = new Date();
	
	document.write("navigator.browserLanguage: ");
	document.write(navigator.browserLanguage);
	document.write("<br/>");
	document.write("navigator.language: ");
	document.write(navigator.language);
	document.write("<br/>");
	document.write("navigator.userAgent: ");
	document.write(navigator.userAgent);
	document.write("<br/>");
	document.write("date: ");
	document.write(today);
	document.write("<br/>");
	document.write("date.toLocaleDateString(): ");
	document.write(today.toLocaleDateString());
	document.write("<br/>");
	document.write("date.toLocaleTimeString(): ");
	document.write(today.toLocaleTimeString());
	document.write("<br/>");
	document.write("date.toLocaleString(): ");
	document.write(today.toLocaleString());
	document.write("<br/>");
	document.write("date.toUTCString(): ");
	document.write(today.toUTCString());
	document.write("<br/>");
	document.write("date.getTimezoneOffset(): ");
	document.write(today.getTimezoneOffset());
	document.write("<br/>");

</script></pre>
<h2>Java <code>request</code> Object</h2>
<p><a href="http://download.oracle.com/javaee/6/api/javax/servlet/ServletRequest.html#getLocale%28%29">request.getLocale()</a>:
<a href="/java/<%=h(jloc.toString())%>/index.html"><%=h(jloc.toString())%></a>.</p>

<p><a href="http://download.oracle.com/javaee/6/api/javax/servlet/ServletRequest.html#getLocales%28%29">request.getLocales()</a>:
<%

	boolean first = true;
	for (Enumeration e = request.getLocales() ; e.hasMoreElements() ;) 
	{
		Locale acceptLocale = (Locale)e.nextElement();
		
		if (first)
		{
			first = false;
		}
		else
		{
			out.print(", ");
		}
        out.print("<a href=\"/java/");
		out.print(UrlUtil.encode(acceptLocale.toString()));
		out.print("/index.html\">");
		out.print(h(acceptLocale.toString()));
		out.print("</a>"); 
	}
%>.</p>
<h2>Raw Headers</h2>
<p>Note: these are not that raw: they get cooked a bit by Google AppEngine, but probably not in ways that affect the locale information.</p>
<pre><%

    Enumeration enhdr = request.getHeaderNames();
	if (enhdr == null || enhdr.hasMoreElements() == false)
	{
		out.println("<i>(no headers)</i>");
	}
	else
    {
	    while (enhdr.hasMoreElements())
	    {
	        String key = (String)enhdr.nextElement();
			Enumeration valueEnum = request.getHeaders(key);
			while (valueEnum.hasMoreElements())
			{
				String value = (String)valueEnum.nextElement();
				
				HtmlEncoder.encode(out, key);
				out.print(": ");
				HtmlEncoder.encode(out, value);
				out.println();
			}
	    }
    }

%></pre>
<h2>LocalePlanet Settings</h2>
<p>Locale: <%=h(Localizer.getLocale().toString())%></p>
<p>Locale code: <%=h(Localizer.getLocaleCode())%></p>
<p>Cookie: <%
		String cookieLocale = null;
		
        Cookie[] ArrCookie = request.getCookies();
        if (ArrCookie != null)
        {
            for (Cookie theCookie : ArrCookie)
            {
                if ("locale".equals(theCookie.getName()))
                {
                    cookieLocale = theCookie.getValue();
                }
            }
        }
        out.print(h(cookieLocale == null ? _("(not set)") : cookieLocale));
%></p>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
