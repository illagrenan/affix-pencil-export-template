<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:p="http://www.evolus.vn/Namespace/Pencil"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output
            method="html"
            doctype-system="about:legacy-compat"
            encoding="UTF-8"
            indent="yes"/>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <title>
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </title>

                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <link rel="stylesheet" type="text/css" href="Resources/style.css"/>
                <script type="text/javascript" src="Resources/lib.js"></script>
            </head>
            <body>
                <h1 id="documentTitle">
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </h1>
                <p id="documentMetadata">Exported at:
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='exportTime']/text()"/>
                </p>
                <xsl:apply-templates select="/p:Document/p:Pages/p:Page"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="p:Page">
        <div class="Page" id="{p:Properties/p:Property[@name='fid']/text()}_page">
            <h2>
                <xsl:value-of select="p:Properties/p:Property[@name='name']/text()"/>
            </h2>
            <div class="ImageContainer">
                <img src="pages/{p:Properties/p:Property[@name='fid']/text()}.png"
                     width="{p:Properties/p:Property[@name='width']/text()}"
                     height="{p:Properties/p:Property[@name='height']/text()}"
                     usemap="#map_{p:Properties/p:Property[@name='fid']/text()}"/>
            </div>
            <xsl:if test="p:Note">
                <p class="Notes">
                    <xsl:apply-templates select="p:Note/node()" mode="processing-notes"/>
                </p>
            </xsl:if>
            <map name="map_{p:Properties/p:Property[@name='fid']/text()}">
                <xsl:apply-templates select="p:Links/p:Link"/>
            </map>
        </div>
    </xsl:template>
    <xsl:template match="p:Link">
        <area shape="rect"
              coords="{@x},{@y},{@x+@w},{@y+@h}" href="#{@targetFid}_page" title="Go to page '{@targetName}'"/>
    </xsl:template>

    <xsl:template match="html:*" mode="processing-notes">
        <xsl:copy>
            <xsl:copy-of select="@*[local-name() != '_moz_dirty']"/>
            <xsl:apply-templates mode="processing-notes"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html:a[@page-fid]" mode="processing-notes">
        <a href="#{@page-fid}_page" title="Go tp page '{@page-name}'">
            <xsl:copy-of select="@class|@style"/>
            <xsl:apply-templates mode="processing-notes"/>
        </a>
    </xsl:template>
</xsl:stylesheet>
