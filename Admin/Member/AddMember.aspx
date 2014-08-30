<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMember.aspx.cs" Inherits="CulturalCenter.Member.AddMember" EnableTheming="true" Theme="GreenT"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--新增人员</title>
    
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
                 'fileSizeLimit ': '1024KB',
                 'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
                 'width': '100px',
                 'height': '32px',
                 'buttonText': '',
                 'auto': false,
                 'multi': false,
                 'fileExt': '*.jpg;*.jpeg;*.png;*.gif',
                 'fileDesc': '选择图片，小于1024kb',
                 'onComplete': function (e, queueId, fileObj, response) {
                     $("#hidFilePath").val(response);
                     $("#hidFileExt").val(fileObj.type);
                     $("#hidFileOriName").val(fileObj.name);
                     if (response != null && response != "0") {
                         $("img[id=MemPhoto]").attr("title", "上传成功！");
                         $("img[id=MemPhoto]").attr("src", "../../Image/Photo/" + response);
                     } else {
                         $("img[id=MemPhoto]").attr("title", "上传失败！");
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
	                <td height="25" width="30%" align="right">
		                登录名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtLoginID" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                密 码
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtPassword" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                姓名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtStaffName" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                性别
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlGender" runat="server" Width="200px">
                            <asp:ListItem Text="" Value="0"></asp:ListItem>
                            <asp:ListItem Text="男" Value="1"></asp:ListItem>
                            <asp:ListItem Text="女" Value="2"></asp:ListItem>
                        </asp:DropDownList>
		                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                电话
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtPhone" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                邮箱
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtEmail" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                地址
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtAddress" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                职务
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtJob" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                单位
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtDepartID" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                类别
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlType" runat="server" Width="200px">
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
	                <td width="30%" align="right" valign="middle">
                        <div style="display:block;height:80px;text-align:right;vertical-align: middle;width:120px;float:right;padding-top:40px;"> 照片上传：</div>
		               </td>
	                <td height="120" width="*" align="left" colspan="3" >
                        <div style="display:block;height:80px;text-align:left;vertical-align: middle;width:120px;float:left;padding-top:40px;">
                            <input type="file" name="uploadify" id="uploadify" />
                        </div>
                        <div style="display:block;height:80px; text-align:left;vertical-align: middle;width:260px;float:left;padding-top:40px;">
                               <div id="fileQueue" ></div>
                        </div>
                        
                        <div  style="display:block;height:80px;text-align:center;vertical-align: central;width:80px;padding:0px 10px;float:left;padding-top:40px;color:#408a4d;font-size:10pt;">
                            <input type="button" value="上传" cursor="pointer" onclick="javascript: $('#uploadify').uploadifyUpload();" />
                            <br />
                        </div>
                        <div style="display:block;height:120px;text-align:left;vertical-align: middle;width:auto;float:left;">
                            <img id="MemPhoto" src="../../image/default.jpg" width="90" height="120" style="border:1px solid #CCFFCC;" />
                        </div>

	                </td>
                    </tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                个人简介
	                ：</td>
	                <td height="25" width="*" align="left" colspan="3">
		                <asp:TextBox id="txtResume" runat="server" TextMode="MultiLine" Width="550px" Height="50px"></asp:TextBox>
	                </td></tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="tdbg" align="center" valign="bottom" style="padding:10px 0px;height:30px;">
                <asp:Button ID="btnSave" runat="server" Text="保存并查看"
                    OnClick="btnSave_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
                <asp:Button ID="Button1" runat="server" Text="保存并继续添加" OnClick="Button1_Click" />
                <asp:Button ID="btnCancle" runat="server" Text="取消"
                    OnClick="btnCancle_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
            </td>
        </tr>
    </table>
        <asp:HiddenField ID="hidFilePath" runat="server" Value=""/>
        <asp:HiddenField ID="hidFileExt" runat="server" Value="" />
        <asp:HiddenField ID="hidFileOriName" runat="server" Value="" />
    <br />
    </form>
</body>
</html>
