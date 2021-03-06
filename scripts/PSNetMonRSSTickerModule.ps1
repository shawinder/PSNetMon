########################################################################  Powershell Network Monitor RSS Feed Ticker
#  Created by Brad Voris#  This script is used to generate results for the rssticker.html page
#  Need- run from CFG file, multiple RSS feeds, convert feeds to links
#        remove star from feed########################################################################Script variables
$Daterss = ([datetime]::Now)

#1st RSS Feed Stream
$WebClient01 = New-Object system.net.webclient
$RSSFeed01 = [xml]$WebClient01.DownloadString('http://feeds.reuters.com/Reuters/worldNews')
$RSSFeedVar01 = $RSSFeed01.rss.channel.item | Select-Object title -First 5 | ConvertTo-Html
#2nd RSS Feed Stream
$WebClient02 = New-Object system.net.webclient
$RSSFeed02 = [xml]$WebClient02.DownloadString('http://feeds.feedburner.com/securityweek')
$RSSFeedVar02 = $RSSFeed02.rss.channel.item | Select-Object title -First 5 | ConvertTo-Html

#HTML Header Coding
$HTMLHeadRSSM = @"
<!DOCTYPE html>
<HEAD>
<META charset="UTF-8">
<TITLE>PSNetMon - RSS Ticker Module</TITLE>
<CENTER>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> </HEAD>
"@

#HTML Body Coding
$HTMLBodyRSSM = @"<CENTER><TABLE  border="0"><TR bgcolor=#5CB3FF><TD><MARQUEE Behavior="scroll" Direction="left" ScrollAmount="3">$RSSFeedVar01</MARQUEE></TD>
</TR>
<TR BGCOLOR=#5CB3FF>
<TD><MARQUEE Behavior="scroll" Direction="left" ScrollAmount="3">$RSSFeedVar02</MARQUEE></TD></TR></TABLE><I>$Daterss</I></CENTER>"@

#Export to HTML
$Script | ConvertTo-HTML -Head $HTMLHeadRSSM -Body $HTMLBodyRSSM | Out-file "C:\inetpub\wwwroot\gen\rssticker.html"

