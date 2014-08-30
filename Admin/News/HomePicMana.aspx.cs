using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.News
{
    public partial class HomePicMana : System.Web.UI.Page
    {
        Cultural.BLL.HomeImg homePicBll = new Cultural.BLL.HomeImg();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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
            if (txtKeyword.Text.Trim() != "")
            {
                if (ddlShow.SelectedIndex != 0)
                {
                    strWhere.AppendFormat(" Status='2' and ImgDesc like '%{0}%' ", txtKeyword.Text.Trim());
                }
                else
                {
                    strWhere.AppendFormat(" Status!='0' and ImgDesc like '%{0}%' ", txtKeyword.Text.Trim());                    
                }
            }
            else
            {
                if (ddlShow.SelectedIndex != 0)
                {
                    strWhere.AppendFormat(" Status='2' ");
                }
                else
                {
                    strWhere.AppendFormat(" Status!='0' ");
                }
            }
            strWhere.Append(" order by ImgID desc ");
            ds = homePicBll.GetList(strWhere.ToString());
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
            Cultural.Model.HomeImg homeImg = new Cultural.Model.HomeImg();
            if (e.CommandName == "HomePicDelete")
            {
                homeImg = homePicBll.GetModel(int.Parse(e.CommandArgument.ToString()));
                homeImg.Status = "0";
                homePicBll.Update(homeImg);
                BindData();
            }
            if (e.CommandName == "HomePicShow")
            {
                homeImg = homePicBll.GetModel(int.Parse(e.CommandArgument.ToString()));
                homeImg.Status = homeImg.Status == "2" ? "1" : "2";
                if (homeImg.Status == "2")
                {
                    int num = homePicBll.GetRecordCount(" Status ='2' ");
                    if (num >= 6)
                    {
                        Maticsoft.Common.MessageBox.Show(this.Page, "首页最多显示6张图片，目前已达到6张！请取消部分图片首页显示！");
                    }
                    else
                    {
                        homePicBll.Update(homeImg);
                        BindData();    
                    }
                }
                else
                {
                    homePicBll.Update(homeImg);
                    BindData();
                }
            }
        }
    }
}