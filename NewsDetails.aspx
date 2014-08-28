﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsDetails.aspx.cs" Inherits="CulturalCenter.NewsDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible"/>
    <meta http-equiv="Content-language" content="zh-cn"/>
    <title>华中休闲文化研究中心--详细</title>
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
            BindNewsInfo($("#InfoID").val());
        });

        //绑定新闻方法
        function BindNewsInfo(infoID) {
            $.ajax({
                url: "../AJAX/NewsList.ashx",
                type: 'POST',
                data: { InfoID: infoID, FID: "ND" },//tparm,
                dataType: "json",
                success: function (json) {
                    if (json != null) {
                        $("p.locaP").empty().html("<a href='NewsList.aspx?BName=" + json.BoardName + "'>" + json.BoardName + "</a>");
                        $("p.loca").empty().html(json.BName==undefined?"":json.BName==""?"":(">> "+json.BName));
                        $("#art_title").empty().html("<h2>" + json.Info[0].Title + "</h2>");
                        $("span.data").eq(0).empty().html(json.Author)
                        $("span.data").eq(1).empty().html(json.Info[0].PubTime)
                        $("span.data").eq(2).empty().html(json.Info[0].ReadNum);
                        $("#art_content").empty().html(json.Info[0].Content);
                        if (json.Info[0].PicURL1 != null && json.Info[0].PicURL1 != "") {
                            $("span.art_img").empty().html("<img id='artImg' src='Image/News/" + json.Info[0].PicURL1 + "' width='400'  />");
                        }
                        $("span.art_att").empty().html("<a href='FileUpload/" + json.Info[0].AccURL1 + "' target='_blank'>" + json.Info[0].AccName1 + "</a>");
                    }
                    else {
                        //$("#result").html("失败");
                        alert("网络错误!");
                    }
                }
            })
        }
    </script>
</head>
<body >
    <form id="form1" runat="server">
        <uco:Header ID="UHeader" runat="server" />
        <div id="box" class="box">
            <%--新闻列表--%>
            <div id="ContentBox" class="box">
                <div class="leftContent">
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
                        <p class="locaP"><a href="NewsList.aspx"></a></p>
                        <p class="loca"></p>
                    </div>
                    <div class="News">
                        <asp:HiddenField runat="server" ID="InfoID" />
                        <div id="art_title" class="art_title"><h2></h2></div>
                        <div class="art_info">
                            <div class="art_infobox">
                            <span class="desc">来源：</span><span class="data"></span>
                            <span class="desc">发布时间：</span><span  class="data"></span>
                            <span class="desc">阅读次数：</span><span class="data"></span><span >次</span>
                            </div>
                        </div>
                        <div class="infoContent">
                            <span class="art_img">
                            
                            </span>
                        <code id="art_content" class="art_content">
                            
                        </code>
                            <span class="art_attachBox">
                                <span class="art_wz">
                                    附件：
                                </span>
                                <span class="art_att">
                                    <a href="" title="" target="_blank"></a>
                                </span>
                            </span>
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