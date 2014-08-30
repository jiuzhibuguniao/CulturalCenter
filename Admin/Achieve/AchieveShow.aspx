<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AchieveShow.aspx.cs" Inherits="CulturalCenter.Admin.Achieve.AchieveShow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../CSS/Mainpage.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="AchBox" class="achBox">
        <table>
            <tr>
                <td colspan="3">
                    项 目 名：<asp:Label ID="txtAchName" runat="server" Width="400px"></asp:Label>
                </td>
            </tr>
            <tr><td colspan="3">项目来源：<asp:Label ID="txtOrigon" runat="server" Width="400px"></asp:Label></td></tr>
            <tr>
                <td>负 责 人：<asp:Label ID="txtCharger" runat="server" Width="150px"></asp:Label></td>
                <td>出版机构：<asp:Label ID="txtPublish" runat="server" Width="150px"></asp:Label></td>
                <td>所属板块：<asp:Label ID="txtBoard" runat="server" Width="150px"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3" class="TD_Content">
                    <span class="TD_tag">主要内容：</span>
                    <asp:Label ID="txtContent" runat="server" Width="700px" ></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="TD_Content">
                    <span class="TD_tag">主要意义：</span>
                    <asp:Label ID="txtMeaning" runat="server" Width="700px" TextMode="MultiLine"></asp:Label>
                </td></tr>
            <tr>
                <td colspan="3">
                    附件：<span id="SpanfileName" style="font-weight:normal;color:#808080;font-size:12px;">
                        <a href='<%=FilePath %>'  target="_blank"><asp:Label ID="txtFileName" runat="server"></asp:Label></a>
                       </span>
                </td>
            </tr>
            <tr>
                <td colspan="3"><a href="AchieveMana.aspx">返回</a></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
