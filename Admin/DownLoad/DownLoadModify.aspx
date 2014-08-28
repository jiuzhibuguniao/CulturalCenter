<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DownLoadModify.aspx.cs" Inherits="CulturalCenter.Admin.DownLoad.DownLoadModify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<link href="../../CSS/Mainpage.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="homePicAddBox">
        <div class="attachment">
            <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="保存" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="back" runat="server" PostBackUrl="~/Admin/DownLoad/DownLoadMana.aspx" Text="返回" />
        </div>
        <div class="DownLoad">
            <span class="txtArea">
                <span class="downTitle">
                    标题：<asp:TextBox runat="server" id="txtDownTitle" style="width:400px;"></asp:TextBox>
                </span>
                <span class="downBoard">
                    板块：<asp:DropDownList ID="ddlDownLoad" runat="server"></asp:DropDownList>
                </span>
            </span>
            <span class="txtArea">
                <span class="Desc">描述：</span>
                <span class="DescTxt"><asp:TextBox id="txtDownDesc" style="width:600px;height:100px;" runat="server" TextMode="MultiLine"></asp:TextBox></span>
                
            </span>
        </div>
        <div class="attach_area">
            <asp:Repeater ID="repDownFile" runat="server">
                <ItemTemplate>
                <span class="attachment"><a href='<%#Maticsoft.Common.CommonFun.URLConverToServer("../../FileUpload/"+Eval("FilePath")) %>' target="_blank"><%#Eval("FileOriName") %></a> </span>
                    </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
        <input type="hidden" id="hidFlag" value="" />
        <asp:HiddenField ID="hidDownID" runat="server" Value="" />
        <asp:HiddenField ID="AuthorID" runat="server" Value="" />
    </form>
</body>
</html>
