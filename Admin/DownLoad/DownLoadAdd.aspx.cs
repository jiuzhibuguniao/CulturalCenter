using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.DownLoad
{
    public partial class DownLoadAdd : System.Web.UI.Page
    {
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownListBind();
                AuthorID.Value = Session[Maticsoft.Common.Common.Session_MemID].ToString();
            }
        }

        public void DropDownListBind()
        {
            Cultural.Model.Board board = new Cultural.Model.Board();
            List<Cultural.Model.Board> bList = boardBll.GetModelList(" BoardName='下载中心' and Status ='1' ");
            board = bList.Count > 0 ? bList[0] : null;
            if (board != null)
            {
                bList = boardBll.GetModelList(string.Format(" ParentID={0} and Status ='1' ", board.BoardID));
                for (int i = 0; i < bList.Count; i++)
                {
                    ddlDownLoad.Items.Add(new ListItem(bList[i].BoardName, bList[i].BoardID.ToString()));
                }
            }
        }

    }
}