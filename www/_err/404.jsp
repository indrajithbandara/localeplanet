<%@ page buffer="16kb"
		 contentType="text/html;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.io.*,
		 		 java.util.*,
				 java.util.regex.*,
		 		 javax.mail.*,
				 javax.mail.internet.*,
				 au.com.bytecode.opencsv.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.util.*,
				 com.localeplanet.web.*"
%><%

	String localPath = UrlUtil.getLocalPath(request);
	
	RedirectMatch redir = findRedirectMatch(pageContext, localPath);
	if (redir != null)
	{
		if (redir.ifPermanent)
		{
			String absLocation = "http://www.localeplanet.com" + redir.location;
			
			//LATER: find a way to do permanent redirects here
			// doesn't work
			//response.reset();
			//response.setHeader( "Location", "http://www.labelmakr.com" + newPath );
			//response.setHeader( "Connection", "close" );
			//response.sendError(response.SC_MOVED_PERMANENTLY);
			
			// also doesn't work
			//response.setHeader( "Location", "http://www.labelmakr.com" + newPath );
			//response.sendError(response.SC_MOVED_PERMANENTLY);

			//response.setContentType("text/plain;charset=utf-8");
			//out.println("permanent redirect from " + localPath + " to " + redir.location);
			/*
			response.reset();
			response.setContentType("text/plain;charset=utf-8");
			response.setHeader("Location", absLocation);
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY, absLocation);
			PrintWriter pw = response.getWriter();
			pw.println("Permanent new location is " + absLocation);
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY, absLocation);
			pw.flush();
			pw.close();
			//response.flushBuffer();
			*/
			
			
			//response.setHeader("Location",absLocation);
			//response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
			//response.flushBuffer();
			//((org.mortbay.jetty.Response)response).complete();
			
			response.setHeader("X-Jetty-PITA", "Why won't jetty do a permanent redirect?");
			response.sendRedirect(absLocation);
			return;
		}
		else
		{
			response.sendRedirect(redir.location);
			return;
		}
	}
	
	if (request.getParameter("404reload") != null)
	{
		loadRules(pageContext);
		response.setContentType("text/plain;charset=utf-8");
		out.println(Integer.toString(rules.size()) + " rules reloaded");
		return;
	}
	
	response.setStatus(404);

%><!DOCTYPE html>
<html>
<head>
<title>404: Page Not Found</title>
<meta name="robots" content="noindex" />
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>404: Page Not Found</h1>
<p>The page you requested '<%=HtmlEncoder.encode(localPath)%>' could not be found.</p>
<%
	if (localPath.endsWith(".php") 
		|| localPath.endsWith(".asp") 
		|| localPath.endsWith(".aspx")
		|| "www.localeplanet.com".equalsIgnoreCase(request.getServerName()) == false
		)
	{
		// do not send email
	}
	else
	{
		String reqStr = HttpUtil.toString(request);
		//HtmlEncoder.encode(out, reqStr);
		
		try
		{
			Properties props = new Properties();
			javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props, null);
	
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress("fileformat@gmail.com"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress("fileformat@gmail.com"));
			msg.setSubject("404 error on LocalePlanet.com");
			msg.setText(reqStr);
			Transport.send(msg);
		}
		catch (Exception e)
		{
			out.print("<p>");
			out.print("Unable to notify webmaster: ");
			HtmlEncoder.encode(out, e.getMessage());
			out.println("</p>");
		}
	}	
%>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!

	class RedirectRule
	{
		Pattern thePattern;
		String mapping;
		boolean ifPermanent;
		
		public RedirectRule(String[] cols)
		{
			thePattern = Pattern.compile(cols[0]);
			mapping = cols[1];
			ifPermanent = cols.length >= 2 && "PERMANENT".equals(cols[2]);
		}
		
		
	}
	
	class RedirectMatch
	{
		String location;
		boolean ifPermanent;
	}
	
	public RedirectMatch findRedirectMatch(PageContext pageContext, String original)
	{
		if (rules == null)
		{
			loadRules(pageContext);
		}
		
		for (RedirectRule rule : rules)
		{
			Matcher m = rule.thePattern.matcher(original);
			
			if (m.matches() == false)
			{
				continue;
			}
			RedirectMatch result = new RedirectMatch();
			result.location = m.replaceAll(rule.mapping);
			result.ifPermanent = rule.ifPermanent;
			return result;
		}
		
		return null;
	}
	
	List<RedirectRule> rules = null;
	
	public void loadRules(PageContext pageContext)
	{
		List<RedirectRule> tmpRules = new ArrayList<RedirectRule>();
		try
		{
			InputStream in = pageContext.getServletContext().getResourceAsStream("/_err/404.csv");
			CSVReader reader = new CSVReader(new InputStreamReader(in, "UTF-8"));
			String[] cols;
			while ((cols = reader.readNext()) != null) 
			{
				if (cols.length < 2)
				{
					continue;
				}
				
				if (cols[0].length() == 0 || cols[0].charAt(0) == '#')
				{
					continue;
				}
				
				tmpRules.add(new RedirectRule(cols));
			}
			in.close();
		}
		catch (Exception e)
		{
			EventLog.log(EventLog.ERROR, "404.jsp", e);
		}
		rules = tmpRules;
	}
	
%>
