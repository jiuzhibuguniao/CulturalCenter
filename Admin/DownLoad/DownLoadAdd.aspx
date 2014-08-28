<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DownLoadAdd.aspx.cs" Inherits="CulturalCenter.Admin.DownLoad.DownLoadAdd" Theme="GreenT" %>

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
	<script>

	    $(document).ready(function () {
	        $("#uploadify").uploadify({
	            'uploader': '../../JS/jquery.uploadify-v2.1.0/uploadify.swf',
	            'script': '../../Ajax/FileUpload.ashx',
	            'cancelImg': '../../JS/jquery.uploadify-v2.1.0/cancel.png',
	            'folder': '../../FileUpload/',
	            'queueID': 'MutifileArea',
	            'fileSizeLimit ': '51200KB',
	            'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
	            'width': '100',
	            'height': '32',
	            'buttonText': '',
	            'auto': false,
	            'multi': true,
	            'queueSizeLimit': '10',
	            'fileExt': '*.rar;*.zip;*.7z;*.iso;*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.txt;*.wps;*.pdf;*.jpg;*.jpeg;*.png;*.gif',
	            'fileDesc': '选择图片，小于50M',
	            'onComplete': function (e, queueId, fileObj, response) {
	                $html = "";
	                $html += "<div class='UploadImgInfo'>";
	                $html += "<span class='info'><span class='oriname'>" + fileObj.name + "</span><span class='addDesc'></span>";
	                $html += "<input type='hidden' id='hidImgPath' value='" + response + "' />";
	                $html += "<input type='hidden' id='HidOriName' value='" + fileObj.name + "' />";
	                $html += "</span></div>";
	                $("#ImgQueneInfo").append($html);
	            }
	        });
	        //保存按钮
	        $("#btnSave").click(function () {
	            var $title = $("#DownTitle").val();
	            var $desc = $("#DownDesc").val();
	            var $boardID = $("#ddlDownLoad   option:selected").val();
	            var $author = $("#AuthorID").val();
	            AddDownInfo($title, $desc, $boardID, $author);
	        });
	        //清空队列
	        $("span.clearAll").click(function () {
	            $('#uploadify').uploadifyClearQueue();
	        });

	        $("#hidFlag").val("0");//初始状态，0表示没有保存数据到数据库
	    });

	    //保存附件方法
	    function AddDownFile(oriName, filePath, downID,index) {
	        $.ajax({
	            url: "../../AJAX/MutiFileUpload.ashx",
	            type: 'POST',
	            data: { FileOriName: oriName, FilePath: filePath, DownID: downID, FID: "DownFile" },//tparm,
	            dataType: "json",
	            success: function (json) {
	                if (json != null && json == "success") {
	                    $("div.UploadImgInfo").eq(index).children("span.info").children("span.addDesc").empty().append("成功");
	                }
	                else {
	                    $("div.UploadImgInfo").eq(index).children("span.info").children("span.Img_desc").append("失败");
	                }
	            }
	        })
	    }
	    //保存下载信息
	    function AddDownInfo(title, desc, boardID, author) {
	        $.ajax({
	            url: "../../AJAX/MutiFileUpload.ashx",
	            type: 'POST',
	            data: { Title: title, Desc: desc,BoardID:boardID,Author:author, FID: "DownInfo" },//tparm,
	            dataType: "json",
	            success: function (json) {
	                if (json != null && json != "error") {
	                    $("#hidDownID").val(json);
	                    if ($("#hidDownID").val() != "0") {
	                        var num = $("div[class=UploadImgInfo]").length;
	                        var downID = $("#hidDownID").val();
	                        for (var i = 0; i < num; i++) {
	                            var oriName = $("div[class=UploadImgInfo]").eq(i).find("#HidOriName").val();
	                            var filePath = $("div[class=UploadImgInfo]").eq(i).find("#hidImgPath").val();
	                            AddDownFile(oriName, filePath, downID, i);
	                        }
	                        $("#hidFlag").val("1");//数据保存到数据库标识
	                        alert("保存成功！");
	                        location.href = "DownLoadMana.aspx";
	                    }
	                }
	                else {
	                    $("#hidDownID").val("0");
	                    alert("保存出错！该标题已经存在或网络错误！");
	                }
	            }
	        })
	    }
	    function UploadButtonEvent() {
	        if ($("#hidFlag").val() == "1") {
	            $("#ImgQueneInfo").empty();
	            $("#hidFlag").val("0");
	        }
	        $('#uploadify').uploadifyUpload();
	    }
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="homePicAddBox">
        <div class="DownLoad">
            <span class="txtArea">
                <span class="downTitle">
                    标题：<input type="text" id="DownTitle" style="width:400px;"/>
                </span>
                <span class="downBoard">
                    板块：<asp:DropDownList ID="ddlDownLoad" runat="server"></asp:DropDownList>
                </span>
            </span>
            <span class="txtArea">
                <span class="Desc">描述：</span>
                <span class="DescTxt"><textarea id="DownDesc" style="width:600px;height:60px;" ></textarea></span>
                <span class="btnSave">
                    <input type="button" id="btnSave" value="保存" cursor="pointer"  style="width:60px;height:60px;"  onclick="" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" runat="server"  style="width:60px;height:60px;"  PostBackUrl="~/Admin/DownLoad/DownLoadMana.aspx" Text="取消" />
            </span>
            </span>
        </div>
        <div class="btnArea_homePic">
            <span class="btnSelectArea">
                <input type="file" name="uploadify" id="uploadify" />
                <span class="clearAll">清空上传队列</span>
            </span>
            <span class="btnArea">
                <input type="button" id="btnUpload" value="上传" cursor="pointer"  onclick="javascript: UploadButtonEvent();" />
            </span>
        </div>
        <div class="ImgQueneArea">
            <div id="MutifileArea" ></div>
        </div>
        <div id="ImgQueneInfo" class="ImgQueneInfo">
            
        </div>
    </div>
        <input type="hidden" id="hidFlag" value="" />
        <asp:HiddenField ID="hidDownID" runat="server" Value="" />
        <asp:HiddenField ID="AuthorID" runat="server" Value="" />
    </form>
</body>
</html>
