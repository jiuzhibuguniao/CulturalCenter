<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TypeModify.aspx.cs" Inherits="CulturalCenter.Admin.Attach.TypeModify" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--类型修改</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin:50px auto; display:block;width:300px;height:300px;position:relative;text-align:center;">
        <table style="line-height:30px;color:#2d6323;font-size:12px;">
            <tr>
                <td>上级板块名</td>
                <td><asp:DropDownList ID="ddlParent" runat="server" Width="130"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>板块名</td>
                <td><asp:TextBox ID="txtBoardName" runat="server" ></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <asp:Button ID="btnConfirm" runat="server" Text="保存" OnClick="btnConfirm_Click" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
