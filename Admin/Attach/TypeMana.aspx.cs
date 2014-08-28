using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class TypeMana : System.Web.UI.Page
    {
        Cultural.BLL.Board bll = new Cultural.BLL.Board();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDropdownList();
                BindData();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        #region gridView

        public void BindData()
        {
            DataSet ds = new DataSet();
            StringBuilder strWhere = new StringBuilder();
            if (ddlType.SelectedIndex == 0)
            {
                ds = bll.GetListByLevel(0);
            }
            else
            {
                if (ddlType.Items.Count > 0)
                {
                    ds = bll.GetListByLevel(2, int.Parse(ddlType.Items[ddlType.SelectedIndex].Value));
                }
                else
                {
                    ds = bll.GetListByLevel(0);
                }
            }
            ds = ds==null?ds: ds.Tables[0].Rows.Count > 0 ? ds : null;
            gridView.DataSource = ds;
            gridView.DataBind();
        }

        protected void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridView.PageIndex = e.NewPageIndex;
            BindData();
        }
        protected void gridView_OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //e.Row.Cells[0].Text = "<input id='Checkbox2' type='checkbox' onclick='CheckAll()'/><label></label>";
            }
        }
        protected void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Attributes.Add("style", "background:#FFF");
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //object obj1 = DataBinder.Eval(e.Row.DataItem, "Levels");
                //if ((obj1 != null) && ((obj1.ToString() != "")))
                //{
                //    e.Row.Cells[1].Text = obj1.ToString();
                //}
                LinkButton linkbtnDel = (LinkButton)e.Row.FindControl("LinkButton1");
                linkbtnDel.Attributes.Add("onclick", "return confirm(\"你确认要删除吗?该栏目下的所有新闻将删除！\")");
            }
        }
        protected void gridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //#warning 代码生成警告：请检查确认真实主键的名称和类型是否正确
            //int ID = (int)gridView.DataKeys[e.RowIndex].Value;
            //bll.Delete(ID);
            //gridView.OnBind();
        }

        private string GetSelIDlist()
        {
            string idlist = "";
            bool BxsChkd = false;
            for (int i = 0; i < gridView.Rows.Count; i++)
            {
                CheckBox ChkBxItem = (CheckBox)gridView.Rows[i].FindControl("DeleteThis");
                if (ChkBxItem != null && ChkBxItem.Checked)
                {
                    BxsChkd = true;
                    //#warning 代码生成警告：请检查确认Cells的列索引是否正确
                    if (gridView.DataKeys[i].Value != null)
                    {
                        idlist += gridView.DataKeys[i].Value.ToString() + ",";
                    }
                }
            }
            if (BxsChkd)
            {
                idlist = idlist.Substring(0, idlist.LastIndexOf(","));
            }
            return idlist;
        }

        #endregion

        protected void gridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MemDelete")
            {
                Cultural.Model.Board mem = new Cultural.Model.Board();
                mem = bll.GetModel(int.Parse(e.CommandArgument.ToString()));
                mem.Status = "0";
                bll.Update(mem);
                BindData();

                Cultural.BLL.Information infoBLL = new Cultural.BLL.Information();
                infoBLL.DeleteBoardInfo(mem.BoardID);
            }
        }

        public void BindDropdownList()
        {
            DataSet bList = new DataSet();
            bList = bll.GetList(" ParentID=0 and Status!='0' ");
            ddlType.Items.Clear();
            for (int i = 0; i < bList.Tables[0].Rows.Count; i++)
            {
                ddlType.Items.Add(new ListItem(bList.Tables[0].Rows[i]["BoardName"].ToString(), bList.Tables[0].Rows[i]["BoardID"].ToString()));
            }
            ddlType.Items.Insert(0, new ListItem("全部", "0"));
            ddlType.SelectedIndex = 0;
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }
}