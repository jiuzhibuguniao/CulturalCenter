<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePicAdd.aspx.cs" Inherits="CulturalCenter.Admin.News.HomePicAdd" %>

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
	            'folder': '../../Image/News/',
	            'queueID': 'MutifileArea',
	            'fileSizeLimit ': '5120KB',
	            'buttonImg': '../../JS/jquery.uploadify-v2.1.0/uplodify_btn.png',
	            'width': '100',
	            'height': '32',
	            'buttonText': '',
	            'auto': false,
	            'multi': true,
	            'queueSizeLimit':'10',
	            'fileExt': '*.jpg;*.jpeg;*.png;*.gif',
	            'fileDesc': '选择图片，小于5M',
	            'onComplete': function (e, queueId, fileObj, response) {
	                $html = "";
	                $html+="<div class='UploadImgInfo'>";
	                $html+="<span class='img'><img src='../../Image/News/"+response+"' alt='上传成功' /></span>";
	                $html+= "<span class='info'><span class='oriname'>" + fileObj.name + "</span><span class='addDesc'>添加描述</span>";
	                $html += "<span class='Img_desc'><input type='text' id='Desc" + queueId + "' style='width:360px;'/></span>";
	                $html+="<input type='hidden' id='hidImgPath" + queueId + "' value='" + response + "' />";
	                $html+="<input type='hidden' id='HidOriName' value='"+fileObj.name+"' />"; 
	                $html += "</span></div>";
	                $("#ImgQueneInfo").append($html);
	            },
                'onAllComplete':function(){
                    $("span.addDesc").click(function () {
                        $(this).next("span.Img_desc").css("display","block");
                    });
                }
	        });
            //保存按钮
	        $("#btnSave").click(function () {
	            var num = $("div[class=UploadImgInfo]").length;
	            for (var i = 0; i < num; i++){
	                var imgDesc = $("div[class=UploadImgInfo]").eq(i).find("span.Img_desc").children("input").val();
	                var imgURL = $("div[class=UploadImgInfo]").eq(i).children("span.info").children("input").eq(0).val();
	                AddPicInfo(imgDesc, imgURL, i);
	            }
	            $("#hidFlag").val("1");//数据保存到数据库标识
	        });
            //清空队列
	        $("span.clearAll").click(function () {
	            $('#uploadify').uploadifyClearQueue();
	        });
            
	        $("#hidFlag").val("0");//初始状态，0表示没有保存数据到数据库
	    });

	    //绑定新闻方法
	    function AddPicInfo(imgDesc,imgURL,index) {
	        $.ajax({
	            url: "../../AJAX/MutiFileUpload.ashx",
	            type: 'POST',
	            data: { ImgDesc: imgDesc,ImgURL:imgURL, FID: "HomePic" },//tparm,
	            dataType: "json",
	            success: function (json) {
	                if (json != null && json=="success") {
	                    $("div.UploadImgInfo").eq(index).children("span.info").children("span.addDesc").empty().append("成功");
	                }
	                else {
	                    $("div.UploadImgInfo").eq(index).children("span.info").children("span.Img_desc").append("失败");
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
        <div class="btnArea_homePic">
            <span class="btnSelectArea">
                <input type="file" name="uploadify" id="uploadify" />
                <span class="clearAll">清空上传队列</span>
            </span>
            <span class="btnArea">
                <input type="button" id="btnUpload" value="上传" cursor="pointer" onclick="javascript: UploadButtonEvent();" />
            </span>
            <span class="btnArea">
                <input type="button" id="btnSave" value="保存" cursor="pointer" onclick="" />
            </span>
            <span class="btnArea">
                <asp:Button ID="btnCancel" runat="server" PostBackUrl="~/Admin/News/HomePicMana.aspx" Text="取消" />
                </span>
        </div>
        <div class="ImgQueneArea">
            <div id="MutifileArea" ></div>
        </div>
        <div id="ImgQueneInfo" class="ImgQueneInfo">
            
        </div>
    </div>
        <input type="hidden" id="hidFlag" value="" />
    </form>
</body>
</html>
