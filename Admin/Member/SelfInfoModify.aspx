<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelfInfoModify.aspx.cs" Inherits="CulturalCenter.SelfInfoModify" EnableTheming="true" Theme="GreenT"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--个人信息修改</title>
    <link href="../../JS/jquery.uploadify-v2.1.0/example/css/default.css" rel="stylesheet" />
    <link href="../../JS/jquery.uploadify-v2.1.0/uploadify.css"  rel="stylesheet" type="text/css" />
    <script src="../../JS/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/swfobject.js"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/jquery.uploadify.v2.1.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uploadify").uploadify({
                'uploader': '../../JS/jquery.uploadify-v2.1.0/uploadify.swf',
                'script': '../../Ajax/FileUpload.ashx',
                'cancelImg': '../../JS/jquery.uploadify-v2.1.0/cancel.png',
                'folder': '../../Image/Photo/',
                'queueID': 'fileQueue',
                'fileSizeLimit ': '102400KB',
                'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
                'width': '100px',
                'height': '32px',
                'buttonText': '',
                'auto': false,
                'multi': false,
                'fileExt': '*.jpg;*.jpeg;*.png;*.gif',
                'fileDesc': '选择文件，小于100M',
                'onComplete': function (e, queueId, fileObj, response) {
                    $("#hidFilePath").val(response);
                    $("#hidFileExt").val(fileObj.type);
                    $("#hidFileOriName").val(fileObj.name);
                    if (response != null && response != "0") {
                        $("img[id=Photo]").attr("title", "上传成功！");
                        $("img[id=Photo]").attr("src", "../../Image/Photo/" + response);
                    } else {
                        $("img[id=Photo]").attr("title", "上传失败！");
                    }
                }
            });
        });
    </script>
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
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                登录名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:Label id="txtLoginID" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                密 码
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:Label id="txtPassword" runat="server" Width="200px"></asp:Label>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                姓 名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:Label id="txtStaffName" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                性 别
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlGender" runat="server" Width="200px">
                            <asp:ListItem Text="" Value="0"></asp:ListItem>
                            <asp:ListItem Text="男" Value="1"></asp:ListItem>
                            <asp:ListItem Text="女" Value="2"></asp:ListItem>
                        </asp:DropDownList>
		                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                电 话
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtPhone" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                邮 箱
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtEmail" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                地 址
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtAddress" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                职 务
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtJob" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                单 位
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtDepartID" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                类 别
	                ：</td>
	                <td height="25" width="*" align="left">
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
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                录入时间
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:Label id="lblRegtime" runat="server" Width="200px"></asp:Label>
	                </td>
	                <td height="25" width="30%" align="right">
		               </td>
	                <td height="25" width="*" align="left">
		               
	                </td></tr>
                    <tr>
	                <td height="25" width="30%" align="right" style="color:#27631e;">
		                个人简介
	                ：</td>
	                <td height="25" width="*" align="left" colspan="2">
		                <asp:TextBox id="txtResume" runat="server" TextMode="MultiLine" Width="350px" Height="100px"></asp:TextBox>
	                </td>
                    <td>
                        <asp:Image ID="Photo" runat="server" Width="90" Height="120" /></td>
	                </tr>
                    <tr>
                        <td height="*" width="30%" align="right" style="color:#27631e;">
		                照片修改
	                ：</td>
                        <td><input type="file" name="uploadify" id="uploadify" /><div id="fileQueue" ></div>
                    </td>
                        <td>
                            <input type="button" value="上传" cursor="pointer" onclick="javascript: $('#uploadify').uploadifyUpload()" />
                        </td>
                    </tr>
                    <tr><td colspan="4" align="center">
                        <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />
                        </td></tr>
                </table>
            </td>
        </tr>
        </table>
         <asp:HiddenField ID="hidFilePath" runat="server" Value=""/>
        <asp:HiddenField ID="hidFileExt" runat="server" Value="" />
        <asp:HiddenField ID="hidFileOriName" runat="server" Value="" />
    </form>
</body>
</html>
