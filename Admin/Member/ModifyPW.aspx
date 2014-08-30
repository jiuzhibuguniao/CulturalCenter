<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyPW.aspx.cs" Inherits="CulturalCenter.Admin.Member.ModifyPW" EnableTheming="true"  Theme="GreenT"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--密码修改</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin:50px auto; display:block;width:300px;height:300px;position:relative;text-align:center;">
        <table style="line-height:30px;">
            <tr>
                <td>原密码</td>
                <td><asp:TextBox ID="txtOldPW" runat="server" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td>新密码</td>
                <td><asp:TextBox ID="txtNewPW" runat="server" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td>密码确认</td>
                <td><asp:TextBox ID="txtPWRe" runat="server" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <asp:Button ID="btnConfirm" runat="server" Text="修改" OnClick="btnConfirm_Click" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
