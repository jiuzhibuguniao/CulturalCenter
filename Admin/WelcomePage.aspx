<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WelcomePage.aspx.cs" Inherits="CulturalCenter.Admin.WelcomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--办公系统</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center; padding:40px 50px; font-family:楷体; font-size:36px;color:#279333;">
       欢迎使用办公管理系统！</div>
    <div style="text-align:left; padding:10px; font-family:宋体; font-size:14px;color:#24782e;position:relative;margin:0px auto;width:650px;line-height:30px;">
        <p>使用说明：</p>
        <div>
            <ul>
                <li>1.单击左上角“黄鹤楼”可以快速回主页；</li>
                <li>2.文件上传请按照指定大小范围上传；</li>
                <li>3.图片按照以下标准选择，非标准大小图片会被压缩：
                    <br/>&nbsp;&nbsp;首页图片大小 420*260(px)
                    <br/>&nbsp;&nbsp;专家照片大小  90*120(px)
                    <br/>&nbsp;&nbsp;链接图片大小 120*40 (px)
                </li>
                <li>4.网站栏目设置在【板块类型管理】内设置，初始一级栏目必须有且为以下栏目：
                    <br/>【中心概况】【新闻动态】【业界动态】【闲情偶寄】【合作单位】【服务社会】【下载中心】
                    <br/>其中首页“中心动态”“公告”属于“新闻动态”栏目下，“业界资讯”属于业界动态下
                    <br />有其他二级栏目需求，请自行增加
                </li>
            </ul>
        </div>
    </div>
    </form>
</body>
</html>
