<%@ page buffer="16kb"
		 contentType="text/html;charset=UTF-8"
		 errorPage="/_err/500.jsp"
		 import="java.text.*,
		 		 java.util.*,
		 		 com.ibm.icu.text.*,
		 		 com.ibm.icu.util.*,
		 		 com.localeplanet.common.*,
		 		 com.localeplanet.google.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.icu.*,
				 com.localeplanet.java.*,
		 		 com.localeplanet.ui.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

	String code = (String)request.getAttribute("urlparam");
	GenericLocale target = GoogleTranslateCache.getInstance().getGeneric(code);
	String name = target.getName(loc);

	String htmlTitle = h(java.text.MessageFormat.format(_("Google Translate Language \u201C{0}\u201D"), name));

	Set<String> translateSet = new TreeSet<String>();
	translateSet.addAll(UI.getInstance().getSlogans());

	translateSet.addAll(Arrays.asList(ArrMovieQuote));

	boolean showSample = "en".equals(code) == false;
	boolean showThird = "en".equals(code) == false && loc.getLanguage().equals(code) == false && loc.getLanguage().equals("en") == false;

%><!DOCTYPE html>
<html>
<head>
<title><%=htmlTitle%></title>
<% UI.getInstance().appendMeta(out, application, request); %>
<script src="https://www.google.com/jsapi?key=ABQIAAAA5sdMTLAemOuxdk93V7nsLhQKwbX3w_uxoSmSX43jeVa_9q_2oxRbjvEf7phi95dQ2N49J-ECOL-szw" type="text/javascript"></script>
<script type="text/javascript">
	var to_translate = [
<%

	for (String phrase : translateSet)
	{
		out.print("\t\t\"");
		out.print(phrase);
		out.println("\",");
	}
%>		"" ];

	function isTranslatable(locale)
	{
		if (google.language.isTranslatable(locale))
		{
			return "<%=_h("Yes")%>";
		}
		return "";
	}

	function translateHandler(phrase)
	{
		return function(result) {
			var row = document.createElement("tr");
			var col1 = document.createElement("td");
			col1.appendChild(document.createTextNode(phrase));
			row.appendChild(col1);

			var col2 = document.createElement("td");
			col2.appendChild(document.createTextNode(result.translation));
			row.appendChild(col2);

			document.getElementById("sample").appendChild(row);
		};
	}

	function translate()
	{
		for (var phraseLoop = 0; phraseLoop < to_translate.length; phraseLoop++)
		{
			text = to_translate[phraseLoop];

			google.language.translate( { text: text, type: 'text'}, 'en', '<%=code%>', translateHandler(text));
		}
	}

	google.load("language", "1");
    google.setOnLoadCallback(translate);

</script></head>
<body>
<% UI.getInstance().appendHeader(out, application, request); %>
<h1><%=htmlTitle%></h1>
<h2><%=_h("Basic Information")%></h2>
<table class="table table-bordered table-striped">
	<tr>
		<td><%=_h("Code")%></td>
		<td><%=h(code)%></td>
	</tr>
	<tr>
		<td><%=_h("Google Name")%></td>
		<td><%=h(name)%></td>
	</tr>
	<tr>
		<td><%=_h("Non-Google name")%></td>
		<td><%=h(CommonLocaleUtil.getName(code, loc))%></td>
	</tr>
	<tr>
		<td><%=_h("Translatable?")%></td>
		<td><script type="text/javascript">document.write(isTranslatable('<% HtmlEncoder.encode(out, code);%>'));</script></td>
	</tr>
	<tr>
		<td valign="top"><%=_h("Other data sources")%></td>
		<td><a href="/compare/<%=UrlUtil.encode(code)%>/index.html"><%=_h("compare")%></a></td>
	</tr>
</table>
<% if (showSample) { %>
<h2><%=_h("Sample Translations")%></h2>
<table class="table table-bordered table-striped" id="sample" width="100%">
	<tr>
		<th><%=_h("English")%></th>
		<th><%=h(name)%></th>
	</tr>
</table>
<% } %>
<% UI.getInstance().appendFooter(out, application, request); %>
</body>
</html><%!
	static private String[] ArrMovieQuote = {
		"Frankly, my dear, I don't give a damn.",
		"I'm going to make him an offer he can't refuse.",
		"You can't handle the truth.",
		"Show me the money.",
	};
%>