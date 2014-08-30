using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin
{
    public partial class Index : System.Web.UI.Page
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
                    case "1":
                    case "2":
                    case "6":
                        SiteMapDataSource1.SiteMapProvider = "ExpertSite";
                        break;
                    case "3":
                        SiteMapDataSource1.SiteMapProvider = "StaffSite";
                        break;
                    case "4":
                        SiteMapDataSource1.SiteMapProvider = "AdminSite";
                        break;
                    case "5":
                        SiteMapDataSource1.SiteMapProvider = "SuperAdminSite";
                        break;
                    
                    case "7":
                        Response.Redirect("login.aspx?fg=0");
                        break;
                    default:
                        SiteMapDataSource1.SiteMapProvider = "ExpertSite";
                        break;
                }

            }
            //BLL.Announcement anBll = new BLL.Announcement();
            //AnnounceRep.DataSource = anBll.GetListByPage(" Status='正常' ", "AnnounceID", 0, 10);
            //AnnounceRep.DataBind();
        }

        protected void btnExit_Click(object sender, ImageClickEventArgs e)
        {
            Session[Common.Session_MemID] = null;
            Session[Common.Session_MemName] = null;
            Session[Common.Session_LoginID] = null;
            Session[Common.Session_MemStatus] = null;
            Response.Redirect("~/Default.aspx");
        }

        protected void btnHome_Click(object sender, ImageClickEventArgs e)
        {
            Maticsoft.Common.CommonFun.Redirect("~/Default.aspx", "_blank", "");
        }
    }
}