<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text"
          select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">
    <rss version="2.0">
    <channel>
      <xsl:apply-templates/>
    </channel>
    </rss>
  </xsl:template>

  <xsl:template match="//komunikat_ogloszenie">
    <item>
      <title>[<xsl:value-of select="./nw_from_date"/> - <xsl:value-of select="./nw_to_date"/>] <xsl:value-of select="./nw_title"/></title>
      <description><xsl:value-of select="./nw_text"/></description>
      <link>
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="./link" />
          <xsl:with-param name="replace" select="'&amp;api=xml'" />
          <xsl:with-param name="by" select="''" />
        </xsl:call-template>
      </link>
      <guid isPermaLink="true"><xsl:value-of select="./id"/></guid>
      <pubDate><xsl:value-of select="./nw_from_date/text()"/></pubDate>
    </item>
  </xsl:template>

  <xsl:template match="text()|@*"/>

</xsl:stylesheet>
