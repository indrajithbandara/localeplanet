<%@ page buffer="16kb"
		 contentType="text/xml;charset=utf-8"
		 errorPage="/_err/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
				 java.util.regex.*,
		 		 com.localeplanet.i18n.*,
				 com.localeplanet.ui.*,
		 		 com.localeplanet.util.*,
		 		 com.localeplanet.web.*,
				 static com.localeplanet.ui.Macro.*"
%><%

	Locale loc = Localizer.getLocale();

%><xsl:stylesheet version="2.0" xmlns:html="http://www.w3.org/TR/REC-html40"
xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title><%=_h("LocalePlanet Sitemap")%></title>
		<% UI.getInstance().appendMeta(out, application, request); %>
</head>

      <body>
		<% UI.getInstance().appendHeader(out, application, request); %>
	<h1><%=_h("LocalePlanet Sitemap")%></h1>
	<div id="intro">
	<p><%=MessageFormat.format(_h("This sitemap is meant for robots, not humans, but feel free to browse anyway! Or try the {0}raw XML view{1}."), "<a href=\"sitemap.xml?mode=raw\" rel=\"nofollow\">", "</a>")%></p>
        </div>

        <div id="content">
            <table class="table table-bordered table-striped">
                <tr style="border-bottom:1px black solid;">
                    <th style="text-align:left"><%=_h("URL")%></th>
		</tr>

	     <xsl:for-each select="sitemap:urlset/sitemap:url">

                    <tr>
                        <td>
                            <xsl:variable name="itemURL">
                            <xsl:value-of select="substring(sitemap:loc, 28)"/>
                            </xsl:variable>
                            <a href="{$itemURL}">
                                    <xsl:value-of select="substring(sitemap:loc, 28)"/>
                            </a>
                        </td>
                    </tr>

                </xsl:for-each>
            </table>
        </div>

		<% UI.getInstance().appendFooter(out, application, request); %>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

