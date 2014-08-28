using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class DepartShowMana : System.Web.UI.Page
    {
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();
        protected void Page_Load(object sender, EventArgs e)
        {
            Repeater1.DataSource = departBll.GetList(" Status!='0' and Weight>0 order by Weight desc");
            Repeater1.DataBind();
        }
    }
}