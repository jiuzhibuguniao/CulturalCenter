using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class TypeModify : System.Web.UI.Page
    {
        public string id = "";
        Cultural.BLL.Board bll = new Cultural.BLL.Board();
        protected void Page_Load(object sender, EventArgs e)
        {
            id=Request.QueryString["id"];
            if (!IsPostBack)
            {
                BindDropdownList();
                Cultural.Model.Board board = new Cultural.Model.Board();
                if (id!=null && id.ToString() != "")
                {
                    board = bll.GetModel(int.Parse(id));
                    ddlParent.SelectedIndex=ddlParent.Items.IndexOf(ddlParent.Items.FindByValue(board.ParentID.ToString()));
                    txtBoardName.Text = board.BoardName;
                }
            }
        }

        public void BindDropdownList()
        {
            DataSet bList = new DataSet();
            bList = bll.GetAllList();
            ddlParent.Items.Clear();
            for (int i = 0; i < bList.Tables[0].Rows.Count;i++ )
            {
                ddlParent.Items.Add(new ListItem(bList.Tables[0].Rows[i]["BoardName"].ToString(),bList.Tables[0].Rows[i]["BoardID"].ToString()));
            }
            ddlParent.Items.Insert(0, new ListItem("第一级", "0"));
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Cultural.Model.Board board = new Cultural.Model.Board();
            board.BoardName = txtBoardName.Text.Trim();
            board.ParentID =int.Parse(ddlParent.SelectedValue);
            board.Status = "1";
            if (id != null && id.ToString() != "")
            {
                board.BoardID = int.Parse(id);
                bll.Update(board);
                Maticsoft.Common.CommonFun.Show(this.Page,"修改成功！");
            }
            else
            {
                bll.Add(board);
                Maticsoft.Common.CommonFun.Show(this.Page,"保存成功");
            }
            BindDropdownList();
            txtBoardName.Text = "";
        }
    }
}