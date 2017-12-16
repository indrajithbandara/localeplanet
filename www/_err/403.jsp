<%@ page buffer="16kb"
		 contentType="text/html;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
		 		 javax.mail.*,
				 javax.mail.internet.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.web.*"
%><%

	response.setStatus(403);

%><!DOCTYPE html>
<html>
<head>
<title>403: Forbidden</title>
<meta name="robots" content="noindex" />
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>403: Forbidden</h1>
<p>You are not allowed to see the page you requested '<%=HtmlEncoder.encode(UrlUtil.getLocalPath(request))%>'.</p>
<%
	String reqStr = HttpUtil.toString(request);
	//HtmlEncoder.encode(out, reqStr);
	
	try
	{
		Properties props = new Properties();
		javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props, null);

		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress("sysadmin@localeplanet.com"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress("fileformat@gmail.com"));
		msg.setSubject("403: " + UrlUtil.getGlobalPath(request));
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
	
%>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
