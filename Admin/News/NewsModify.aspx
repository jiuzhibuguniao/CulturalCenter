<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsModify.aspx.cs" Inherits="CulturalCenter.Admin.News.NewsModify" Theme="GreenT"  ValidateRequest="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--新闻公告修改</title>
<link href="../../kindeditor/themes/default/default.css" rel="stylesheet" />
	<script charset="utf-8" src="../../kindeditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="../../kindeditor/lang/zh_CN.js"></script>

    <link href="../../JS/jquery.uploadify-v2.1.0/example/css/default.css" rel="stylesheet" />
    <link href="../../JS/jquery.uploadify-v2.1.0/uploadify.css"  rel="stylesheet" type="text/css" />
    <script src="../../JS/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/swfobject.js"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/jquery.uploadify.v2.1.0.min.js"></script>

	<script>
	    var editor;
	    KindEditor.ready(function (K) {
	        editor = K.create('input[id="txtContent"]', {
	            resizeType: 1,
	            allowPreviewEmoticons: false,
	            allowImageUpload: false,
	            items: [
                    'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                    'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                    'insertunorderedlist', '|', 'emoticons', 'image', 'link']
	        });
	    });
	    $(document).ready(function () {
	        $("#uploadify").uploadify({
	            'uploader': '../../JS/jquery.uploadify-v2.1.0/uploadify.swf',
	            'script': '../../Ajax/FileUpload.ashx',
	            'cancelImg': '../../JS/jquery.uploadify-v2.1.0/cancel.png',
	            'folder': '../../FileUpload/',
	            'queueID': 'fileQueue',
	            'fileSizeLimit ': '51200KB',
	            'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
	            'width': '100px',
	            'height': '32px',
	            'buttonText': '',
	            'auto': false,
	            'multi': false,
	            'fileExt': '*.rar;*.zip;*.7z;*.iso;*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.txt;*.wps;*.pdf;',
	            'fileDesc': '选择文件，小于50M',
	            'onComplete': function (e, queueId, fileObj, response) {
	                $("#hidFilePath").val(response);
	                $("#hidFileExt").val(fileObj.type);
	                $("#hidFileOriName").val(fileObj.name);
	                if (response != null && response != "0") {
	                    $("span[id=fileUpRes]").html("上传成功：" + fileObj.name);
	                } else {
	                    $("span[id=fileUpRes]").html("上传失败，请重试！");
	                }
	            }
	        });

	        $("#PicUploadify").uploadify({
	            'uploader': '../../JS/jquery.uploadify-v2.1.0/uploadify.swf',
	            'script': '../../Ajax/FileUpload.ashx',
	            'cancelImg': '../../JS/jquery.uploadify-v2.1.0/cancel.png',
	            'folder': '../../Image/News/',
	            'queueID': 'PicUploadifyQueue',
	            'fileSizeLimit ': '10240KB',
	            'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
	            'width': '100px',
	            'height': '32px',
	            'buttonText': '',
	            'auto': false,
	            'multi': false,
	            'fileExt': '*.psd;*.jpg;*.jpeg;*.png;*.gif',
	            'fileDesc': '选择文件，小于10M',
	            'onComplete': function (e, queueId, fileObj, response) {
	                $("#hidImgPath").val(response);
	                if (response != null && response != "0") {
	                    $("img[id=NewsPic]").attr("title", "上传成功！");
	                    $("img[id=NewsPic]").attr("src", "../../Image/News/" + response);
	                } else {
	                    $("img[id=NewsPic]").attr("title", "上传失败！");
	                }
	            }
	        });
	    });
	    
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:700px;margin:0px auto;">
        <div style="width:700px;">
            <table>
                <tr>
                    <td><table style="line-height:30px;width:600px;">
                <tr>
                    <td style="width:50px;text-align:left;">标题</td>
                    <td colspan="3">
                        <asp:Label ID="txtTitle" runat="server" Width="500px"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width:50px">板块</td>
                    <td>
                        <asp:DropDownList ID="ddlBoardID" runat="server" Width="150px" Enabled="false"></asp:DropDownList>
                    </td>
                    <td style="width:50px;">置顶</td>
                    <td>
                        <asp:DropDownList ID="ddlTopShow" runat="server"  Width="150px">
                            <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            <asp:ListItem Text="是" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr></table>
                        </td>
                    <td style="width:60px;height:60px; padding:0px 20px;">
                        <asp:Button ID="btnAdd" runat="server" Text="保存" Height="60" Width="60" ForeColor="#006600" Font-Size="12pt" OnClick="btnAdd_Click" /></td>
                    </tr>
            </table>
            <br />
            <div>
                <asp:TextBox ID="txtContent" runat="server" style="width:700px;height:400px;visibility:hidden;"></asp:TextBox>
            </div>
            <div style="height:20px;padding-top:10px;">
                附件：<asp:Label ID="lblAccName" runat="server" Text=""></asp:Label>
            </div>
            <div>
                <table style="background-color:#f5fbf7;width:700px;">
                    <tr>
	                <td width="80" align="right" valign="middle">
                        <span style="display:block;text-align:left;vertical-align:middle;width:80px;height:30px;float:right;padding-top:0px;">图片修改：</span>
		               </td>
	                <td  width="*" align="left" colspan="3" valign="middle" >
                        <span style="display:block;text-align:left;vertical-align: middle;width:120px;float:left;padding-top:10px;">
                            <input type="file" name="PicUploadify" id="PicUploadify" />
                        </span>
                        <div style="display:block;text-align:left;vertical-align: middle;width:300px;float:left;padding-top:10px;">
                               <div id="PicUploadifyQueue" ></div>
                        </div>
                        
                        <div  style="display:block;text-align:center;vertical-align: central;width:120px;padding:0px 10px;float:left;padding-top:40px;color:#408a4d;font-size:10pt;">
                            <input type="button" value="上传" cursor="pointer" onclick="javascript: $('#PicUploadify').uploadifyUpload();" />
                            <br />
                        </div>
	                </td>
                        <td width="60px"><img id="NewsPic" alt="" src='<%=ImgPath %>' width="60px" /></td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="background-color:#f5fbf7;width:700px;">
                    <tr>
	                <td width="80" align="right" valign="middle">
                        <div style="display:block;text-align:left;vertical-align:middle;width:80px;height:80px;float:right;padding-top:0px;"> 附件修改：</div>
		               </td>
	                <td  width="*" align="left" colspan="3" >
                        <div style="display:block;text-align:left;vertical-align: middle;width:120px;float:left;padding-top:40px;">
                            <input type="file" name="uploadify" id="uploadify" />
                        </div>
                        <div style="display:block;text-align:left;vertical-align: middle;width:300px;float:left;padding-top:40px;">
                               <div id="fileQueue" ></div>
                        </div>
                        
                        <div  style="display:block;text-align:center;vertical-align: central;width:120px;padding:0px 10px;float:left;padding-top:40px;color:#408a4d;font-size:10pt;">
                            <input type="button" value="上传" cursor="pointer" onclick="javascript: $('#uploadify').uploadifyUpload();" />
                            <br />
                        </div>
	                </td>
                    </tr>
                    <tr><td colspan="2"><span id="fileUpRes" style="color:#808080;"><%=FilePath %></span></td></tr>
                </table>
            </div>
        </div>
    </div>
        <asp:HiddenField ID="hidFilePath" runat="server" Value=""/>
        <asp:HiddenField ID="hidFileExt" runat="server" Value="" />
        <asp:HiddenField ID="hidFileOriName" runat="server" Value="" />
        <asp:HiddenField ID="hidImgPath" runat="server" Value=""/>
    </form>
</body>
</html>
