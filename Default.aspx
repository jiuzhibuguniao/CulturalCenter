<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CulturalCenter._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
    <meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible"/>
    <meta http-equiv="Content-language" content="zh-cn"/>
    <title>华中休闲文化研究中心欢迎您！</title>
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <link href="CSS/Mainpage.css" rel="stylesheet" type="text/css" />
    <%--<link href="CSS/example.css" rel="stylesheet"  type="text/css"  />--%>
    <link href="CSS/font-awesome.min.css" rel="stylesheet"  type="text/css" />
    <script src="JS/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="JS/jquery.slides.min.js" type="text/javascript"></script>
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

        function slides() {
            $('#ImageAera').slidesjs({
                width: 420,
                height: 260,
                navigation: false,
                preload: true,
                preloadImage: 'image/web/default.gif',
                play: {
                    active: true,
                    auto: true,
                    interval: 3000,
                    swap: true
                },
                callback: {
                    start: function (number) {
                        // Do something awesome!
                        // Passes slide number at start of animation
                    }
                }
            });
        }
        $(document).ready(function () {
            slides();
            
            $("#ImageAera .slidesjs-slide").unbind().mouseover(function () {
                $(this).children("p").css("opacity", "0.6")
                                     .mouseover(function () {
                                     $(this).css("opacity", "0.6")});
            }).mouseout(function () {
                $(this).children("p").css("opacity", "0.1");
                $(this).prevAll().children("p").css("opacity", "0.1");
                $(this).nextAll().children("p").css("opacity", "0.1");
            });
            $("#ImageAera ul").mouseover(function () {
                $("#ImageAera .slidesjs-slide").children("p").css("opacity", "0.6");
            }).mouseout(function () {
                $("#ImageAera .slidesjs-slide").children("p").css("opacity", "0.1");
            }).children("li").click(function () {
                $('a[title=Play]').get(0).click(); //alert("click");
            });
            
            $("span.AddFavor").click(function () {　　　　//$里面是链接的id  
                var ctrl = (navigator.userAgent.toLowerCase()).indexOf('mac') != -1 ? 'Command/Cmd' : 'CTRL';
                if (document.all) {
                    window.external.addFavorite('http://www.2345.com/j.htm?fg', '2345')
                } else if (window.sidebar) {
                    window.sidebar.addPanel('2345', 'http://www.2345.com/j.htm?fg', "")
                } else {　　　　//添加收藏的快捷键  
                    alert('添加失败\n您可以尝试通过快捷键' + ctrl + ' + D 加入到收藏夹~')
                }
            });
            $("span.SethomePage").click(function () {
                if (document.all) {//设置IE  
                    document.body.style.behavior = 'url(#default#homepage)';
                    document.body.setHomePage(document.URL);
                } else  if (window.sidebar){ 
                    if (window.netscape){ 
                        try { 
                            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); }
                        catch (e) { 
                            alert("该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 'about:config' ,然后将项为signed.applets.codebase_principal_support的值改为true"); 
                        } } 
                    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
                    prefs.setCharPref('browser.startup.homepage', 'http://www.2345.com/j.htm?fg'); 
                }
            })
        });

        function AutoScroll() {
            var _scroll = $("#PartnerScroll>ul");
            //ul往左边移动300px
            _scroll.animate({ marginLeft: "-140px" }, 1000, function () {
                //把第一个li丢最后面去
                _scroll.css({ marginLeft: 0 }).find("li:first").css("display", "none").appendTo(_scroll);
                _scroll.find("li:last").fadeIn(500);
            });
        }
        $(function () {
            //两秒后调用
            var _scrolling = setInterval("AutoScroll()", 3000);
            $("#PartnerScroll>ul").hover(function () {
                //鼠标移动DIV上停止
                clearInterval(_scrolling);
            }, function () {
                //离开继续调用
                _scrolling = setInterval("AutoScroll()", 3000);
            });
        });
    </script>
