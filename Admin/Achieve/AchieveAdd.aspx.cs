using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Achieve
{
    public partial class AchieveAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdownList();
            }
        }

        public void BindDropdownList()
        {
            Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
            Cultural.Model.Board board = new Cultural.Model.Board();
            List<Cultural.Model.Board> boardList = new List<Cultural.Model.Board>();
            boardList = boardBll.GetModelList(string.Format(" BoardName ='{0}' and Status!='0' ","中心成果"));
            if (boardList != null && boardList.Count > 0)
            {
                List<Cultural.Model.Board> bList = new List<Cultural.Model.Board>();
                bList = boardBll.GetModelList(string.Format(" ParentID={0} and Status!='0' ",boardList[0].BoardID));
                ddlBoard.DataTextField = "BoardName";
                ddlBoard.DataValueField = "BoardID";
                ddlBoard.DataSource = bList;
                ddlBoard.DataBind();
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string achName = txtAchName.Text.Trim();
            string mainCharge = txtAchName.Text.Trim();
            string Origin = txtOrigon.Text.Trim();
            string publish = txtPublish.Text.Trim();
            string content = txtContent.Text.Trim();
            string meaning = txtMeaning.Text.Trim();
            int boardId =int.Parse( ddlBoard.SelectedValue);
            string accName = hidFileOriName.Value;
            string accURL = hidFileNewName.Value;
            if (achName != "" && content != "")
            {
                Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
                Cultural.Model.Achievement achieve = new Cultural.Model.Achievement();
                achieve.AchieveName = achName;
                achieve.MainCharge = mainCharge;
                achieve.Origon = Origin;
                achieve.Publish = publish;
                achieve.Content = content;
                achieve.Meaning = meaning;
                achieve.BoardID = boardId;
                achieve.AccName = accName;
                achieve.AccURL = accURL;
                achieve.Status = "1";
                try
                {
                    achBll.Add(achieve);
                    MessageBox.ShowAndRedirect(this.Page, "保存成功！","AchieveMana.aspx");
                }
                catch 
                {
                    MessageBox.Show(this.Page,"网络出错，保存失败！请重试！");
                }
            }
            else
            {
                Maticsoft.Common.MessageBox.Show(this.Page,"项目名或项目主要内容不能为空！");
            }
        }

        protected void btnSaveAdd_Click(object sender, EventArgs e)
        {
            string achName = txtAchName.Text.Trim();
            string mainCharge = txtCharger.Text.Trim();
            string Origin = txtOrigon.Text.Trim();
            string publish = txtPublish.Text.Trim();
            string content = txtContent.Text.Trim();
            string meaning = txtMeaning.Text.Trim();
            int boardId = int.Parse(ddlBoard.SelectedValue);
            string accName = hidFileOriName.Value;
            string accURL = hidFileNewName.Value;
            if (achName != "" && content != "")
            {
                Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
                Cultural.Model.Achievement achieve = new Cultural.Model.Achievement();
                achieve.AchieveName = achName;
                achieve.MainCharge = mainCharge;
                achieve.Origon = Origin;
                achieve.Publish = publish;
                achieve.Content = content;
                achieve.Meaning = meaning;
                achieve.BoardID = boardId;
                achieve.AccName = accName;
                achieve.AccURL = accURL;
                achieve.Status = "1";
                try
                {
                    achBll.Add(achieve);
                    MessageBox.ShowAndRedirect(this.Page, "保存成功！", "AchieveAdd.aspx");
                }
                catch
                {
                    MessageBox.Show(this.Page, "网络出错，保存失败！请重试！");
                }
            }
            else
            {
                Maticsoft.Common.MessageBox.Show(this.Page, "项目名或项目主要内容不能为空！");
            }
        }
    }
}