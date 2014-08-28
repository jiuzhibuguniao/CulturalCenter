<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="STDecisionSys.Register" Theme="GreenT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>办公系统--注册</title>
 <link href="../../JS/jquery.uploadify-v2.1.0/example/css/default.css" rel="stylesheet" />
    <link href="../../JS/jquery.uploadify-v2.1.0/uploadify.css"  rel="stylesheet" type="text/css" />
    <script src="../../JS/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/swfobject.js"></script>
    <script type="text/javascript" src="../../JS/jquery.uploadify-v2.1.0/jquery.uploadify.v2.1.0.min.js"></script>
   
     <script type="text/javascript">


         $(document).ready(function () {
             
             $("#txtLoginID").bind("blur",function () {
                 $.ajax({
                     url: "../../AJAX/Login.ashx",
                     type: 'POST',
                     data: { MemName: $("#txtLoginID").val() },//tparm,
                     dataType: "html",
                     success: function (data,textStatus) {
                         if (data != null) {
                             if (data == "Exist") {
                                 $("img[id=LoginCheck]").attr("src", "../../Image/Admin/error.gif");
                             }
                             else if (data == "None") {
                                 $("img[id=LoginCheck]").attr("src", "../../Image/Admin/ok.gif");
                             }
                         }
                         else {
                             $("img[id=LoginCheck]").attr("src", "../../Image/Admin/error.gif");
                         }
                     }
                 })
             });
         });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <div id="headerCon" class="headerContainer">
        <div id="header_home" class="Adminheader">
                <object id="obj1" border="0" width="998" height="100" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000">
                <param value="../image/web/piaodai.swf" name="movie">
                <param value="High" name="quality">
                <param value="transparent" name="wmode">
                <embed width="998" height="100" wmode="transparent" quality="High" name="obj1" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" src="../image/web/piaodai.swf"></object>
        </div>
    </div>
      <div id="content" style="min-height:450px;">
            <table style="width: 95%;" cellpadding="2" cellspacing="1" class="border" >
        <tr>
            <td class="tdbg" align="center">
                <table cellSpacing="0" cellPadding="0" width="750" border="0">
	                <tr><td height="25"></td><td></td><td></td><td></td></tr>
                    <tr><td height="25"></td><td></td><td></td><td></td></tr>
                    <tr>
	                <td height="25" width="30%" align="right">
		                登录名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtLoginID" runat="server" Width="170px"></asp:TextBox><span style="color:red;font-size:16px;font-weight:bolder;">*</span><img id="LoginCheck" src="" width="16" height="16" alt="" />
	                </td>
	                <td height="25" width="30%" align="right">
		                密 码
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtPassword" runat="server" Width="190px" TextMode="Password"></asp:TextBox><span style="color:red;font-size:16px;font-weight:bolder;">*</span>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                姓名
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtStaffName" runat="server" Width="190px"></asp:TextBox><span style="color:red;font-size:16px;font-weight:bolder;">*</span>
	                </td>
	                <td height="25" width="30%" align="right">
		                密码确认
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:TextBox id="txtPassConfirm" runat="server" Width="190px"  TextMode="Password"></asp:TextBox><span style="color:red;font-size:16px;font-weight:bolder;">*</span>
		                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                电话
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtPhone" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                性别
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:DropDownList ID="ddlGender" runat="server" Width="200px">
                            <asp:ListItem Text="" Value="0"></asp:ListItem>
                            <asp:ListItem Text="男" Value="1"></asp:ListItem>
                            <asp:ListItem Text="女" Value="2"></asp:ListItem>
                        </asp:DropDownList>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                地址
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtAddress" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                邮箱
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtEmail" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                单位
	                ：</td>
	                <td height="25" width="*" align="left">
		                <asp:TextBox id="txtDepartID" runat="server" Width="200px"></asp:TextBox>
	                </td>
	                <td height="25" width="30%" align="right">
		                职务
	                ：</td>
	                <td height="25" width="*" align="left">
                        <asp:TextBox id="txtJob" runat="server" Width="200px"></asp:TextBox>
	                </td></tr>
	                <tr>
	                <td height="25" width="30%" align="right">
		                个人简介
	                ：</td>
	                <td height="25" width="*" align="left" colspan="3">
		                <asp:TextBox id="txtResume" runat="server" TextMode="MultiLine" Width="550px" Height="50px"></asp:TextBox>
	                </td></tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="tdbg" align="center" valign="bottom">
                <asp:Button ID="btnSave" runat="server" Text="注册"
                    OnClick="btnSave_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
                <asp:Button ID="btnCancle" runat="server" Text="取消"
                    OnClick="btnCancle_Click" class="inputbutton" onmouseover="this.className='inputbutton_hover'"
                    onmouseout="this.className='inputbutton'"></asp:Button>
            </td>
        </tr>
    </table>
    </div>
        
        <div id="Footer" >
            <uco:copyright ID="copyright1" runat="server" />
        </div>
    </div>
    </form>
</body>
</html>
