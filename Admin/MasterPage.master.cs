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
using Maticsoft.Common;

namespace CulturalCenter
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        public string _tabtitle = "";
        public string TabTitle
        {
            get
            {
                return _tabtitle;
            }
            set
            {
                _tabtitle = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session[Common.Session_LoginID] == null || Session[Common.Session_MemID] == null || Session[Common.Session_MemStatus] == null)
            {
                Response.Redirect("login.aspx?fg=0");
            }
            if (!IsPostBack)
            {
                if (Session[Common.Session_MemName] != null)
                {
                    name.Text = Session[Common.Session_MemName].ToString();
                }
                switch (Session[Common.Session_MemStatus].ToString())
                { 
                    case "0":
                        SiteMapDataSource1.SiteMapProvider = "StaffSite";
                        break;
                    case "1":
                        SiteMapDataSource1.SiteMapProvider = "AdminSite";
                        break;
                    case "2":
                        SiteMapDataSource1.SiteMapProvider = "SuperAdminSite";
                        break;
                    default:
                        SiteMapDataSource1.SiteMapProvider = "StaffSite";
                        break;
                }
                
            }
            //BLL.Announcement anBll = new BLL.Announcement();
            //AnnounceRep.DataSource = anBll.GetListByPage(" Status='正常' ", "AnnounceID", 0, 10);
            //AnnounceRep.DataBind();
        }
        protected void btnExit_Click(object sender, EventArgs e)
        {
            Session[Common.Session_MemID] = null;
            Session[Common.Session_MemName] = null;
            Session[Common.Session_LoginID] = null;
            Session[Common.Session_MemStatus] = null;
            Response.Redirect("login.aspx");
        }
    }
}
