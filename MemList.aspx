<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemList.aspx.cs" Inherits="CulturalCenter.MemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible"/>
    <meta http-equiv="Content-language" content="zh-cn"/>
    <title>华中休闲文化研究中心--专家队伍</title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <link href="CSS/Mainpage.css" rel="stylesheet" type="text/css" />
    <script src="JS/jquery-1.7.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        
    #nav_content ul li  a:link {
        color: #FFFFFF;
    }
    #nav_content ul li  a:visited {
        color: #FFFFFF;
    }
    #nav_content ul li a:hover {
        color: #FF6600;
    }
    #nav_content ul li a:active {
        color: #FFFFFF;
    }
    </style>
    <script type="text/javascript">
        var $index = $("span[id=index]").attr("title") * 1;//当前页
        var $Total = 0;//总页数
        var $pageIndex = $("span[id=pageindex]");
        var $pageSize = 8;
        var $maxIndex = 10;
        var $NewsInfoAera = $("#NewsListBox ul");

        $(document).ready(function () {
            $("span.AddFavor").click(function () {　　　　//$里面是链接的id  
                var ctrl = (navigator.userAgent.toLowerCase()).indexOf('mac') != -1 ? 'Command/Cmd' : 'CTRL';
                if (document.all) {
                    window.external.addFavorite(document.URL, '2345')
                } else if (window.sidebar) {
                    window.sidebar.addPanel('2345', document.URL, "")
                } else {　　　　//添加收藏的快捷键  
                    alert('添加失败\n您可以尝试通过快捷键' + ctrl + ' + D 加入到收藏夹~')
                }
            });
            $("span.SethomePage").click(function () {
                if (document.all) {//设置IE  
                    document.body.style.behavior = 'url(#default#homepage)';
                    document.body.setHomePage(document.URL);
                } else if (window.sidebar) {
                    if (window.netscape) {
                        try {
                            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                        }
                        catch (e) {
                            alert("该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 'about:config' ,然后将项为signed.applets.codebase_principal_support的值改为true");
                        }
                    }
                    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                    prefs.setCharPref('browser.startup.homepage', document.URL);
                }
            });
            $("#NewsListBox ul li").mouseover(function () {
                $(this).css("background-color", "#edfed1");
            }).mouseout(function () {
                $(this).css("background-color", "#FFFFFF");
            });
            $("span.boardList").click(function () {
                SetBoardListStyle($(this).attr("id"));
                BindNewsInfo(1, $pageSize, $(this).attr("id"));
                $("#boardIDInfo").val($(this).attr("id"));
            });
            $("span.memName").mouseover(function () {
                $(this).parents("span.NewsInfo").next("span.otherInfo").fadeIn(300);//.css("display", "inline-block").fadeIn(500);//.animate({ display: "inline-block" });
            }).mouseout(function () {
                $(this).parents("span.NewsInfo").next("span.otherInfo").fadeOut(300);//.css("display", "none");//.animate({ display: "none" });
            });

            SetBoardListStyle($("#boardIDInfo").val());
            InitTotal($("#boardInfoNum").val(), $pageSize);
            WriteAllIndex(1, $maxIndex, $Total);
        });

        function SetBoardListStyle(boardID) {
            $("span.boardList").css("border-bottom", "0px solid #7ebb65");
            $("span[id=" + boardID + "]").css("border-bottom", "6px solid #7ebb65");
            $("p.loca").empty().html($("span[id=" + boardID + "]").html());
        }

        //绑定新闻方法
        function BindNewsInfo(index, pageSize, boardID) {
            var paraindex = index;//jQuery.toJSON(index);
            var paraBID = boardID;//jQuery.toJSON(boardID);
            var paraSize = pageSize;//jQuery.toJSON(pageSize);
            $.ajax({
                url: "../AJAX/memList.ashx",
                type: 'POST',
                data: { Index: paraindex, BoardID: paraBID, PageSize: paraSize },//tparm,
                dataType: "json",
                success: function (json) {
                    if (json != null) {
                        $("#NewsListBox ul").empty();
                        var jsonLength = 0;
                        for (var item in json.Vmember) {
                            jsonLength++;
                        }
                        for (var i = 0; i < jsonLength; i++) {
                            var $html = "<li>";
                            $html += "<span class='memImg'><img src='Image/Photo/" + (json.Vmember[i].PhotoURL == "undefine" ? "default.gif" : json.Vmember[i].PhotoURL == "" ? "default.gif" : json.Vmember[i].PhotoURL) + "' /></span><span class='NewsInfo'>";
                            $html += "<span class='titleInfo'><span class='memName'>" + json.Vmember[i].MembName + "</span>";
                            $html += "<span class='memJob'>" + json.Vmember[i].JobName + "</span>";
                            $html += "<span class='memDepart'>" + json.Vmember[i].DepartName + "</span></span>";
                            $html += "<code class='memResume'>" + json.Vmember[i].Resume + "</code></span>";
                            $html += "<span class='otherInfo'><span class='tag'>电话:</span><span class='otherData'>" + json.Vmember[i].Phone + "</span>";
                            $html += "<span class='tag'>邮箱:</span><span class='otherData'>" + json.Vmember[i].Email + "</span>";
                            $html += "<span class='tag'>地址:</span><span class='otherData'>" + json.Vmember[i].Address + "</span></span>";
                            $html += "</li>";
                            $($html).appendTo("#NewsListBox ul");
                        }
                        $("#NewsListBox ul li").mouseover(function () {                    
                            $(this).css("background-color", "#edfed1");
                        }).mouseout(function () {
                            $(this).css("background-color", "#FFFFFF");
                        });
                        $("span.memName").mouseover(function () {
                            $(this).parents("span.NewsInfo").next("span.otherInfo").fadeIn(300);
                        }).mouseout(function () {
                            $(this).parents("span.NewsInfo").next("span.otherInfo").fadeOut(300);
                        });    
                        InitTotal(json.Num, $pageSize);
                        WriteAllIndex(index, $maxIndex, $Total);
                    }
                    else {
                        //$("#result").html("失败");
                        alert("Error!");
                    }
                }
            })
        }

        //初始化页面总数
        function InitTotal(picNum, pageSize) {
            var quotient = Math.floor(picNum / pageSize);
            var remainder = picNum % pageSize;
            quotient = remainder != 0 ? quotient + 1 : quotient;
            $("span[id=total]").attr("title", quotient);
            $("span[id=total]").text(quotient);
            $("#boardInfoNum").val(picNum);
            $Total = quotient;
        };

        function WriteAllIndex(currentIndex, maxIndex, Total) {
            $("span[id=pageindex]").empty();

            if (currentIndex > 1) {
                $("<a href='#" + (currentIndex - 1) + "' title='" + (currentIndex - 1) + "'> 上一页</a>&nbsp;").click(function () {
                    var $click_index = $(this).attr("title") * 1;//获取当前点击的连接
                    BindNewsInfo($click_index, $pageSize, $("#boardIDInfo").val());
                    //WriteAllIndex($click_index, $maxIndex, $Total);
                    $index = $click_index;
                    $("span[id=index]").attr("title", $click_index);
                }).appendTo("span[id=pageindex]");
            }
            else {
                $("<a href='#上一页' > 上一页</a>&nbsp;").appendTo("span[id=pageindex]");
            }
            if (currentIndex == 1) {
                if (Total > 10) {
                    for (var i = 1; i < 11; i++) {
                        WriteIndex(i, currentIndex);
                    }
                }
                else {
                    for (var i = 1; i <= Total; i++) {
                        WriteIndex(i, currentIndex);
                    }

                }
                $maxIndex = 10;
            }
            else if (currentIndex % 5 == 0) {
                if (Total - currentIndex > 5) {
                    for (var i = currentIndex - 5 > 0 ? currentIndex - 5 : 1; i <= currentIndex + 5; i++) {
                        WriteIndex(i, currentIndex);
                    }
                }
                else {
                    for (var i = currentIndex - 5 > 0 ? currentIndex - 5 : 1; i <= Total; i++) {
                        WriteIndex(i, currentIndex);
                    }
                }
                $maxIndex = currentIndex + 5;
            }
            else if (currentIndex % 5 != 0) {
                if (Total > maxIndex) {
                    for (var i = maxIndex - 10 == 0 ? 1 : maxIndex - 10; i <= maxIndex; i++) {
                        WriteIndex(i, currentIndex);
                    }
                }
                else {
                    for (var i = maxIndex - 10 == 0 ? 1 : maxIndex - 10; i <= Total; i++) {
                        WriteIndex(i, currentIndex);
                    }
                }
            }
            if (currentIndex < Total) {
                $("<a href='#" + (currentIndex + 1) + "' title='" + (currentIndex + 1) + "'> 下一页</a>&nbsp;").click(function () {
                    var $click_index = $(this).attr("title") * 1;//获取当前点击的连接
                    BindNewsInfo($click_index, $pageSize, $("#boardIDInfo").val());
                    //WriteAllIndex($click_index, $maxIndex, $Total);
                    $index = $click_index;
                    $("span[id=index]").attr("title", $click_index);
                }).appendTo("span[id=pageindex]");
            }
            else {
                $("<a href='#下一页' > 下一页</a>&nbsp;").appendTo("span[id=pageindex]");
            }

        }
        function WriteIndex(i, currentIndex) {
            if (i == currentIndex) {
                $("<a class='selectIndex' href='#" + i + "' title='" + i + "'>" + i + "</a>&nbsp;").click(function () {
                    var $click_index = $(this).attr("title") * 1;//获取当前点击的连接
                    BindNewsInfo($click_index, $pageSize, $("#boardIDInfo").val());
                    //WriteAllIndex($click_index, $maxIndex, $Total);
                    $index = $click_index;
                    $("span[id=index]").attr("title", $click_index);
                }).appendTo("span[id=pageindex]");
            }
            else {
                $("<a  href='#" + i + "' title='" + i + "'>" + i + "</a>&nbsp;").click(function () {
                    var $click_index = $(this).attr("title") * 1;//获取当前点击的连接
                    BindNewsInfo($click_index, $pageSize, $("#boardIDInfo").val());
                    //WriteAllIndex($click_index, $maxIndex, $Total);
                    $index = $click_index;
                    $("span[id=index]").attr("title", $click_index);
                }).appendTo("span[id=pageindex]");
            }
        }
        function WriteEndIndex() {
            $("...<a  href=\"#" + Total.ToString() + "\">" + Total.ToString() + "</a>&nbsp").appendTo("span[id=pageindex]");
        }
    </script>
