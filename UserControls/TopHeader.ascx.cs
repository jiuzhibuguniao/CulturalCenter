using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.UserControls
{
    public partial class TopHeader : System.Web.UI.UserControl
    {
        public static string MemName = "登录";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session[Common.Session_MemID] != null && Session[Common.Session_MemID].ToString() != "")
            {
                MemName = Session[Common.Session_MemName].ToString();
            }
            else
            {
                MemName = "登录";
            }
        }
    }
}