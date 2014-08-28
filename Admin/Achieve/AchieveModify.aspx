<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AchieveModify.aspx.cs" Inherits="CulturalCenter.Admin.Achieve.AchieveModify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../CSS/Mainpage.css" rel="stylesheet" type="text/css" />
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
                 'folder': '../../FileUpload/',
                 'queueID': 'fileQueue',
                 'fileSizeLimit ': '102400KB',
                 'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
                 'width': '100px',
                 'height': '32px',
                 'buttonText': '',
                 'auto': false,
                 'multi': false,
                 'fileExt': '*.rar;*.zip;*.7z;*.iso;*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.txt;*.wps;*.pdf;*.psd;*.jpg;*.jpeg;*.png;*.gif',
                 'fileDesc': '选择文件，小于100M',
                 'onComplete': function (e, queueId, fileObj, response) {
                     $("#hidFileNewName").val(response);
                     $("#hidFileExt").val(fileObj.type);
                     $("#hidFileOriName").val(fileObj.name);
                     if (response != null && response != "0") {
                         $("#SpanfileName").empty().html("成功上传：" + fileObj.name);
                     }
                 }
             });
         });
    </script>
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
            <tr><td colspan="3">项目来源：<asp:TextBox ID="txtOrigon" runat="server" Width="400px"></asp:TextBox></td></tr>
            <tr>
                <td>负 责 人：<asp:TextBox ID="txtCharger" runat="server" Width="150px"></asp:TextBox></td>
                <td>出版机构：<asp:TextBox ID="txtPublish" runat="server" Width="150px"></asp:TextBox></td>
                <td>所属板块：<asp:DropdownList ID="ddlBoard" runat="server" Width="150px"></asp:DropdownList></td>
            </tr>
            <tr>
                <td colspan="3" class="TD_Content">
                    <span class="TD_tag">主要内容：</span>
                    <asp:TextBox ID="txtContent" runat="server" Width="700px" TextMode="MultiLine" Height="100px"></asp:TextBox></span>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="TD_Content">
                    <span class="TD_tag">主要意义：</span>
                    <asp:TextBox ID="txtMeaning" runat="server" Width="700px" TextMode="MultiLine" Height="100px"></asp:TextBox>
                </td></tr>
        </table>
        <table>
            <tr>
                <td>附件修改：</td>
                <td>
                    <input type="file" name="uploadify" id="uploadify" /><div id="fileQueue" ></div>
                    <input type="button" value="上传" cursor="pointer" onclick="javascript: $('#uploadify').uploadifyUpload()" />
                    <span id="SpanfileName" style="font-weight:normal;color:#808080;font-size:12px;">
                        当前附件：<a href='<%=FilePath %>'><asp:Label ID="txtFileName" runat="server"></asp:Label></a>
                    </span>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hidAchID" runat="server" Value="" />
        <asp:HiddenField ID="hidFileNewName" runat="server" Value="" Visible="true"/>
        <asp:HiddenField ID="hidFileExt" runat="server" Value="" />
        <asp:HiddenField ID="hidFileOriName" runat="server" Value="" />
        <span style="padding:5px; height:30px;width:100px;margin:0px auto;text-align:center;">
            <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />
            <asp:Button ID="btnSaveAdd" runat="server" Text="保存并继续添加" OnClick="btnSaveAdd_Click" />
        </span>
    </div>
    </form>
</body>
</html>
