<%@ page buffer="16kb"
		 contentType="text/plain;charset=utf-8"
		 import="java.io.*,
		 		 java.util.*,
		 		 javax.mail.*,
				 javax.mail.internet.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*"
%><%
	response.setHeader("X-Robots-Tag", "NOINDEX");

	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw, true);

	pw.println("500 Server Error");
	pw.println();

	pw.print(HttpUtil.toString(request));

	pw.print(HttpUtil.toString(response));

	Object jspException = request.getAttribute("javax.servlet.jsp.jspException");
	if (jspException != null)
	{
		pw.println();
		pw.println("JSP Exception");
		pw.println("=============");
		if (jspException instanceof Throwable)
		{
			pw.print(DebugUtil.toString((Throwable)jspException));
		}
		else
		{
			pw.print("class=");
			pw.print(jspException.getClass().getName());
			pw.println();
			pw.print("toString=");
			pw.print(jspException.toString());
			pw.println();
		}
	}

	Object servletException = request.getAttribute("javax.servlet.error.exception");
	if (servletException != null)
	{
		pw.println();
		pw.println("Servlet Exception");
		pw.println("=================");
		if (servletException instanceof Throwable)
		{
			pw.print(DebugUtil.toString((Throwable)servletException));
		}
		else
		{
			pw.print("class=");
			pw.print(servletException.getClass().getName());
			pw.println();
			pw.print("toString=");
			pw.print(servletException.toString());
			pw.println();
		}
	}

	out.print(sw.getBuffer());
	
	try
	{
		Properties props = new Properties();
		javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props, null);

		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress("fileformat@gmail.com"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress("fileformat@gmail.com"));
		msg.setSubject("500 Error on LocalePlanet.com");
		msg.setText(sw.getBuffer().toString());
		Transport.send(msg);
	}
	catch (Throwable e)
	{
		out.println();
		out.println("Unable to notify webmaster: " + e.getMessage());
	}
	
%>
