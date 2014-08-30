<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="CulturalCenter.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>华中休闲文化研究中心--登录</title>
    <link href="css/textarea.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
<!--
body {
	background-color: #abe27f;
}
-->
</style>
</head>

<script type="text/javascript" language="javascript">
<!--
    function isGBChar(string) {
        if (string == "") string = "0";
        valid = '0123456789abcdefghijklmnqporstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*( )_+/., \?<>;\1``-=/.,;';
        for (var i = 0; i < string.length; i++) {
            if (valid.indexOf(string.charAt(i)) == -1) {
                return false;
            }
            return true;
        }
    }
    function dis() {
        document.form1.submit.value = '连  接'
        document.form1.submit.disabled = true;
        return true;
    }
    function resetbtn() {
        document.form1.submit.value = '登  录'
        document.form1.submit.disabled = false;
        return true;
    }
    function check() {
        if (form1.u.value == "") {
            alert("请输入个人帐号。");
            form1.u.focus();
            return (false);
        }
        if (form1.p.value == "") {
            alert("请输入个人密码。");
            form1.p.focus();
            return (false);
        }
        if (form1.p.value.length < 3) {
            alert("请输入3位以上个人密码。");
            form1.p.focus();
            return (false);
        }
        if ((document.form1.u.value.indexOf(",") > -1) || (document.form1.p.value.indexOf("=") > -1) || (document.form1.u.value.indexOf("=") > -1) || (document.form1.p.value.indexOf(".") > -1) || (document.form1.u.value.indexOf(".") > -1) || (document.form1.p.value.indexOf(",") > -1) || (document.form1.u.value.indexOf("'") > -1) || (document.form1.p.value.indexOf("'") > -1) || (document.form1.u.value.indexOf("'") > -1) || (document.form1.p.value.indexOf("'") > -1) || (document.form1.p.value.indexOf("?") > -1) || (document.form1.u.value.indexOf("?") > -1) || (document.form1.p.value.indexOf(";") > -1) || (document.form1.u.value.indexOf(";") > -1) || (document.form1.p.value.indexOf("=") > -1) || (document.form1.u.value.indexOf("=") > -1) || (document.form1.p.value.indexOf("+") > -1) || (document.form1.u.value.indexOf("+") > -1) || (document.form1.p.value.indexOf("-") > -1) || (document.form1.u.value.indexOf("-") > -1) || (document.form1.p.value.indexOf("&") > -1) || (document.form1.u.value.indexOf("&") > -1) || (document.form1.p.value.indexOf("/") > -1)) {
            alert("请勿输入非法字符！")

            return false;
        }
        return (true);
    }
    //-->
</script>

<body>
    <form id="form2" runat="server">
    <div>
    
    </div>
    </form> 
    <form action="loginyanzheng.aspx" name="form1" method="POST" onsubmit="return dis()">
  <div align="center"><br/>
    <br/>
    <br/>
    <br/>
    <table width="668" border="0" cellpadding="0" cellspacing="1" bgcolor="#abe27f">
      <tr>
        <td><table width="667" height="408" border="0" cellpadding="0" cellspacing="1" style="background:url('../Image/Admin/bannerq.jpg') no-repeat;background-color:white;">
            <tr>
              <td><p style="height:200px;"><br/>
                </p>
                  
                  
                <p>&nbsp;</p>
                  <table width="660" border="0" cellpadding="2" cellspacing="0" bgcolor="#7DB35D">
                      <tr bgcolor="#FFFFFF">
                      <td width="28%"><div align="right">帐号：</div></td>
                      <td width="72%"><div align="left">
                          <input name="u" type="text" id="u" value="" size="20" maxlength="26"/>
                            <asp:Label ID="txtFlag" runat="server" Text="" ForeColor="Red" Font-Size="12px"></asp:Label>
                      </div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                      <td style="height: 30px"><div align="right">密码：</div></td>
                      <td style="height: 30px"><div align="left">
                          <input name="p" type="password" id="p" size="21" maxlength="26"/>
                          </div></td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                      <td height="37"></td>
                      <td><div align="left">
                          <p>
                            <input name="submit" type="submit" id="submit" value="登  录" onclick='return check();' style="FONT-SIZE: 12px; HEIGHT: 27px"/>                        
                            <input name="Submit2" type="reset" value="重  置" onclick='return resetbtn();' style="FONT-SIZE: 12px; HEIGHT: 27px; width: 64px;"/>
                          </p>
                        </div>
                        </td>
                    </tr>
                </table>
                  <p style="position:relative;float:right; display:inline-block;font-size:12px;text-align:right;padding-right:10px;"><a href="../Default.aspx" title="首页" style="color:#FF6600;">首页</a>&nbsp;&nbsp;<a href="Member/Register.aspx" title="注册" style="color:#FF6600;">点此注册</a></p>
              </td>
            </tr>
        </table></td>
      </tr>
    </table>
  </div>
</form>
</body>
</html>