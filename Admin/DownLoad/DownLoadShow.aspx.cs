using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.DownLoad
{
    public partial class DownLoadShow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownListBind();
                BindTextInfo(Request.QueryString["id"]);
            }
        }

        public void BindTextInfo(object o)
        {
            if (o != null && o.ToString().Trim() != "")
            {
                Cultural.BLL.DownCenter dcBll = new Cultural.BLL.DownCenter();
                Cultural.BLL.DownFile dfBll = new Cultural.BLL.DownFile();
                Cultural.Model.DownCenter downCenter = new Cultural.Model.DownCenter();
                downCenter = dcBll.GetModel(int.Parse(o.ToString()));
                if (downCenter != null)
                {
                    txtDownTitle.Text = downCenter.DownTitle;
                    txtDownTitle.Enabled = false;
                    txtDownDesc.Text = downCenter.DownDesc;
                    txtDownDesc.Enabled = false;
                    ddlDownLoad.SelectedIndex = ddlDownLoad.Items.IndexOf(ddlDownLoad.Items.FindByValue(downCenter.BoardID.ToString()));
                    ddlDownLoad.Enabled = false;
                    repDownFile.DataSource = dfBll.GetModelList(string.Format(" Status!='0' and DownID={0} ",downCenter.DownID));
                    repDownFile.DataBind();
                }
            }
        }

        public void DropDownListBind()
        {
            Cultural.Model.Board board = new Cultural.Model.Board();
            Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
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