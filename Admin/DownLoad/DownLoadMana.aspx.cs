using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.DownLoad
{
    public partial class DownLoadMana : System.Web.UI.Page
    {
        Cultural.BLL.DownCenter bll = new Cultural.BLL.DownCenter();
        Cultural.BLL.DownFile dfBll = new Cultural.BLL.DownFile();
        Cultural.BLL.Board Boardbll = new Cultural.BLL.Board();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindPDropdownList();
                BindData();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string idlist = GetSelIDlist();
            if (idlist.Trim().Length == 0)
                return;
            bll.DeleteList(idlist);
            BindData();
        }

        #region gridView

        public void BindData()
        {

            DataSet ds = new DataSet();
            StringBuilder strWhere = new StringBuilder();
            if (ddlBoard.SelectedIndex != 0)
            {
                strWhere.AppendFormat(string.Format(" Status ='1' and BoardID={0} ",ddlBoard.Items[ddlBoard.SelectedIndex].Value));
            }
            else 
            {
                strWhere.AppendFormat(" Status ='1' ");
            }
            if (txtKeyword.Text.Trim() != "")
            {
                strWhere.AppendFormat(" and DownTitle like '%{0}%' ", txtKeyword.Text.Trim());
            }
            else
            {
                strWhere.AppendFormat("");
            }
            strWhere.Append(" order by PubTime desc ");
            ds = bll.GetList(strWhere.ToString());
            gridView.DataSource = ds;
            gridView.DataBind();
        }

        public void BindPDropdownList()
        {
            DataSet bList = new DataSet();
            bList = Boardbll.GetList(" ParentID in(select BoardID from Board where BoardName='下载中心' and ParentID=0 ) and Status!='0' ");
            ddlBoard.Items.Clear();
            ddlBoard.DataValueField = "BoardID";
            ddlBoard.DataTextField = "BoardName";
            ddlBoard.DataSource = bList;
            ddlBoard.DataBind();
            ddlBoard.Items.Insert(0, new ListItem("全部", "0"));
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
            if (e.CommandName == "DownDelete")
            {
                Cultural.Model.DownCenter downF = new Cultural.Model.DownCenter();
                downF = bll.GetModel(int.Parse(e.CommandArgument.ToString()));
                downF.Status = "0";
                bll.Update(downF);
                dfBll.DeleteByDownID(downF.DownID);
                BindData();
            }
        }

        public string GetAttachment(object o)
        {
            if (o != null)
            {
                if (o.ToString().Trim() != "")
                {
                    Cultural.BLL.DownFile dfBLL = new Cultural.BLL.DownFile();
                    List<Cultural.Model.DownFile> dfList = new List<Cultural.Model.DownFile>();
                    dfList = dfBLL.GetModelList(string.Format(" Status !='0' and DownID={0} ",o.ToString().Trim()));
                    if (dfList != null && dfList.Count > 0)
                    {
                        StringBuilder dfName = new StringBuilder("");
                        foreach (Cultural.Model.DownFile df in dfList)
                        {
                            dfName.Append(string.Format("【{0}】   ",df.FileOriName));
                        }
                        return dfName.ToString();
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
            else
            {
                return "";
            }
        }
    }
}