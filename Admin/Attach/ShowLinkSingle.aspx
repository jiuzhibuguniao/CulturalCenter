<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowLinkSingle.aspx.cs" Inherits="CulturalCenter.Admin.Attach.ShowLinkSingle" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--友情链接</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width:500px;margin:0px auto;line-height:30px;color:#1d6b23;">
        <tr><td>链接名</td><td>
            <asp:Label ID="lblName" runat="server" Text=""></asp:Label></td>
            <td>地址</td><td>
                <asp:Label ID="lblURL" runat="server" Text=""></asp:Label></td>
            <td>
                <asp:Image ID="LinkImg" runat="server" Width="120px" Height="40px" /></td>
        </tr>
        <tr><td colspan="5">
           <%-- <iframe src='<%=URL!=null?URL.ToString().Contains("http")?URL.ToString():@"http://"+URL.ToString():"#" %>' style="width:480px;height:600px;"></iframe>--%>
            </td></tr>
    </table>
    </div>
    </form>
</body>
</html>
