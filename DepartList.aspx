<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartList.aspx.cs" Inherits="CulturalCenter.DepartList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible"/>
    <meta http-equiv="Content-language" content="zh-cn"/>
    <title>华中休闲文化研究中心--合作单位</title>
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
            $("span.VboardList").click(function () {
                SetBoardListStyle($(this).attr("id"));
                BindNewsInfo(1, $pageSize, $(this).attr("id"));
                $("#boardIDInfo").val($(this).attr("id"));
            }).mouseover(function () {
                $(this).css("background","#CCFF99");
            }).mouseout(function () {
                $(this).css("background", "#FFFFFF");
            });
            SetBoardListStyle($("#boardIDInfo").val());
            InitTotal($("#boardInfoNum").val(), $pageSize);
            WriteAllIndex(1, $maxIndex, $Total);
            BindNewsInfo(1, $pageSize, $("#boardIDInfo").val());
        });

        //绑定新闻方法
        function BindNewsInfo(index, pageSize, boardID) {
            var paraindex = index;//jQuery.toJSON(index);
            var paraBID = boardID;//jQuery.toJSON(boardID);
            var paraSize = pageSize;//jQuery.toJSON(pageSize);
            $.ajax({
                url: "../AJAX/DepartList.ashx",
                type: 'POST',
                data: { Index: paraindex, BoardID: paraBID, PageSize: paraSize, FID: "DL" },//tparm,
                dataType: "json",
                success: function (json) {
                    if (json != null) {
                        $("#art_content ul").empty();
                        var jsonLength = 0;
                        for (var item in json.DepartList) {
                            jsonLength++;
                        }
                        var $html = "";
                        for (var i = 0; i < jsonLength; i++) {
                            $html += "<li>";
                            $html += "<table><tr><td colspan='2' class='departName'>"+json.DepartList[i].DepartName+"</td></tr>";
                            $html += "<tr><td class='departImg'><img  src='Image/DepartPhoto/"+(json.DepartList[i].PicURL=="undefined"?"default.gif":json.DepartList[i].PicURL==""?"default.gif":json.DepartList[i].PicURL)+"' /></td>";
                            $html +="<td class='departInfo'>";
                            $html +="<span>负 责 人：</span><span class='departData'>"+json.DepartList[i].MainCharge+"</span>";
                            $html += "<span>联系方式：</span><span class='departData'>" + json.DepartList[i].Phone + "</span>";
                            $html += "<span>单位地址：</span><span class='departData'>" + json.DepartList[i].Address + "</span>";
                            $html += "</td></tr><tr><td colspan='2' class='departDescrib'>" + json.DepartList[i].Describ + "</td></tr></table>";
                            $html += "</li>";
                        }
                        $($html).appendTo("#art_content ul");
                        InitTotal(json.TotalNum, $pageSize);
                        WriteAllIndex(index, $maxIndex, $Total);
                    }
                    else {
                        //$("#result").html("失败");
                        alert("Error!");
                    }
                }
            })
        }

        function SetBoardListStyle(boardID) {
            $("span.VboardList").css({"border-left": "0px solid #7ebb65","width":"99%"});
            $("span[id=" + boardID + "]").css({"border-left":"6px solid #7ebb65","width":"97%"});
            $("p.loca").empty().html(">>"+$("span[id=" + boardID + "]").html());
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
            <div id="ContentBox" class="box">
                <div class="leftContent">
                    <%--板块标签--%>
                    <div id="BoardTag" class="BoardTag">
                        <div class="depart_title">▓合作单位</div>
                        <div id="VBoardListBox" class="VBoardListBox">
                            <asp:HiddenField ID="boardInfoNum"  runat="server" />
                            <asp:HiddenField ID="boardIDInfo"  runat="server" />
                            <asp:Repeater ID="repBoardList" runat="server">
                                <ItemTemplate>
                                    <span class="VboardList" id='<%#Eval("BoardID") %>'><%#Eval("BoardName") %></span>
                                </ItemTemplate>
                            </asp:Repeater>
                     </div>
                    </div>
                     <%--公告--%>
                    <div id="Announce" class="Announce">
                        <div class="annou_title">
                            <div class="title_info title_anno"><p>┃公告</p><a href="NewsList.aspx?BName=公告"><span class="title_more">更多>></span></a></div>
                        </div>
                        <div>
                            <ul>
                                <asp:Repeater ID="repAnnounce" runat="server">
                                    <ItemTemplate>
                                         <li><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>' title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>12?Eval("Title").ToString().Trim().Substring(0,11)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                    </div>
                    <%--闲情偶寄--%>
                    <div id="RelaxInfo" class="RelaxInfo">
                         <div class="annou_title">
                    <div class="title_info title_RelaxInfo"><p>┃闲情偶寄</p><a href="NewsList.aspx?BName=闲情偶寄"><span class="title_more">更多>></span></a></div>
                </div>
                        <div>
                            <ul>
                                <asp:Repeater ID="repRelaxInfo" runat="server">
                                    <ItemTemplate>
                                            <li><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>' title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>12?Eval("Title").ToString().Trim().Substring(0,11)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="rightContent">
                    <div class="location">
                        <p>当前位置：</p>
                        <p><a href="Default.aspx">首页</a> >> </p>
                        <p class="locaP"><a href="DepartList.aspx?BName=合作单位">合作单位</a></p>
                        <p class="loca"></p>
                    </div>
                    <div class="News">
                        <div class="infoContent">
                            <div id="art_content" class="depart_content">
                                <ul>
                                    <asp:Repeater ID="repDepartList" runat="server">
                                        <ItemTemplate>
                                        <li>
                                            <table>
                                                <tr><td colspan="2" class="departName"><%#Eval("DepartName") %></td></tr>
                                                <tr><td class="departImg"><img alt="" src='<%#"Image/DepartPhoto/"+(Eval("PicURL")==null?"default.gif":Eval("PicURL").ToString()==""?"default.gif":Eval("PicURL")) %>' /></td>
                                                    <td class="departInfo">
                                                        <span>负 责 人：</span><span class="departData"><%#Eval("MainCharge") %></span>
                                                        <span>联系方式：</span><span class="departData"><%#Eval("Phone") %></span>
                                                        <span>单位地址：</span><span class="departData"><%#Eval("Address") %></span>
                                                    </td>
                                                </tr>
                                                <tr><td colspan="2" class="departDescrib"><%#Eval("Describ") %></td></tr>
                                            </table>
                                        </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                        <div id="PageIndexInfo" class="PageIndexInfo">
                            <span class="pageindex">&nbsp;&nbsp;共<span id="total" title=""></span>页</span>
                            <span id="pageindex" class="pageindex">nbvnbv</span>
                            <span id="index" style="visibility:hidden;" title="1"></span>
                        </div>
                    </div>
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