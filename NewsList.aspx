<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsList.aspx.cs" Inherits="CulturalCenter.NewsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible"/>
    <meta http-equiv="Content-language" content="zh-cn"/>
    <title>华中休闲文化研究中心--<%=ParentBName %></title>
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
               SetBoardListStyle($("#boardIDInfo").val());
               InitTotal($("#boardInfoNum").val(), $pageSize);
               WriteAllIndex(1, $maxIndex, $Total);
               BindNewsInfo(1, $pageSize, $("#boardIDInfo").val());
        });

        function SetBoardListStyle(boardID)
        {
            $("span.boardList").css("border-bottom", "0px solid #7ebb65");
            $("span[id=" + boardID + "]").css("border-bottom", "6px solid #7ebb65");
            $("p.loca").empty().html($("span[id=" + boardID + "]").html());
        }

        //绑定新闻方法
        function BindNewsInfo(index,pageSize, boardID) {
            var paraindex = index;//jQuery.toJSON(index);
            var paraBID = boardID;//jQuery.toJSON(boardID);
            var paraSize = pageSize;//jQuery.toJSON(pageSize);
            $.ajax({
                url: "../AJAX/NewsList.ashx",
                type: 'POST',
                data: { Index: paraindex, BoardID: paraBID,PageSize:paraSize,FID:"NL" },//tparm,
                dataType: "json",
                success: function (json) {
                    if (json != null) {
                        $("#NewsListBox ul").empty();
                            var jsonLength = 0;
                            for (var item in json.Info) {
                                jsonLength++;
                            }
                            var $html="";
                            for (var i = 0; i < jsonLength; i++) {
                                $html += "<li>";
                                $html += "<span class='NewsImg'><img src='Image/News/" + (json.Info[i].PicURL1 == "undefine" ? "default.gif" : json.Info[i].PicURL1 == "" ? "default.gif" : json.Info[i].PicURL1) + "' /></span><span class='NewsInfo'>";
                                $html += "<span class='titleInfo'><span class='pubTime'>[" + json.Info[i].PubTime + "]</span>";
                                $html += "<span class='title'  style='max-width:500px;overflow:hidden;height:14px;'><a href='NewsDetails.aspx?id=" + json.Info[i].InfoID + "' title='" + json.Info[i].Title + "'  target='_blank'>" + json.Info[i].Title + "</a></span>";
                                $html += "<span class='NewsDetailsLink'><a href='NewsDetails.aspx?id=" + json.Info[i].InfoID + "'   target='_blank'>详细>></a></span></span>";
                                $html += "<code class='NewsContent'>" + json.Info[i].Content + "</code></span>";
                                $html += "</li>";
                            }
                            $($html).appendTo("#NewsListBox ul");
                            //$("#NewsListBox ul").html(html);
                            $("#NewsListBox ul li").mouseover(function () {
                                $(this).css("background-color", "#edfed1");
                            }).mouseout(function () {
                                $(this).css("background-color", "#FFFFFF");
                            });
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
                        <p class="locaP"><%=ParentBName %>>></p>
                        <p class="loca"></p>
                    </div>
                <div id="BoardListBox" class="BoardListBox">
                    <asp:HiddenField ID="boardInfoNum"  runat="server" />
                    <asp:HiddenField ID="boardIDInfo"  runat="server" />
                    <span id="TopBoard">『<%=ParentBName %>』</span>
                    <asp:Repeater ID="repBoardList" runat="server">
                        <ItemTemplate>
                            <span class="boardList" id='<%#Eval("BoardID") %>'><%#Eval("BoardName") %></span><span class="HiddenInfo"><%#Eval("BoardID") %></span>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div id="NewsListBox" class="NewsListBox">
                    <ul>
                        <asp:Repeater ID="repNewsList" runat="server">
                            <ItemTemplate>
                                <li>
                                    <span class="NewsImg"><img alt="" src='<%#"Image/News/"+(Eval("PicURL1")==null?"default.gif":Eval("PicURL1").ToString()==""?"default.gif":Eval("PicURL1")) %>' /></span>
                                    <span class="NewsInfo">
                                        <span class="titleInfo">
                                            <span class="pubTime"><%#"["+Eval("PubTime")+"]" %></span>
                                            <span class="title" style="max-width:500px;overflow:hidden;"><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>' title='<%#Eval("Title")%>' target="_blank"><%#Eval("Title")==null?"":Eval("Title").ToString().Length>23?Eval("Title").ToString().Trim().Substring(0,22)+"…":Eval("Title").ToString().Trim()%></a></span>
                                            <span class="NewsDetailsLink"><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank">详细>></a></span>
                                        </span>
                                        <code class="NewsContent"><%# Eval("Content")==null?"":Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()).Length>250?Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()).Trim().Substring(0,249)+"…":Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()).Trim()%></code>
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