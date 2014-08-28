<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePicModify.aspx.cs" Inherits="CulturalCenter.Admin.News.HomePicModify" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="position:relative;width:440px;height:auto;margin:20px auto;padding:10px;">
        <asp:HiddenField ID="ImgID" runat="server" />
        <div style="width:100%;height:260px; padding:20px 0px;">
            <asp:Image ID="Imghome" runat="server" ImageUrl="" Width="420px" Height="260px" />
        </div>
        <div style="width:100%;height:30px; padding:20px 0px;">
            描述：<asp:TextBox ID="txtDesc" runat="server" Width="380px"></asp:TextBox>
        </div>
        <div style="width:100%;height:30px; padding:20px 0px;text-align:center;">
            <asp:Button ID="btnSave" runat="server" Text="保存"  OnClick="btnSave_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="取消" PostBackUrl="~/Admin/News/HomePicMana.aspx" />
        </div>
    </div>
    </form>
</body>
</html>
