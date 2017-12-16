<%@ page buffer="16kb"
		 contentType="text/xml;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.io.*,
		 		 java.util.*,
				 java.util.regex.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*"
%><%

	List<String> urls = new ArrayList<String>();

	urls.add("/index.html");

	urls.add("/api/index.html");

	for (String url : getFiles(application, "/_api/"))
	{
		urls.add("/api/auto/" + url.substring(6, url.length()));
	}

	urls.add("/cldr/index.html");

	urls.addAll(getFiles(application, "/compare/"));

	urls.add("/dotnet/index.html");

	urls.add("/google-translate/index.html");

	for (String url : getFiles(application, "/icu/"))
	{
		urls.add(url);
	}

	for (ULocale target : ULocale.getAvailableLocales())
	{
		urls.add("/icu/" + UrlUtil.encode(LocaleNormalizer.normalize(target)) + "/index.html");
	}

	urls.add("/java/index.html");
	for (Locale target : Locale.getAvailableLocales())
	{
		urls.add("/java/" + UrlUtil.encode(LocaleNormalizer.normalize(target)) + "/index.html");
	}

	//urls.addAll(getFiles(application, "/standard/"));

	urls.addAll(getFiles(application, "/support/"));

	out.println("<?xml version='1.0' encoding='UTF-8'?>");
	if ("raw".equals(request.getParameter("mode")) == false)
	{
		out.println("<?xml-stylesheet type=\"text/xsl\" href=\"sitemap.xsl\"?>");
	}
	out.println("<urlset");
	out.println("\txmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
	out.println("\txsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9\"");
	out.println("\txmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");

	String[] ArrUrl = urls.toArray(new String[ urls.size() ]);
	Arrays.sort(ArrUrl);

	for (String url : ArrUrl)
	{
		out.print("\t<url>");
		out.print("<loc>http://www.localeplanet.com");
		out.print(url);
		out.print("</loc>");
		out.println("</url>");
	}
	out.println("</urlset>");
	out.print("<!-- count=");
	out.print(urls.size());
	out.println(" -->");
%><%!

	Pattern rewrite = Pattern.compile("([a-zA-Z0-9][-A-Za-z0-9_]*)_([a-z]+)\\.jsp");

	List<String> getFiles(ServletContext application, String targetPath)
	{
		Set paths = application.getResourcePaths(targetPath);

		ArrayList<String> results = new ArrayList<String>();

		for (Object objPath : paths)
		{
			String path = (String)objPath;

			String fileName = path.substring(targetPath.length(), path.length());

			Matcher m = rewrite.matcher(fileName);
			if (m.matches())
			{
				fileName = m.replaceAll("$1.$2");
			}

			if (fileName.endsWith(".html") == false &&
				fileName.endsWith(".pdf") == false &&
				fileName.endsWith(".svg") == false)
			{
				continue;
			}
			results.add(targetPath + fileName);
		}

		return results;
	}
%>
