<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartModify.aspx.cs" Inherits="CulturalCenter.Admin.Attach.DepartModify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--单位修改</title>
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
                 'folder': '../../Image/DepartPhoto/',
                 'queueID': 'fileQueue',
                 'fileSizeLimit ': '5120KB',
                 'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
                 'width': '100',
                 'height': '32',
                 'buttonText': '',
                 'auto': false,
                 'multi': false,
                 'fileExt': '*.jpg;*.jpeg;*.png;*.gif',
                 'fileDesc': '选择图片，小于5M',
                 'onComplete': function (e, queueId, fileObj, response) {
                     $("#hidFilePath").val(response);
                     $("#hidFileExt").val(fileObj.type);
                     $("#hidFileOriName").val(fileObj.name);
                     if (response != null && response != "0") {
                         $("img[id=MemPhoto]").attr("title", "上传成功！");
                         $("img[id=MemPhoto]").attr("src", "../../Image/DepartPhoto/" + response);
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
                    <tr>
	                <td height="25" width="30%" align="right">
		                单位名称
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtDepartName" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                负责人
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtChargeName" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                单位地址
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtAddress" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                联系方式
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtConnect" runat="server" Width="200px"></asp:TextBox>                        
		                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                单位类型
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlDepartType" runat="server"></asp:DropDownList>
	                </td>
	                <td height="25" width="30%" align="right">
		                首页展示
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:DropDownList ID="ddlShow" runat="server">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
		                </asp:DropDownList>
	                </td></tr>
                    <tr>
	                <td width="30%" align="right" valign="middle">
                        <div style="display:block;height:80px;text-align:right;vertical-align: middle;width:120px;float:right;padding-top:40px;">显示图片：</div>
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
                        <div style="display:block;height:90px;text-align:left;vertical-align: middle;width:auto;float:left;padding-top:30px;">
                            <asp:Image id="MemPhoto" runat="server" ImageUrl="../../image/default.jpg" width="90" height="60" style="border:1px solid #CCFFCC;" />
                        </div>

	                </td>
                    </tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                单位简介
	                ：</td>
	                <td height="25" width="*" align="left" colspan="3">
		                <asp:TextBox id="txtResume" runat="server" TextMode="MultiLine" Width="550px" Height="250px"></asp:TextBox>
	                </td></tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="tdbg" align="center" valign="bottom">
                <asp:Button ID="btnSave" runat="server" Text="保存"
                    OnClick="btnSave_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
                <asp:Button ID="Button1" runat="server" Text="保存并继续添加" OnClick="Button1_Click" />
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
