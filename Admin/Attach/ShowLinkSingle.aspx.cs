using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class ShowLinkSingle : System.Web.UI.Page
    {
        public static string URL = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Cultural.BLL.Link linkBLL = new Cultural.BLL.Link();
            string id = Request.QueryString["id"];
            if (id != null && id.ToString() != "")
            {
                Cultural.Model.Link link = new Cultural.Model.Link();
                link=linkBLL.GetModel(int.Parse(id));
                lblName.Text = link.LinkName;
                lblURL.Text = link.URL;
                LinkImg.ImageUrl = "../../Image/LinkPhoto/" + link.PicURL;
                URL = link.URL;
            }
        }
    }
}