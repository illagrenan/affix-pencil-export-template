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
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
                <title>
                    <xsl:value-of select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                </title>
                <meta name="description" content=""/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <meta name="robots" content="noindex,nofollow,noarchive"/>
                <meta name="googlebot" content="noodp,nosnippet,noarchive,noindex,nofollow"/>

                <!--type='text/css'>-->
                <link rel="stylesheet" href="static/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="static/css/bootstrap-theme.min.css"/>
                <!--<link rel="stylesheet" href="css/main.css">-->
                <link rel="stylesheet" href="static/css/main.css"/>

                <!--[if lt IE 9]>
                <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
                <script>window.html5 || document.write('<script src="static/js/html5shiv.js"><\/script>')</script>
                <![endif]-->

                <link rel="apple-touch-icon" sizes="57x57" href="static/icons/apple-touch-icon-57x57.png"/>
                <link rel="apple-touch-icon" sizes="114x114" href="static/icons/apple-touch-icon-114x114.png"/>
                <link rel="apple-touch-icon" sizes="72x72" href="static/icons/apple-touch-icon-72x72.png"/>
                <link rel="apple-touch-icon" sizes="60x60" href="static/icons/apple-touch-icon-60x60.png"/>
                <link rel="apple-touch-icon" sizes="120x120" href="static/icons/apple-touch-icon-120x120.png"/>
                <link rel="apple-touch-icon" sizes="76x76" href="static/icons/apple-touch-icon-76x76.png"/>
                <link rel="shortcut icon" href="static/icons/favicon.ico"/>
                <link rel="icon" type="image/png" href="static/icons/favicon-96x96.png" sizes="96x96"/>
                <link rel="icon" type="image/png" href="static/icons/favicon-16x16.png" sizes="16x16"/>
                <link rel="icon" type="image/png" href="static/icons/favicon-32x32.png" sizes="32x32"/>
                <meta name="msapplication-TileColor" content="#da532c"/>
                <meta name="msapplication-config" content="static/icons/browserconfig.xml"/>
            </head>


            <body data-spy="scroll" data-target="#affix-nav">
                <div id="navbar" class="hidden-sm hidden-xs">
                    <div id="affix-nav">
                        <ul class="nav nav-pills nav-stacked" data-spy="affix" data-offset-top="0">

                            <xsl:for-each select="/p:Document/p:Pages/p:Page">
                                <li class="active">
                                    <a href="#{p:Properties/p:Property[@name='fid']/text()}"
                                       title="Go to page '{p:Properties/p:Property[@name='name']/text()}'">
                                        <xsl:value-of
                                                select="p:Properties/p:Property[@name='name']/text()"/>
                                    </a>
                                </li>
                            </xsl:for-each>

                        </ul>
                    </div>
                </div>


                <div class="container-full" id="images">

                    <xsl:for-each select="/p:Document/p:Pages/p:Page">

                        <div class="image-header">
                            <h2 id="{p:Properties/p:Property[@name='fid']/text()}">
                                <xsl:value-of
                                        select="p:Properties/p:Property[@name='name']/text()"/>
                            </h2>

                            <xsl:if test="p:Note">
                                <p>
                                    <xsl:apply-templates select="p:Note/node()" mode="processing-notes"/>
                                </p>
                            </xsl:if>
                        </div>

                        <img src="pages/{p:Properties/p:Property[@name='fid']/text()}.png"
                             width="{p:Properties/p:Property[@name='width']/text()}"
                             height="{p:Properties/p:Property[@name='height']/text()}"
                             usemap="#map_{p:Properties/p:Property[@name='fid']/text()}"
                             class="img-responsive"/>

                        <hr/>

                        <map name="map_{p:Properties/p:Property[@name='fid']/text()}">
                            <xsl:apply-templates select="p:Links/p:Link"/>
                        </map>

                    </xsl:for-each>

                    <footer>
                        <small>
                            <p>
                                <span class="file-name">
                                    <xsl:value-of
                                            select="/p:Document/p:Properties/p:Property[@name='fileName']/text()"/>
                                </span>
                                <br/>
                                <xsl:value-of
                                        select="/p:Document/p:Properties/p:Property[@name='exportTime']/text()"/>
                            </p>
                        </small>
                    </footer>
                </div>

                <script src="static/js/jquery-1.11.1.min.js"></script>
                <script src="static/js/bootstrap.min.js"></script>
            </body>


        </html>
    </xsl:template>

    <xsl:template match="p:Link">
        <area shape="rect"
              coords="{@x},{@y},{@x+@w},{@y+@h}" href="#{@targetFid}" title="Go to page '{@targetName}'"/>
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
