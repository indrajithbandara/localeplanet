package com.localeplanet.ui;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.localeplanet.i18n.*;
import static com.localeplanet.ui.Macro.*;
import com.localeplanet.web.*;


/**
 * the common page UI across all JSP's and Servlets.
 *
 */
public class UI
{
	static private UI INSTANCE = new UI();


	public void appendAd(Appendable out, ServletContext application, HttpServletRequest request)
		throws IOException
	{
		out.append("<div style=\"text-align:center;margin-top:15px;margin-left:auto;margin-right:auto;width:728px;\"><script type=\"text/javascript\"><!--\n");
		out.append("google_ad_client = \"pub-6975096118196151\";\n");
		out.append("google_ad_slot = \"2721131656\";\n");
		out.append("google_ad_width = 728;\n");
		out.append("google_ad_height = 90;\n");
		out.append("//--></script>\n");
		out.append("<script type=\"text/javascript\"\n");
		out.append("src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\">\n");
		out.append("</script></div>\n");
	}

	public void appendFooter(Appendable out, ServletContext application, HttpServletRequest request)
		throws IOException
	{
		appendAd(out, application, request);

		out.append("\t</div>\n");

		out.append("<footer>\n");

		out.append("	<p>\n");
		out.append("	<a href=\"/support/contact.html\">Feedback</a> |\n");
		out.append("	Validate: <a href=\"http://validator.w3.org/check?uri=referer\">HTML5</a> |\n");
		out.append("	<a href=\"http://jigsaw.w3.org/css-validator/check/referer\">CSS</a>\n");
		out.append("</p>\n");

		out.append("</footer>\n");
		out.append("</div>\n");

		/*
		out.append("\t</div>\n");
		out.append("</div>\n");

		//<!-- content-wrap ends here -->
		out.append("</div>\n");

		//<!--footer starts here-->
		out.append("<div id=\"footer\">\n");

		out.append("	<p>\n");
		out.append("	<a href=\"/support/contact.html\">Feedback</a> |\n");
		out.append("	Validate: <a href=\"http://validator.w3.org/check?uri=referer\">HTML5</a> |\n");
		out.append("	<a href=\"http://jigsaw.w3.org/css-validator/check/referer\">CSS</a>\n");
		out.append("</p>\n");

		out.append("</div>	\n");

		//<!-- wrap ends here -->
		out.append("</div>\n");
		*/

		appendTracker(out, request);
	}

	static private final String[] ArrSlogan = {
		_x("Hello world!"),
		_x("Toto, I've a feeling we're not in Kansas anymore"),
		_x("E.T. phone home"),
		_x("There's no place like home"),
		_x("What we've got here is failure to communicate"),
		_x("Houston, we have a problem"),
		_x("Keep off the grass"),
		_x("All your base are belong to us"),
		_x("In dreams you can see yourself without using mirrors"),
		_x("Please may I have some lemons?"),
		_x("Help me!"),
		_x("No, you're not coming!"),
		_x("Talk is cheap. Show me the code."),
	};

	public List<String> getSlogans()
	{
		return Arrays.asList(ArrSlogan);
	}

