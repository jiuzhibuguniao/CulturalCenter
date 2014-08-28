using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Achieve
{
    public partial class AchieveModify : System.Web.UI.Page
    {
        public static string id = "";
        public static string FilePath = "";
        Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
        public static Cultural.Model.Achievement ach = new Cultural.Model.Achievement();
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            if (!IsPostBack)
            {
                if (id != null && id.ToString() != "")
                {
                    BindDropdownList();
                    ach = achBll.GetModel(int.Parse(id));
                    BindTextBox(ach);
                }
            }
        }

        public void BindTextBox(Cultural.Model.Achievement ach)
        {
            if (ach != null)
            {
                hidAchID.Value = ach.AchieveID.ToString();
                txtAchName.Text = ach.AchieveName;
                Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
                Cultural.Model.Board board = new Cultural.Model.Board();
                board = boardBll.GetModel(int.Parse(ach.BoardID.ToString()));
                ddlBoard.SelectedIndex = board != null ? ddlBoard.Items.IndexOf(ddlBoard.Items.FindByValue(ach.BoardID.ToString())) : 0;
                txtCharger.Text = ach.MainCharge;
                txtContent.Text = ach.Content;
                txtMeaning.Text = ach.Meaning;
                txtOrigon.Text = ach.Origon;
                txtPublish.Text = ach.Publish;
                txtFileName.Text = ach.AccName;
                FilePath = Maticsoft.Common.CommonFun.URLConverToServer(string.Format("{0}{1}", "../../FileUpload/", ach.AccURL));
            }
        }

        public void BindDropdownList()
        {
            Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
            Cultural.Model.Board board = new Cultural.Model.Board();
            List<Cultural.Model.Board> boardList = new List<Cultural.Model.Board>();
            boardList = boardBll.GetModelList(string.Format(" BoardName ='{0}' and Status!='0' ", "中心成果"));
            if (boardList != null && boardList.Count > 0)
            {
                List<Cultural.Model.Board> bList = new List<Cultural.Model.Board>();
                bList = boardBll.GetModelList(string.Format(" ParentID={0} and Status!='0' ", boardList[0].BoardID));
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardID";
                ddlBoard.DataSource = bList;
                ddlBoard.DataBind();
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string mainCharge = txtCharger.Text.Trim();
            string Origin = txtOrigon.Text.Trim();
            string publish = txtPublish.Text.Trim();
            string content = txtContent.Text.Trim();
            string meaning = txtMeaning.Text.Trim();
            int boardId = int.Parse(ddlBoard.SelectedValue);
            string accName = hidFileOriName.Value;
            string accURL = hidFileNewName.Value;
            if ( content != "")
            {
                Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
                ach.MainCharge = mainCharge;
                ach.Origon = Origin;
                ach.Publish = publish;
                ach.Content = content;
                ach.Meaning = meaning;
                ach.BoardID = boardId;
                if (ach.AccName != accName)
                {
                    ach.AccName = accName;
                    ach.AccURL = accURL;
                }
                try
                {
                    achBll.Update(ach);
                    MessageBox.ShowAndRedirect(this.Page, "保存成功！", string.Format("AchieveShow.aspx?id=",hidAchID.Value));
                }
                catch
                {
                    MessageBox.Show(this.Page, "网络出错，保存失败！请重试！");
                }
            }
            else
            {
                Maticsoft.Common.MessageBox.Show(this.Page, "项目主要内容不能为空！");
            }
        }

        protected void btnSaveAdd_Click(object sender, EventArgs e)
        {
            string mainCharge = txtCharger.Text.Trim();
            string Origin = txtOrigon.Text.Trim();
            string publish = txtPublish.Text.Trim();
            string content = txtContent.Text.Trim();
            string meaning = txtMeaning.Text.Trim();
            int boardId = int.Parse(ddlBoard.SelectedValue);
            string accName = hidFileOriName.Value;
            string accURL = hidFileNewName.Value;
            if ( content != "")
            {
                Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
                ach.MainCharge = mainCharge;
                ach.Origon = Origin;
                ach.Publish = publish;
                ach.Content = content;
                ach.Meaning = meaning;
                ach.BoardID = boardId;
                if (ach.AccName != accName)
                {
                    ach.AccName = accName;
                    ach.AccURL = accURL;
                }
                try
                {
                    achBll.Update(ach);
                    MessageBox.ShowAndRedirect(this.Page, "保存成功！", "AchieveAdd.aspx");
                }
                catch
                {
                    MessageBox.Show(this.Page, "网络出错，保存失败！请重试！");
                }
            }
            else
            {
                Maticsoft.Common.MessageBox.Show(this.Page, "项目主要内容不能为空！");
            }
        }
    }
}