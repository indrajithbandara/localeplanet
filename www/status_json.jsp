<%@ page buffer="16kb"
		 contentType="application/x-javascript;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.util.*,
				 org.json.simple.*"
%><%

	JSONObject retVal = new JSONObject();
	retVal.put("success", true);
	retVal.put("message", "OK");

	String json = retVal.toString();
	String callback = request.getParameter("callback");
	if (callback != null && callback.matches("[a-zA-Z][-a-zA-Z0-9_]*"))
	{
		out.print(callback);
		out.print("(");
		out.print(json);
		out.print(");");
	}
	else
	{
		out.print(json);
	}
%>
