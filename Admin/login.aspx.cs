using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string flag = this.Request["fg"];
            if (flag == "0")
            {
                txtFlag.Text = "用户名或密码错误！登陆失败！";
            }
            else
            {
                txtFlag.Text = "";
            }
            if (Session[Common.Session_MemID] != null && Session[Common.Session_MemID].ToString()!="")
            {
                Response.Redirect("Main.aspx");
            }
        }
    }
}