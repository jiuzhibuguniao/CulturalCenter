<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowSingle.aspx.cs" Inherits="CulturalCenter.Admin.Member.ShowSingle" EnableTheming="true" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--个人信息</title>
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 95%;" cellpadding="2" cellspacing="1" class="border" >
        <tr>
            <td class="tdbg" align="center">
                <table cellSpacing="0" cellPadding="0" width="750" border="0">
	                <tr><td height="25"></td><td></td><td></td><td></td></tr>
                    <tr><td height="25"></td><td></td><td></td><td></td></tr>
                    <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                登录ID：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtLoginID" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                密 码：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtPassword" runat="server" Width="200px"></asp:Label>
	                </td></tr>
	                <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                姓   名：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtStaffName" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                性 别：</td>
	                <td height="30" width="*" align="left">
                       <asp:Label id="lblGender" runat="server" Width="200px"></asp:Label>
		                </td></tr>
	                <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                电   话：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtPhone" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                邮 箱：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtEmail" runat="server" Width="200px"></asp:Label>
	                </td></tr>
	                <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                地   址：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtAddress" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                职 务：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtJob" runat="server" Width="200px"></asp:Label>
	                </td></tr>
	                <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                单  位：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="txtDepartID" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                类 别：</td>
	                <td height="30" width="*" align="left">
                        <asp:DropDownList ID="ddlType" runat="server" Width="200px" Enabled="false">
                            <asp:ListItem Text="正常专家" Value="0"></asp:ListItem>
                            <asp:ListItem Text="正常领导" Value="1"></asp:ListItem>
                            <asp:ListItem Text="领导兼专家" Value="2"></asp:ListItem>
                            <asp:ListItem Text="普通编辑" Value="3"></asp:ListItem>
                            <asp:ListItem Text="管理员" Value="4"></asp:ListItem>
                            <asp:ListItem Text="超级管理员" Value="5"></asp:ListItem>
                            <asp:ListItem Text="待审核" Value="6"></asp:ListItem>
                            <asp:ListItem Text="注销" Value="7"></asp:ListItem>
                        </asp:DropDownList>
	                </td></tr>
	                <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;">
		                注册时间：</td>
	                <td height="30" width="*" align="left">
		                <asp:Label id="lblRegtime" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="30" width="30%" align="right">
		               </td>
	                <td height="30" width="*" align="left">
		               
	                </td></tr>
                    <tr>
	                <td height="30" width="30%" align="right" style="color:#27631e;vertical-align:middle;">
		                <span style="position:relative;display:inline-block;">个人简介：</span>
	                </td>
	                <td height="30" width="*" align="left" colspan="2">
		                <asp:TextBox id="txtResume" runat="server" TextMode="MultiLine" Width="350px" Height="100px"></asp:TextBox>
	                </td>
                    <td>
                        <asp:Image ID="Photo" runat="server" Width="90" Height="120" /></td>
	                </tr>
                </table>
            </td>
        </tr>
        <tr>
            
        </tr>
    </table>
    </form>
</body>
</html>
