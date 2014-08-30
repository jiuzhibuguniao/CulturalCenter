<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddLink.aspx.cs" Inherits="CulturalCenter.Admin.Attach.AddLink" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--新增链接</title>
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
                 'folder': '../../Image/LinkPhoto/',
                 'queueID': 'fileQueue',
                 'fileSizeLimit ': '1024KB',
                 'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
                 'width': '100',
                 'height': '32',
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
                         $("img[id=LinkPhoto]").attr("title", "上传成功！");
                         $("img[id=LinkPhoto]").attr("src", "../../Image/LinkPhoto/" + response);
                     } else {
                         $("img[id=LinkPhoto]").attr("title", "上传失败！");
                     }
                 }
             });
             $("img[id=LinkPhoto]").attr("src", $("#LaodImgPath").val());
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
	                <td height="25" width="120px" align="right">
		                链接名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtLinkName" runat="server" Width="300px"></asp:TextBox>
	                </td>
                        </tr>
                    <tr>
	                <td height="25" width="120px" align="right">
		                链接URL
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtURL" runat="server" Width="300px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="120px" align="right">
		                链接类型
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:DropDownList ID="ddlLinkType" runat="server">
                            <asp:ListItem Text="文字链接" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="图片链接" Value="1"></asp:ListItem>
                        </asp:DropDownList>
	                </td></tr>
                    <tr>
	                <td width="120px" align="right" valign="middle">
                        <span style="display:block;height:30px;text-align:right;vertical-align: middle;width:60px;float:right;padding-top:10px;">上传图片：</span>
		               </td>
	                <td height="120" width="*" align="left">
                        <table>
                            <tr>
                                <td>
                                    <input type="file" name="uploadify" id="uploadify" />
                                     <div id="fileQueue" ></div>
                                    
                                </td>
                                <td style="width:130px;vertical-align:middle;padding:10px;"><input type="button" value="上传" cursor="pointer" onclick="$('#uploadify').uploadifyUpload();" />
                                    <span style="display:block;height:40px;text-align:right;vertical-align: middle;width:120px;float:left;">
                                    <img  id="LinkPhoto" src="" width="120" height="40"  alt=""/></span>
                                </td>
                            </tr>
                        </table>
	                </td>
                    </tr>
	                
                </table>
            </td>
        </tr>
        <tr>
            <td class="tdbg" align="center" valign="bottom" style="padding:20px 0px;">
                <asp:Button ID="btnSave" runat="server" Text="保存并查看"
                    OnClick="btnSave_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
                <asp:Button ID="Button1" runat="server" Text="保存并继续添加" OnClick="Button1_Click" />
                <asp:Button ID="btnCancle" runat="server" Text="取消"
                     PostBackUrl="~/Admin/Attach/LinkMana.aspx" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
            </td>
        </tr>
    </table>
        <asp:HiddenField ID="hidFilePath" runat="server" Value=""/>
        <asp:HiddenField ID="hidFileExt" runat="server" Value="" />
        <asp:HiddenField ID="hidFileOriName" runat="server" Value="" />
        <asp:HiddenField ID="LaodImgPath" runat="server" Value="" />
    <br />
    </form>
</body>
</html>
