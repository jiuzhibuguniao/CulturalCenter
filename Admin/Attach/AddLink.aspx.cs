using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class AddLink : System.Web.UI.Page
    {
        Cultural.BLL.Link linkBll = new Cultural.BLL.Link();
        public static string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id = Request.QueryString["id"];
                if (id != null && id.ToString() != "")
                {
                    TextBoxBind(int.Parse(id));
                }
            }
        }

        public void TextBoxBind(int id)
        {
            Cultural.Model.Link link = new Cultural.Model.Link();
            link = linkBll.GetModel(id);
            txtLinkName.Text =link.LinkName;
            txtURL.Text=link.URL;
            ddlLinkType.SelectedIndex=int.Parse(link.URLType);
            LaodImgPath.Value = "../../Image/LinkPhoto/" + link.PicURL;
            hidFilePath.Value = link.PicURL;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            string strErr = "";
            if (this.txtLinkName.Text.Trim().Length == 0)
            {
                strErr += "链接名不能为空！\\n";
            }
            if (this.txtURL.Text.Trim().Length == 0)
            {
                strErr += "链接不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }

            Cultural.Model.Link link = new Cultural.Model.Link();
            link.LinkName = txtLinkName.Text.Trim();
            link.URL = txtURL.Text.Trim();
            link.Status = "1";
            link.Weight = 1;
            link.URLType = ddlLinkType.SelectedIndex.ToString();
            try
            {
                link.PicURL = hidFilePath.Value;
                if (id != null && id.ToString() != "")
                {
                    link.LinkID = int.Parse(id);
                    linkBll.Update(link);
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "LinkMana.aspx");
                }
                else
                {
                    linkBll.Add(link);

                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "LinkMana.aspx" );
                }
                
            }
            catch {
                Maticsoft.Common.MessageBox.Show(this, "保存失败！请重试！");
            }
        }

        public void btnCancle_Click(object sender, EventArgs e)
        {
            Response.Redirect("list.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strErr = "";
            if (this.txtLinkName.Text.Trim().Length == 0)
            {
                strErr += "链接名不能为空！\\n";
            }
            if (this.txtURL.Text.Trim().Length == 0)
            {
                strErr += "链接不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }

            Cultural.Model.Link link = new Cultural.Model.Link();
            link.LinkName = txtLinkName.Text.Trim();
            link.URL = txtURL.Text.Trim();
            link.Status = "1";
            link.Weight = 1;
            link.URLType = ddlLinkType.SelectedIndex.ToString();
            try
            {
                    link.PicURL = hidFilePath.Value;
                if (id != null && id.ToString() != "")
                {
                    link.LinkID = int.Parse(id);
                    linkBll.Update(link);
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "AddLink.aspx");
                }
                else
                {
                    linkBll.Add(link);
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "AddLink.aspx");
                }

            }
            catch
            {
                Maticsoft.Common.MessageBox.Show(this, "保存失败！请重试！");
            }
        }
    }
}