</head>
<body >
    <form id="form1" runat="server">
        <uco:Header ID="Uheader" runat="server" />
        <div id="box" class="box">
            <%--新闻列表--%>
            <div id="ContentBox" class="ContentBox">
                <div class="location">
                        <p>当前位置：</p>
                        <p><a href="Default.aspx">首页</a> >> </p>
                        <p class="locaP">专家队伍 >></p>
                        <p class="loca"></p>
                    </div>
                <div id="BoardListBox" class="BoardListBox">
                    <asp:HiddenField ID="boardInfoNum"  runat="server" />
                    <asp:HiddenField ID="boardIDInfo"  runat="server" />
                    <span id="TopBoard">『专家队伍』</span>
                    <span class="boardList" id="leader">中心领导</span>
                    <span class="boardList" id="expert">中心专家</span>
                </div>
                <div id="NewsListBox" class="NewsListBox">
                    <ul>
                        <asp:Repeater ID="repNewsList" runat="server">
                            <ItemTemplate>
                                <li>
                                    <span class="memImg"><img alt="" src='<%#"Image/Photo/"+(Eval("PhotoURL")==null?"default.gif":Eval("PhotoURL").ToString()==""?"default.gif":Eval("PhotoURL")) %>' /></span>
                                    <span class="NewsInfo">
                                        <span class="titleInfo">
                                            <span class="memName"><%#Eval("MembName")%></span>
                                            <span class="memJob"><%#Eval("JobName")%></span>
                                            <span class="memDepart"><%#GetDepartNameByID(Eval("DepartID"))%></span>
                                        </span>
                                        <code class="memResume"><%# Eval("Resume")%></code>
                                    </span>
                                    <span class="otherInfo">
                                        <span class="tag">电话:</span><span class="otherData"><%#Eval("Phone")%></span>
                                        <span class="tag">邮箱:</span><span class="otherData"><%#Eval("Email")%></span>
                                        <span class="tag">地址:</span><span class="otherData"><%#Eval("Address")%></span>
                                    </span>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div id="PageIndexInfo" class="PageIndexInfo">
                    <span class="pageindex">&nbsp;&nbsp;共<span id="total" title=""></span>页</span>
                    <span id="pageindex" class="pageindex">nbvnbv</span>
                    <span id="index" style="visibility:hidden;" title="1"></span>
                </div>
            </div>
            
            <hr style="border:1px solid #DFDCD5;float:left;width:100%;"/>
            <div class="footer">
                Copyright © 2013  华中休闲文化研究中心 技术支持:阳光Team<br />
                地址：湖北省黄石理工　邮编：310028　电话：0571－88273948  E-mail:apcl@zju.edu.cn 
            </div>
        </div>
    </form>
</body>
</html>