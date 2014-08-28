<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowDepartSingle.aspx.cs" Inherits="CulturalCenter.Admin.Attach.ShowDepartSingle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--单位信息展示</title>
    <style>
        .tableStyle, .tableStyle tr td {
            border:1px solid #c7ef94;
            font-size:14px;
            color:#17580d;
            line-height:20px;
        }
            .tableStyle tr td table,.tableStyle tr td table tr,.tableStyle tr td table tr td {
                border:none;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 500px;margin:0px auto;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="tdbg" align="center">
                <table cellSpacing="0" cellPadding="0" width="750" border="0" class="tableStyle">
                    <tr style="height:140px;">
                        <td  colspan="2"> <asp:Image id="MemPhoto" runat="server" ImageUrl ="../../image/default.jpg" width="200" height="120" style="border:1px solid #CCFFCC;margin:10px;" /></td>
                        <td colspan="2">
                            <table  >
                                <tr>
                                    <td width="80px" align="right">单位名称：</td>
	                                <td width="*" align="left">
		                                <asp:Label id="lblDepartName" runat="server" Width="200px"></asp:Label>
	                                </td>
                                </tr>
                                <tr>
	                                <td width="80px" align="right">负责人：</td>
	                                <td  width="*" align="left"> <asp:Label id="lblChargeName" runat="server" Width="200px"></asp:Label> </td>
                                </tr>
                                <tr>
	                                <td  width="80px" align="right">单位地址：</td>
	                                <td width="*" align="left"><asp:Label id="lblAddress" runat="server" Width="200px"></asp:Label>
	                                </td>
                                </tr>
                                <tr>
	                                <td  width="80px" align="right">联系方式：</td>
	                                <td  width="*" align="left"><asp:Label id="lblConnect" runat="server" Width="200px"></asp:Label>                        
		                            </td>
	                            </tr>
                            </table>
                        </td>
                    </tr>
	                <tr>
	                <td height="25" width="100px" align="right">
		                单位类型
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlDepartType" runat="server" Enabled="false"></asp:DropDownList>
	                </td>
	                <td height="25" width="100px" align="right">
		                首页展示
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:DropDownList ID="ddlShow" runat="server" Enabled="false">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
		                </asp:DropDownList>
	                </td></tr>
	                <tr>
	                <td height="25" width="100px" align="right" valigh="middle">
		                单位简介
	                ：</td>
	                <td height="25" width="*" align="left" colspan="3">
		                <asp:Label id="txtResume" runat="server" TextMode="MultiLine" Width="550px" Height="250px"></asp:Label>
	                </td></tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
