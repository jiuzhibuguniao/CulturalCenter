<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartShowMana.aspx.cs" Inherits="CulturalCenter.Admin.Attach.DepartShowMana" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--单位详情</title>
    <link href="../../CSS/DepartNews.css" rel="stylesheet" />
    <script src="../../JS/jquery-1.7.1.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align:left;margin:0px auto; width:960px;">
            <input id="Save" type="button" value="保存设置" />
        </div>
        <div  style="margin:0px auto;width:960px;">
            <ul style="height:20px;color:#1d7229;font-weight:bolder;background-color:#eef5ef;" class="departDataul" >
                    <li class="departDatatitle WidthOneHalf" >图片</li>
                    <li class="departDatatitle WidthTwoHalf">单位名称</li>
                    <li class="departDatatitle WidthTwoHalf">单位负责人</li>
                    <li class="departDatatitle WidthTwoHalf">单位地址</li>
                    <li class="">操作</li>
                </ul>
        </div>
    <div id="departData" style="margin:0px auto;padding:0px;  width:960px;">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <ul class="departDataul"  id='<%#Eval("DepartID") %>'>
                    <li class="departData WidthOneHalf" ><img src='<%#"../../Image/DepartPhoto/"+(Eval("PicURL")==null?"default.gif":Eval("PicURL").ToString()==""?"default.gif":Eval("PicURL")) %>' alt='<%#Eval("DepartName") %>'/></li>
                    <li class="departData WidthTwoHalf"><%#Eval("DepartName") %></li>
                    <li class="departData WidthTwoHalf"><%#Eval("MainCharge") %></li>
                    <li class="departData WidthTwoHalf"><%#Eval("Address") %></li>
                    <li class="SpanDownUp">
                        <span > <img src="../../Image/Admin/up.png" alt='上移' /></span>
                        <span > <img src="../../Image/Admin/down.png" alt='下移'/></span>
                    </li>
                </ul>
            </ItemTemplate>
        </asp:Repeater>
    </div>
        
        <script type="text/javascript">
            $(document).ready(function () {
                $("#departData").children("ul").mouseover(function () {
                    $(this).css("background-color", "#F3FBF2");
                }).mouseout(function () {
                    $(this).css("background-color", "#FFFFFF");
                })
                $("#departData img[alt='上移']").bind({
                    click: function () {
                        var $parentUl = $(this).parent().parent().parent("ul");
                        $parentUl.prev().before($parentUl);
                    }
                });
                $("#departData img[alt='下移']").bind({
                    click: function () {
                        var $parentUl = $(this).parent().parent().parent("ul");
                        $parentUl.next().after($parentUl);
                    }
                });
                //保存按钮
                $("#Save").click(function () {
                    var $ShowQueue = "";
                    var $HideQueue = "";
                    var $dataLength = $("#departData").children("ul").length;
                    if ($dataLength > 7) {
                        for (var i = 0; i < 7; i++) {
                            $ShowQueue = $ShowQueue + "|" + $("#departData").children("ul").eq(i).attr("id");
                        }
                        for (var j = 7; j < $dataLength; j++) {
                            $HideQueue = $HideQueue + "|" + $("#departData").children("ul").eq(j).attr("id");
                        }
                    }
                    else {
                        for (var i = 0; i < $dataLength; i++) {
                            $ShowQueue = $ShowQueue + "|" + $("#departData").children("ul").eq(i).attr("id");
                        }
                    }
                    SortData($ShowQueue,$HideQueue);
                });
            });

            function SortData(ShowQueue, HideQueue) {
                $.ajax({
                    url: "../../AJAX/DepartMana.ashx",
                    type: 'POST',
                    data: { SHOW: ShowQueue, HIDE: HideQueue },//tparm,
                    dataType: "html",
                    success: function (data, textStatus) {
                        if (data != null) {
                            if (data == "Success") {
                                alert("保存成功！");
                            }
                            else if (data == "Failed") {
                                alert("保存失败！");
                            }
                        }
                        else {
                            alert("保存失败！");
                        }
                    }
                })
            }
        </script>
    </form>
</body>
</html>
