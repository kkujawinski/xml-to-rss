<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
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
      <link><xsl:value-of select="./link"/></link>
      <guid isPermaLink="true"><xsl:value-of select="./id"/></guid>
      <pubDate><xsl:value-of select="./nw_from_date/text()"/></pubDate>
    </item>
  </xsl:template>

  <xsl:template match="text()|@*"/>

</xsl:stylesheet>
