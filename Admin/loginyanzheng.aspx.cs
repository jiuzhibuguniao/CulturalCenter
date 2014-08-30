using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Cultural.Model;
using System.Collections.Generic;

public partial class loginyanzheng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Cultural.BLL.Member staffService = new Cultural.BLL.Member();
        string loginuser = this.Request["u"].Trim();
        string password = this.Request["p"].Trim();

        String where = " LoginID='{0}' and Password='{1}'";

        where = string.Format(where,loginuser,password);
        DataSet StaffData = staffService.GetList(where);
        if (StaffData !=null && StaffData.Tables[0].Rows.Count>0)
        {
            Cultural.Model.Member staff = new Cultural.Model.Member();
            Session.Add("MemberID", StaffData.Tables[0].Rows[0]["MemberID"].ToString().Trim());
            Session.Add("LoginID", StaffData.Tables[0].Rows[0]["LoginID"].ToString().Trim());
            Session.Add("MembName", StaffData.Tables[0].Rows[0]["MembName"].ToString().Trim());
            Session.Add("Status", StaffData.Tables[0].Rows[0]["Status"].ToString().Trim());
            Response.Redirect("Main.aspx");     
        }
        else
        {
            //this.Response.Write("用户名或密码错误！登陆失败");
            Response.Redirect("login.aspx?fg=0"); 
        }
    }
}
