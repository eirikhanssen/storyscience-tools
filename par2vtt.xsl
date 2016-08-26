<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hfw="http://hfw.no"
    exclude-result-prefixes="xs hfw"
    version="2.0">
    <xsl:output method="text" indent="no"/>

    <xsl:function name="hfw:pad2">
        <xsl:param name="inputNum" as="xs:double"/>
            <xsl:value-of select="format-number($inputNum, '00')"/>
    </xsl:function>
    <xsl:function name="hfw:pad2.3">
        <xsl:param name="inputNum" as="xs:double"/>
        <xsl:value-of select="format-number($inputNum, '00.000')"/>
    </xsl:function>

    <xsl:function name="hfw:seconds2Time">
        <xsl:param name="timeInSeconds" as="xs:double"/>
        <xsl:variable name="hours" select="floor($timeInSeconds div 3600)"/>
        <xsl:variable name="minutes" select="floor(($timeInSeconds - $hours*3600) div 60)"/>
        <xsl:variable name="seconds" select="$timeInSeconds - $hours*3600 - $minutes*60"/>
        <xsl:value-of select="concat(hfw:pad2($hours), ':', hfw:pad2($minutes), ':', hfw:pad2.3($seconds))"/>
    </xsl:function>

    <xsl:template match="item">
        <xsl:variable name="begin" select="@begin"/>
        <xsl:variable name="end" select="@end"/>
        <xsl:variable name="current_id" select="format-number(count(preceding-sibling::item)+1, '000')"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="$current_id"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="hfw:seconds2Time($begin)"/>
        <xsl:text> --> </xsl:text>
        <xsl:value-of select="hfw:seconds2Time($end)"/>
    </xsl:template>
</xsl:stylesheet>
