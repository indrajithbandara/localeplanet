<%@ page buffer="16kb"
		 contentType="text/html;charset=utf-8"
		 import="java.util.*,
				 javax.mail.*,
				 javax.mail.internet.*,
				 net.tanesha.recaptcha.*,
				 com.localeplanet.web.*,
				 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
				 com.localeplanet.util.*,
				 static com.localeplanet.ui.Macro.*"
%><%
	String subject = request.getParameter("subject");
	if (subject == null || subject.length() == 0)
	{
		subject = request.getHeader("referer");
	}

	if (subject != null)
	{
		subject = UrlUtil.encode(subject);
		subject = subject.replaceAll("%2F%2F", "/");
		subject = subject.replaceAll("%2F", "/");
		subject = subject.replaceAll("%23", "|");
		subject = subject.replaceAll("%26", "|");
	}

%><!DOCTYPE html>
<html>
<head>
<% UI.getInstance().appendMeta(out, application, request); %>
<meta name="robots" content="noindex" />
<title>Contact</title>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<script type="text/javascript">var host = (("https:" == document.location.protocol) ? "https://secure." : "http://");document.write(unescape("%3Cscript src='" + host + "wufoo.com/scripts/embed/form.js' type='text/javascript'%3E%3C/script%3E"));</script>
<script type="text/javascript">
var z7x3k7 = new WufooForm();
z7x3k7.initialize({
'defaultValues':'field14=LocalePlanet&field16=<%=subject%>',
'userName':'fileformat',
'formHash':'z7x3k7',
'autoResize':true,
'height':'617',
'header':'show'});
z7x3k7.display();
</script>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html>
