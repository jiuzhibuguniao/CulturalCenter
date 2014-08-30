using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.News
{
    public partial class HomePicModify : System.Web.UI.Page
    {
        public static Cultural.Model.HomeImg homeImg = new Cultural.Model.HomeImg();
        Cultural.BLL.HomeImg homeImgBLL = new Cultural.BLL.HomeImg();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (id != null && id.ToString().Trim() != "")
                {
                    homeImg = homeImgBLL.GetModel(int.Parse(id));
                    if (homeImg != null)
                    {
                        Imghome.ImageUrl = Maticsoft.Common.CommonFun.URLConverToServer("../../Image/News/" + homeImg.ImgURL);
                        txtDesc.Text = homeImg.ImgDesc;
                    }
                    else
                    {
                        Maticsoft.Common.MessageBox.ShowAndRedirect(this.Page, "网络错误！请重试！", "HomePicMana.aspx");
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                homeImg.ImgDesc = txtDesc.Text.Trim();
                homeImgBLL.Update(homeImg);
                Maticsoft.Common.MessageBox.ShowAndRedirect(this.Page, "保存成功！", "HomePicMana.aspx");
            }
            catch
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this.Page, "网络错误！请重试！", "HomePicMana.aspx");
            }
        }
    }
}