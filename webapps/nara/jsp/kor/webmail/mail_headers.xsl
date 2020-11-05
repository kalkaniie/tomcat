<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="html" indent="yes" encoding="utf-8" />
	<xsl:template match="headers">
		<table
			style="width:100%;border-bottom: 3px double #DDDDDD; border-top: 3px double #DDDDDD;">
			<xsl:for-each select="header">
				<tr>
					<th width="150" scope="row"
						style="border-bottom: 1px solid #E1E1E1; padding:3px 8px; line-height: 14px; vertical-align:top;background: #f7f7f7; font-weight: normal; color: #333333; text-align:left;">
						<xsl:value-of select="name" />
					</th>
					<td
						style="border-bottom: 1px dashed #CACACA;padding:3px 8px; line-height: 14px; vertical-align:top">
						<xsl:value-of select="value" />
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>