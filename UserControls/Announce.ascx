<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Announce.ascx.cs" Inherits="CulturalCenter.Announce" %>
<link href="../CSS/Common.css" rel="stylesheet" />

<p class="Announce" style="height:auto; margin:3px 0px;">
    <span class="AnnounceTitle">
        <a href="../Announcement/Show.aspx?id=<%#Eval("AnnounceID").ToString() %>" title='<%#Eval("Title") == null ? "" : Eval("Title").ToString()%>' target="_blank"><%#Eval("Title") == null ? "" : CutString(Eval("Title").ToString())%></a>
    </span>
	<span class="AnnounceTime"> 
	    <%# FormatDate(Eval("AdverTime"))%>
	</span>
</p>