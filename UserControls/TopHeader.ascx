<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopHeader.ascx.cs" Inherits="CulturalCenter.UserControls.TopHeader" %>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<link href="../CSS/Mainpage.css" rel="stylesheet" type="text/css" />
<link href="../CSS/TimeControlStyle.css" rel="stylesheet" type="text/css" />
<div id="topHeader" class="topHeader">
        <span><div id="today"><span id="timespan"></span></div></span>
        <span>华中休闲文化研究中心欢迎您！</span>
        <span class="SethomePage"><a href="#" >设为首页</a></span>
        <span class="AddFavor"><a href="#">加入收藏</a></span>
        <span class="header_lr"><a href="../Admin/login.aspx" target="_blank"><%=MemName %></a></span>
        <span class="header_lr"><a href="Admin/Member/Register.aspx" target="_blank">注册</a></span>
</div>
        
<div id="header_home" class="header">
    
    <object id="obj1" border="0" width="998" height="130" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000">
    <param value="../image/web/piaodai.swf" name="movie">
    <param value="High" name="quality">
    <param value="transparent" name="wmode">
    <embed width="998" height="130" wmode="transparent" quality="High" name="obj1" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" src="../image/web/piaodai.swf"></object>
    <%--
    <script type="text/javascript">
            var swf_src = '/Image/pixviewer.swf';
            var focus_width = 1000;
            var focus_height = 130;
            var nb_width = focus_width + 2;
            var nb_height = focus_height + 2;
            var text_height = 0;
            var swf_height = focus_height + text_height;
            var pics = '/Image/1.jpg|/Image/2.jpg';
            var links = '';
            var texts = '';
            document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="' + focus_width + '" height="' + swf_height + '">');
            document.write('<param name="allowScriptAccess" value="sameDomain">');
            document.write('<param name="movie" value="' + swf_src + '">');
            document.write('<param name="quality" value="high">');
            document.write('<param name="bgcolor" value="#fff">');
            document.write('<param name="menu" value="false">');
            document.write('<param name="wmode" value="opaque">');
            document.write('<param name="FlashVars" value="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + (nb_width + 2) + '&borderheight=' + (nb_height + 2) + '&textheight=' + text_height + '">');
            document.write('<embed src="' + swf_src + '" wmode="opaque" FlashVars="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + (nb_width + 2) + '&borderheight=' + (nb_height + 2) + '&textheight=' + text_height + '" menu="false" bgcolor="white" quality="high" width="' + focus_width + '" height="' + swf_height + '" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
            document.write('</object>');
    </script>
    <object width="1000" height="130" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">
        <param value="sameDomain" name="allowScriptAccess">
        <param value="/Image/pixviewer.swf" name="movie">
        <param value="high" name="quality">
        <param value="#fff" name="bgcolor">
        <param value="false" name="menu">
        <param value="opaque" name="wmode">
        <param value="pics=/Image/1.jpg|/Image/2.jpg&links=&texts=&borderwidth=1004&borderheight=134&textheight=0" name="FlashVars">
        <embed width="1000" height="130" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowscriptaccess="sameDomain" quality="high" bgcolor="white" menu="false" flashvars="pics=/Image/1.jpg|/Image/2.jpg&links=&texts=&borderwidth=1004&borderheight=134&textheight=0" wmode="opaque" src="/Image/pixviewer.swf">
    </object>--%>
</div>
<%--导航--%>
<div id="navbar" class="navbar">
                <div id="nav_left" class="nav_left"></div>
                <div id="nav_content" class="nav_right">
                    <ul>
                        <li><a href="Default.aspx" target="_blank">首页</a></li>
                        <li>|</li>
                        <li><a href="CenterInfo.aspx?BName=中心概况">中心概况</a></li>
                        <li>|</li>
                        <li><a href="NewsList.aspx?BName=中心动态" >中心动态</a></li>
                        <li>|</li>
                        <li><a href="AchieveList.aspx?BName=中心成果"  >中心成果</a></li>
                        <li>|</li>
                        <li><a href="MemList.aspx"  >专家队伍</a></li>
                        <li>|</li>
                        <li><a href="DepartList.aspx?BName=合作单位" >合作单位</a></li>
                        <li>|</li>
                        <li><a href="NewsList.aspx?BName=业界资讯" >业界资讯</a></li>
                        <li>|</li>
                        <li><a href="NewsList.aspx?BName=闲情偶寄" >闲情偶寄</a></li>
                        <li>|</li>
                        <li><a href="NewsList.aspx?BName=服务社会" >服务社会</a></li>
                        <li>|</li>
                        <li><a href="DownList.aspx?BName=下载中心" >下载中心</a></li>
                        <li>|</li>
                        <li><a href="#">English</a></li>
                    </ul>
                </div>
                <div id="nav_right" class="nav_content"></div>
            </div>
<script type="text/javascript" language="javascript">
    function changeweek(weeks) {
        switch (weeks) {
            case 0:
                return "日";
                break;
            case 1:
                return "一";
                break;
            case 2:
                return "二";
                break;
            case 3:
                return "三";
                break;
            case 4:
                return "四";
                break;
            case 5:
                return "五";
                break;
            case 6:
                return "六";
                break;
        }
    }
    function timer() {
        thistime = new Date();
        var dates = thistime.getDate();
        var months = thistime.getMonth() + 1;
        var years = thistime.getFullYear();
        var weeks = thistime.getDay();
        var charweek = changeweek(weeks);
        var hours = thistime.getHours();
        var minutes = thistime.getMinutes();
        var seconds = thistime.getSeconds();
        if (eval(hours) < 10) { hours = "0" + hours; }
        if (eval(minutes) < 10) { minutes = "0" + minutes; }
        if (seconds < 10) { seconds = "0" + seconds; }
        document.getElementById("timespan").innerHTML = years + "年" + months + "月" + dates + "日" + " 星期" + charweek + "&nbsp;" + hours + ":" + minutes + ":" + seconds;
        t = setTimeout("timer()", 1000);
    }
    timer();

</script>