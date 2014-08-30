using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Maticsoft.Common;

namespace CulturalCenter.Admin.News
{
    public partial class ManaNews : System.Web.UI.Page
    {
        Cultural.BLL.Board Boardbll = new Cultural.BLL.Board();
        Cultural.BLL.Information InfoBll = new Cultural.BLL.Information();

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

        public void BindDropdownList()
        {
            DataSet bList = new DataSet();
            bList = Boardbll.GetList(" ParentID=0 and Status!='0' ");
            ddlBoard.Items.Clear();
            for (int i = 0; i < bList.Tables[0].Rows.Count; i++)
            {
                ddlBoard.Items.Add(new ListItem(bList.Tables[0].Rows[i]["BoardName"].ToString(), bList.Tables[0].Rows[i]["BoardID"].ToString()));
            }
            ddlBoard.Items.Insert(0,new ListItem("全部","0"));
            ddlBoard.SelectedIndex=0;
        }

        #region gridView

        public void BindData()
        {

            List<Cultural.Model.Information> ds = new List<Cultural.Model.Information>();
            StringBuilder strWhere = new StringBuilder();
            switch (ddlStatus.SelectedItem.Value)
            {
                case "0":
                    strWhere.AppendFormat(" Status in('1','100') ");
                    break;
                case "1":
                    strWhere.AppendFormat(" Status ='0' ");
                    break;
                case "2":
                    strWhere.AppendFormat(" Status in('0','1','100') ");
                    break;
                default:
                    strWhere.AppendFormat(" Status in('0','1','100') ");
                    break;
            }
            if (ddlBoardSon.Items.Count > 0)
            {
                switch (ddlBoardSon.Items[ddlBoardSon.SelectedIndex].Value)
                {
                    case "0":
                        strWhere.AppendFormat(string.Format(" and BoardID in (select BoardID from Board where ParentID={0}) ", ddlBoard.Items[ddlBoard.SelectedIndex].Value));
                        break;
                    default:
                        strWhere.AppendFormat(" and BoardID ={0} ", ddlBoardSon.Items[ddlBoardSon.SelectedIndex].Value);
                        break;
                }
            }
            else
            {
                if (ddlBoard.SelectedIndex != 0)
                {
                    strWhere.AppendFormat(string.Format(" and BoardID in (select BoardID from Board where ParentID={0}) ", ddlBoard.Items[ddlBoard.SelectedIndex].Value));
                }
            }
            if (txtKeyword.Text.Trim() != "")
            {
                strWhere.AppendFormat(" and Title like '%{0}%' ", txtKeyword.Text.Trim());
            }
            else
            {
                strWhere.AppendFormat("");
            }
            strWhere.AppendFormat(" order by PubTime desc");
            ds = InfoBll.GetList(strWhere.ToString());
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
                LinkButton linkbtnDel = (LinkButton)e.Row.FindControl("LinkButton1");
                linkbtnDel.Attributes.Add("onclick", "return confirm(\"你确认要删除吗\")");

                //object obj1 = DataBinder.Eval(e.Row.DataItem, "Levels");
                //if ((obj1 != null) && ((obj1.ToString() != "")))
                //{
                //    e.Row.Cells[1].Text = obj1.ToString();
                //}

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
            if (e.CommandName == "InfoDelete")
            {
                Cultural.Model.Information info = new Cultural.Model.Information();
                info = InfoBll.GetModel(int.Parse(e.CommandArgument.ToString()));
                info.Status = "0";
                InfoBll.Update(info);
                BindData();
            }
            if (e.CommandName == "InfoTop")
            {
                Cultural.Model.Information info = new Cultural.Model.Information();
                info = InfoBll.GetModel(int.Parse(e.CommandArgument.ToString()));
                if (info.Weight == 100)
                {
                    info.Weight = 1;
                    InfoBll.Update(info);
                }
                else if (info.Weight == 1)
                {
                    InfoBll.SetTop(int.Parse(e.CommandArgument.ToString()));
                }
                BindData();
            }
        }

        protected void ddlBoard_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBoard.SelectedIndex != 0)
            {
                DataSet bList = new DataSet();
                bList = Boardbll.GetList(string.Format(" ParentID={0} and Status!='0' ", ddlBoard.Items[ddlBoard.SelectedIndex].Value));
                ddlBoardSon.Items.Clear();
                ddlBoardSon.DataValueField = "BoardID";
                ddlBoardSon.DataTextField = "BoardName";
                ddlBoardSon.DataSource = bList;
                ddlBoardSon.DataBind();
                ddlBoardSon.Items.Insert(0, new ListItem("全部", "0"));
                ddlBoardSon.SelectedIndex = 0;
            }
            else
            {
                ddlBoardSon.Items.Clear();
            }
            BindData();
        }

        protected void ddlBoardSon_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }
}