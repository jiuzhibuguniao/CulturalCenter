using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.News
{
    public partial class AddNews : System.Web.UI.Page
    {
        Cultural.BLL.Board Boardbll = new Cultural.BLL.Board();
        Cultural.BLL.Information InfoBll = new Cultural.BLL.Information();
        //public static String remainContent = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtContent.Text = "注意：在编辑内容之前确保板块已选好，否则选择板块时数据可能清空！";
                BindPDropdownList();
            }
        }

        public void BindPDropdownList()
        {
            DataSet bList = new DataSet();
            bList = Boardbll.GetList(" ParentID =0 and Status!='0' ");
            ddlPBoardID.Items.Clear();
            ddlPBoardID.DataValueField = "BoardID";
            ddlPBoardID.DataTextField = "BoardName";
            ddlPBoardID.DataSource = bList;
            ddlPBoardID.DataBind();
            ddlPBoardID.Items.Insert(0,new ListItem("请选择板块","0"));
        }
        public void BindSDropdownList(object parentID)
        {
            if (parentID != null && parentID.ToString() != "")
            {
                DataSet bList = new DataSet();
                bList = Boardbll.GetList(string.Format(" ParentID ={0} and Status!='0' ",parentID.ToString()));
                ddlSBoardID.Items.Clear();
                ddlSBoardID.DataValueField = "BoardID";
                ddlSBoardID.DataTextField = "BoardName";
                ddlSBoardID.DataSource = bList;
                ddlSBoardID.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (ddlSBoardID.Items.Count > 0)
            {
                string title = txtTitle.Text.Trim();
                string content = txtContent.Text;
                int boardID = int.Parse(ddlSBoardID.Items[ddlSBoardID.SelectedIndex].Value);
                int weight = ddlTopShow.SelectedValue == "0" ? 1 : 100;
                int author = int.Parse(Session[Common.Session_MemID].ToString());
                string pubtime = string.Format("{0}-{1}-{2} {3}:{4}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'), DateTime.Now.Hour.ToString().PadLeft(2, '0'), DateTime.Now.Minute.ToString().PadLeft(2, '0'));
                int readnum = 0;
                string status = "1";
                string picUrl = hidImgPath.Value;
                string accURL = hidFilePath.Value;
                string accname = hidFileOriName.Value;
                if (title != "" && content.Trim() != "")
                {
                    Cultural.Model.Information info = new Cultural.Model.Information();
                    info.Author = author;
                    info.BoardID = boardID;
                    info.Content = content;
                    info.PubTime = pubtime;
                    info.ReadNum = readnum;
                    info.Status = status;
                    info.Title = title;
                    info.Weight = weight;
                    info.PicURL1 = picUrl;
                    info.AccURL1 = accURL;
                    info.AccName1 = accname;
                    try
                    {
                        InfoBll.Add(info);
                        Maticsoft.Common.MessageBox.ShowAndRedirect(this.Page, "添加成功！","AddNews.aspx");
                    }
                    catch
                    {
                        Maticsoft.Common.MessageBox.Show(this.Page, "添加失败！");
                    }
                }
                else
                {
                    MessageBox.Show(this.Page, "标题和内容不能为空！添加失败！");
                }
            }
            else
            {
                MessageBox.Show(this.Page, "该板块还尚未添加子版块，请添加子版块后再填写新闻！");
            }
        }

        protected void ddlPBoardID_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSDropdownList(ddlPBoardID.Items[ddlPBoardID.SelectedIndex].Value);
        }
    }
}