</head>
<body >
    <form id="form1" runat="server">
        <uco:Header ID="Uheader" runat="server" />
        <div id="box" class="box">
            <%--图片展示--%>
            <div id="ImageAera" class="ImageAera">
                <asp:Repeater runat="server" ID="repImgShow">
                    <ItemTemplate>
                        <div>
                            <img src='<%#Maticsoft.Common.CommonFun.URLConverToServer("Image/News/"+Eval("ImgURL"))%>' alt="" />
                            <p><%#Eval("ImgDesc")==null?"":Eval("ImgDesc").ToString().Length>25?(Eval("ImgDesc").ToString().Substring(0,24)+"…"):Eval("ImgDesc").ToString()%></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <%--中心动态--%>
            <div id="CenterNews" class="CenterNews">
                <div class="annou_title">
                    <div class="title_info title_CenterNews"><p>┃中心动态</p><a href="NewsList.aspx?BName=中心动态" target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div>
                    <ul>
                    <asp:Repeater ID="repCenterNews" runat="server">
                        <ItemTemplate>
                                    <li><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank" title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>23?Eval("Title").ToString().Trim().Substring(0,22)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                            </ItemTemplate>
                    </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--公告--%>
            <div id="Announce" class="Announce">
                <div class="annou_title">
                    <div class="title_info title_anno"><p>┃公告</p><a href="NewsList.aspx?BName=公告"  target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div>
                    <ul>
                        <asp:Repeater ID="repAnnounce" runat="server">
                            <ItemTemplate>
                                 <li><a  href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank" title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>12?Eval("Title").ToString().Trim().Substring(0,11)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--业界资讯--%>
            <div id="FieldInfo" class="FieldInfo">
                <div class="annou_title">
                    <div class="title_info title_FieldInfo"><p>┃业界资讯</p><a href="NewsList.aspx?BName=业界资讯" target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div>
                    <ul>
                    <asp:Repeater ID="repFieldInfo" runat="server">
                        <ItemTemplate>
                                    <li><a  href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank" title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>22?Eval("Title").ToString().Trim().Substring(0,21)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                            </ItemTemplate>
                    </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--培训信息--%>
            <div id="TrainInfo" class="TrainInfo">
                <div class="annou_title">
                    <div class="title_info title_TrainInfo"><p>┃服务社会</p><a href="NewsList.aspx?BName=服务社会" target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div>
                    <ul>
                        <asp:Repeater ID="repTrainInfo" runat="server">
                            <ItemTemplate>
                                    <li><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank"title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>22?Eval("Title").ToString().Trim().Substring(0,21)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--闲情偶寄--%>
            <div id="RelaxInfo" class="RelaxInfo">
                <div class="annou_title">
                    <div class="title_info title_RelaxInfo"><p>┃闲情偶寄</p><a href="NewsList.aspx?BName=闲情偶寄" target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div>
                    <ul>
                        <asp:Repeater ID="repRelaxInfo" runat="server">
                            <ItemTemplate>
                                    <li><a href='NewsDetails.aspx?id=<%#Eval("InfoID")%>'  target="_blank"title='<%#Eval("Title")%>'><%#Eval("Title")==null?"":Eval("Title").ToString().Length>12?Eval("Title").ToString().Trim().Substring(0,11)+"…":Eval("Title").ToString().Trim()%></a><span><%#Eval("PubTime").ToString().Substring(5,5)%></span></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--合作单位--%>
            <div id="Partner" class="Partner">
                <div class="annou_title">
                    <div class="title_info title_Partner"><p>┃合作单位</p><a href="DepartList.aspx?BName=合作单位" target="_blank"><span class="title_more">更多>></span></a></div>
                </div>
                <div id="PartnerScroll" class="PartnerScroll" >
                    <ul>
                    <asp:Repeater ID="repPartner" runat="server">
                        <ItemTemplate>
                                    <li>
                                        <a href="DepartList.aspx?BName=合作单位" title='<%#Eval("DepartName") %>' class="PartnerImgBox"><asp:Image runat="server" ImageUrl='<%#"Image/DepartPhoto/"+(Eval("PicURL")==null?"default.gif":Eval("PicURL").ToString()==""?"default.gif":Eval("PicURL"))%>'/></a>
                                        <a href="DepartList.aspx?BName=合作单位" title='<%#Eval("DepartName") %>'>
                                            <span><%#Eval("DepartName") %></span></a>
                                            <%#Eval("Describ")==null?"":Eval("Describ").ToString().Length>28?Eval("Describ").ToString().Trim().Substring(0,27)+"…":Eval("Describ").ToString().Trim()%>
                                        
                                    </li>
                        </ItemTemplate>
                    </asp:Repeater>
                    </ul>
                </div>
            </div>
            <%--友情链接--%>
            <div id="FriendsLink" class="FriendsLink">
                 <div class="annou_title">
                    <div class="title_info title_FriendsLink"><p>┃友情链接</p><div class="title_more"></div></div>
                </div>
                <div>
                    <ul>
                    <asp:Repeater ID="repFriendsLink" runat="server">
                        <ItemTemplate>
                                    <li><a href='<%#Eval("URL") %>' title='<%#Eval("LinkName")%>' target="_blank"><%#Eval("LinkName")==null?"":Eval("LinkName").ToString().Length>12?Eval("LinkName").ToString().Trim().Substring(0,11)+"…":Eval("LinkName").ToString().Trim()%></a></li>
                            </ItemTemplate>
                    </asp:Repeater>
                    </ul>
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
