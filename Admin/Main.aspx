<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="CulturalCenter.Admin.Index" EnableTheming="true" Theme="GreenT" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--办公系统主页</title>
</head>
<body>
    <form id="form1" runat="server">
    <a href="../Default.aspx" title="单击回主页" target="_blank"><span style="width:200px;height:100px;position:absolute;top:0px;left:0px;z-index:99;"></span></a>
    <div id="headerCon" class="headerContainer">
        <div id="header_home" class="Adminheader">
                <object id="obj1" border="0" width="998" height="100" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000">
                <param value="../image/web/piaodai.swf" name="movie">
                <param value="High" name="quality">
                <param value="transparent" name="wmode">
                <embed width="998" height="100" wmode="transparent" quality="High" name="obj1" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" src="../image/web/piaodai.swf"></object>
        </div>
        <div id="time" style="display:block; position:absolute; top:50px; right:30px; color: #456F1C;">
            <uco:TimeControl ID="timeControl" runat="server" />
        </div>
    </div>
         <div id="LoginInfo" class="LoginInfoContainer">
    您好：<asp:Label ID="name" runat="server" ></asp:Label>

    </div>
    <div class="mainBox">
    <div id="navContainer" class="navContainer">
        <div id="ToAdminHome" class="ToAdminHome"><a href="WelcomePage.aspx" target="info" style="font-size:12px;">欢迎进入办公系统！</a></div>
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1" 
            ShowLines="True" Width="150px" Font-Names="宋体" Font-Size="10pt" 
            ForeColor="#456F1C" Font-Bold="true" LineImagesFolder="~/TreeLineImages" Target="info">
            <HoverNodeStyle Font-Underline="True" ForeColor="Blue" />
            <SelectedNodeStyle Font-Bold="True" Font-Underline="True" ForeColor="#000099" />
        </asp:TreeView><br/>
        <a href="../Default.aspx" title="回主页" target="_blank"><img alt="" src="../Image/Web/home_btn.png" width="64px" height="64px" /></a>
        <asp:ImageButton ID="btnExit" runat="server" ImageUrl="~/Image/Web/exit_btn.png" Height="64px" ImageAlign="Left" Width="64px" OnClientClick="return confirm('确认退出后台？')" OnClick="btnExit_Click"  CssClass="cursor_pointer"/>
        <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" 
            SiteMapProvider="AdminSite" ShowStartingNode="false" />
    </div>
    <div id="content" class="Content">
        <div id="contentdata" class="ContentData">
        <iframe id="info" src="WelcomePage.aspx" style=" width:100%;height:550px;padding:10px 0px 0px 0px;border:none;" scrolling="auto" name="info"></iframe>
        </div> 
    </div>
    <div style="text-align:center;padding:5px 0px;z-index:0;clear:both;">
        <uco:copyright ID="copyright1" runat="server" />
    </div>
    </div>
    </form>
</body>
</html>
