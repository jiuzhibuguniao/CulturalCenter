using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Achieve
{
    public partial class AchieveShow : System.Web.UI.Page
    {
        public static string id = "";
        public static string FilePath = "";
        Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
        public static Cultural.Model.Achievement ach = new Cultural.Model.Achievement();
        protected void Page_Load(object sender, EventArgs e)
        {
            id=Request.QueryString["id"];
            if (!IsPostBack)
            {
                if (id != null && id.ToString() != "")
                {
                    ach = achBll.GetModel(int.Parse(id));
                    BindTextBox(ach);
                }
            }
        }

        public void BindTextBox(Cultural.Model.Achievement ach)
        {
            if (ach != null)
            {
                txtAchName.Text = ach.AchieveName;
                 Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
                 Cultural.Model.Board board = new Cultural.Model.Board();
                board = boardBll.GetModel(int.Parse(ach.BoardID.ToString()));
                txtBoard.Text = board != null ? board.BoardName : "";
                txtCharger.Text = ach.MainCharge;
                txtContent.Text = ach.Content;
                txtMeaning.Text = ach.Meaning;
                txtOrigon.Text = ach.Origon;
                txtPublish.Text = ach.Publish;
                txtFileName.Text = ach.AccName;
                FilePath = Maticsoft.Common.CommonFun.URLConverToServer(string.Format("{0}{1}", "../../FileUpload/", ach.AccURL));
            }
        }
    }
}