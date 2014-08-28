using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.News
{
    public partial class NewsModify : System.Web.UI.Page
    {
        Cultural.BLL.Board Boardbll = new Cultural.BLL.Board();
        Cultural.BLL.Information InfoBll = new Cultural.BLL.Information();
        public static Cultural.Model.Information infomation = new Cultural.Model.Information();
        public static string id = "";
        public static string ImgPath = "";
        public static string FilePath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            if (!IsPostBack)
            {
                if (id != null && id.Trim() != "")
                {
                    infomation = InfoBll.GetModel(int.Parse(id));
                    BindInfo(infomation);
                }
            }
        }

        public void BindInfo(Cultural.Model.Information inf)
        {
            DataSet bList = new DataSet();
            bList = Boardbll.GetAllList();
            ddlBoardID.Items.Clear();
            for (int i = 0; i < bList.Tables[0].Rows.Count; i++)
            {
                ddlBoardID.Items.Add(new ListItem(bList.Tables[0].Rows[i]["BoardName"].ToString(), bList.Tables[0].Rows[i]["BoardID"].ToString()));
            }
            ddlBoardID.SelectedIndex = ddlBoardID.Items.IndexOf(ddlBoardID.Items.FindByValue(inf.BoardID.ToString()));

            ddlTopShow.SelectedIndex = inf.Weight == 100 ? 1 : 0;
            txtTitle.Text = inf.Title;
            txtContent.Text = inf.Content;
            lblAccName.Text = inf.AccName1;
            ImgPath =@"../../Image/News/"+ inf.PicURL1;
            FilePath = inf.AccName1;
            hidFilePath.Value = inf.AccURL1;
            hidImgPath.Value = inf.PicURL1;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string content =txtContent.Text;
            int boardID = int.Parse(ddlBoardID.SelectedValue);
            int weight = ddlTopShow.SelectedValue == "0" ? 1 : 100;
            int author = int.Parse(Session[Common.Session_MemID].ToString());
            string pubtime = string.Format("{0}-{1}-{2} {3}:{4}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'), DateTime.Now.Hour.ToString().PadLeft(2, '0'), DateTime.Now.Minute.ToString().PadLeft(2, '0'));
            if (title != "" && content.Trim() != "")
            {
                infomation.Author = author;
                infomation.BoardID = boardID;
                infomation.Content = content;
                infomation.PubTime = pubtime;
                infomation.Title = title;
                infomation.Weight = weight;
                if (hidImgPath.Value != infomation.PicURL1)
                {
                    infomation.PicURL1 = hidImgPath.Value;
                }
                if (hidFilePath.Value != infomation.AccURL1)
                {
                    infomation.AccName1 = hidFileOriName.Value;
                    infomation.AccURL1 = hidFilePath.Value;
                }
                try
                {
                    InfoBll.Update(infomation);
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this.Page, "保存成功！","ManaNews.aspx");
                }
                catch
                {
                    Maticsoft.Common.MessageBox.Show(this.Page, "保存失败！");
                }
            }
        }
    }
}