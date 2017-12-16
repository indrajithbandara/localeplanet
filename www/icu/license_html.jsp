<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="com.localeplanet.web.*,
		 		 com.localeplanet.ui.*"
%><!DOCTYPE html>
<html>
<head>
<title>ICU License Information</title>
<% UI.getInstance().appendMeta(out, application, request); %>
</head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1>ICU License Information</h1>

<p>Copyright (c) 1995-2009 International Business Machines Corporation and others. All rights reserved.</p>

<p>Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
provided that the above copyright notice(s) and this permission notice appear in
all copies of the Software and that both the above copyright notice(s) and this
permission notice appear in supporting documentation.</p>

<% UI.getInstance().appendFooter(out, application, request); %> 
</body>
</html>