	public void appendHeader(Appendable out, ServletContext application, HttpServletRequest request)
		throws IOException
	{
		String current = UrlUtil.getLocalUrl(request);

		out.append("<div class=\"navbar navbar-fixed-top navbar-inverse\" data-dropdown=\"dropdown\">\n");
		out.append("\t<div class=\"navbar-inner\">\n");
		out.append("\t\t<div class=\"container\">\n");
		out.append("\t\t\t<a class=\"btn btn-navbar\" data-toggle=\"collapse\" data-target=\".nav-collapse\"><span class=\"icon-bar\"></span><span class=\"icon-bar\"></span><span class=\"icon-bar\"></span></a>\n");
		out.append("\t\t\t<a class=\"brand\" href=\"/index.html\"><i class=\"icon-globe\"></i> LocalePlanet</a>\n");

		out.append("\t\t\t<ul class=\"nav\">\n");
		out.append("\t\t\t\t<li>");
		out.append("<a href=\"/index.html\">");
		out.append(_h(ArrSlogan[ new Random(System.currentTimeMillis()).nextInt(ArrSlogan.length)]));
		out.append("</a>");
		out.append("</li>\n");
		out.append("\t\t\t</ul>\n");

		out.append("\t\t\t<div class=\"nav-collapse\">\n");
		out.append("\t\t\t<ul class=\"nav pull-right\">\n");
		addMenuLink(out, "/index.html", _("Home"), current.equals("/") || current.equals("index.html"));
		addMenuLink(out, "/api/index.html", _("API"), current.startsWith("/api/"));
		addMenuLink(out, "/data-sources.html", _("Data"), current.equals("/data-sources.html"));
		addMenuLink(out, "/support/index.html", _("Support"), current.startsWith("/support"));

		out.append("\t\t\t<li>");
		out.append("<a class=\"language\" href=\"/support/change-language.html?next=");
		out.append(UrlUtil.encode(UrlUtil.getLocalUrl(request)));
		out.append("\">");
		//out.append(h(Localizer.getLocale().getDisplayLanguage(Localizer.getLocale())));
		//out.append("\u00A0");
		out.append("<img src=\"/images/language.png\" alt=\"");
		out.append(_h("Change language"));
		out.append("\" title=\"");
		out.append(_h("Change language"));
		out.append("\" />");
		out.append("</a>");
		out.append("</li>\n");


		out.append("\t\t\t</ul>");
		out.append("\t\t\t</div>");
		out.append("\t\t</div>\n");
		out.append("\t</div>\n");
		out.append("</div>\n");

		out.append("<div class=\"container\">\n");
		out.append("\t<div class=\"maincontent\">\n");

		/*
		out.append("<div id=\"wrap\">\n");

		//header
		out.append("<div id=\"header\">\n");
		out.append("\t<div id=\"logo-wrapper\">\n");
		out.append("\t\t<h1 id=\"lp-logo-text\"><a href=\"/index.html\">Locale<span class=\"gray\">Planet</span></a></h1>\n");
		out.append("\t\t<h2 id=\"lp-slogan\">");
		out.append(_h(ArrSlogan[ new Random(System.currentTimeMillis()).nextInt(ArrSlogan.length)]));
		out.append("</h2>\n");

		out.append("\t</div>\n");
		out.append("<p class=\"language\">");
		out.append("<a class=\"language\" href=\"/support/change-language.html?next=");
		out.append(UrlUtil.encode(UrlUtil.getLocalUrl(request)));
		out.append("\">");
		out.append(h(Localizer.getLocale().getDisplayLanguage(Localizer.getLocale())));
		out.append("\u00A0");
		out.append("<img style=\"border:0;margin-top:6px;\" src=\"/style/language.png\" alt=\"");
		out.append(_h("Change language"));
		out.append("\" title=\"");
		out.append(_h("Change language"));
		out.append("\" />");
		out.append("</a>");
		out.append("</p>");
		out.append("</div>\n");

		//menu
		out.append("<div  id=\"menu\">\n");
		out.append("\t<ul>\n");

		out.append("\t\t<li");
		if (current.equals("/") || current.equals("/index.html")) { out.append(" id=\"current\""); }
		out.append("><a href=\"/index.html\">");
		out.append(_h("Home"));
		out.append("</a></li>\n");

		out.append("\t\t<li");
		if (current.startsWith("/api/")) { out.append(" id=\"current\""); }
		out.append("><a href=\"/api/index.html\">");
		out.append(_h("API"));
		out.append("</a></li>\n");

		out.append("\t\t<li");
		if (current.startsWith("/data-sources.html")) { out.append(" id=\"current\""); }
		out.append("><a href=\"/data-sources.html\">");
		out.append(_h("Data"));
		out.append("</a></li>\n");

		out.append("\t\t<li");
		if (current.startsWith("/support/")) { out.append(" id=\"current\""); }
		out.append("><a href=\"/support/index.html\">");
		out.append(_h("Support"));
		out.append("</a></li>\n");

		out.append("\t</ul>\n");
		out.append("</div>	\n");

		//content-wrap
		out.append("<div id=\"content-wrap\">\n");
		out.append("<div id=\"main\">\n");
		out.append("\t<div id=\"maincontent\">\n");

		//NO: too annoying appendAd(out, application, request);
		*/
	}

	private void addMenuLink(Appendable out, String url, String text, boolean current)
		throws java.io.IOException
	{
		out.append("\t\t\t\t<li");
		if (current)
		{
			out.append(" class=\"active\"");
		}
		out.append("><a href=\"");
		out.append(url);
		out.append("\"");
		out.append(">");
		out.append(h(text));
		out.append("</a></li>\n");
	}

	public void appendMeta(Appendable out, ServletContext application, HttpServletRequest request)
		throws IOException
	{
		out.append("<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\" />\n");
		out.append("<meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\" />\n");
		out.append("<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/favicon.ico\" />\n");
		out.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/bootstrap.min.css\" />\n");
		out.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/font-awesome.css\" />\n");
		out.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/override.css\" />\n");

		out.append("<script src=\"/js/jquery-1.8.2.min.js\"></script>\n");
		//out.append("<script src=\"/js/google-code-prettify/prettify.js\"></script>\n");
		out.append("<script src=\"/js/bootstrap.min.js\"></script>\n");

		out.append("<script type=\"text/javascript\">\n");

		out.append("var _gaq = _gaq || [];\n");
		out.append("_gaq.push(['_setAccount', 'UA-328425-6']);\n");
		out.append("_gaq.push(['_trackPageview']);\n");

		out.append("(function() {\n");
		out.append("var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;\n");
		out.append("ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';\n");
		out.append("var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);\n");
		out.append("})();\n");

		out.append("</script>\n");

		/*
		out.append("<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\" />\n");
		out.append("<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/favicon.ico\"/>\n");
		out.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/style/screen.css\" />");
		*/
	}

	public void appendTracker(Appendable out, HttpServletRequest request)
		throws IOException
	{
		out.append("<script type=\"text/javascript\">\n");
		out.append("var _gaq = _gaq || [];\n");

		out.append("_gaq.push(['_setAccount', '");
		out.append("www.localeplanet.com".equalsIgnoreCase(request.getServerName()) ? "UA-328425-15" : "UA-328425-17");
		out.append("']);\n");

		out.append("_gaq.push(['_setCustomVar', 1, 'locale', '");
		out.append(Localizer.getLocaleCode());
		out.append("', 3 ]);\n");

		out.append("_gaq.push(['_trackPageview']);\n");

		out.append("(function() {\n");
		out.append("var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;\n");
		out.append("ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';\n");
		out.append("(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);\n");
		out.append(" })();\n");

		out.append("</script>\n");
	}

	static public UI getInstance()
	{
		return INSTANCE;
	}
}