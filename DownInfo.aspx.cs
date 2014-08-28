using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class DownInfo : System.Web.UI.Page
    {
        Cultural.BLL.Information infoBll = new Cultural.BLL.Information();
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        public static Hashtable ht = new Hashtable();
        public static Hashtable htBID = new Hashtable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (id != null && id.ToString().Trim() != "")
                {
                    InfoID.Value = id.ToString().Trim();
                    BindAttachMent(id);
                }
                List<Cultural.Model.Board> bList = boardBll.GetModelList(" Status!='0' ");
                ht.Clear();
                for (int i = 0; i < bList.Count; i++)
                {
                    ht.Add(bList[i].BoardID, bList[i].BoardName);
                }
                htBID.Clear();
                htBID.Add("公告", "");
                htBID.Add("闲情偶寄", "");
                htBID.Add("下载中心", "");
                foreach (DictionaryEntry h in ht)
                {
                    htBID["公告"] = h.Value.ToString() == "公告" ? h.Key : htBID["公告"];
                    htBID["闲情偶寄"] = h.Value.ToString() == "闲情偶寄" ? h.Key : htBID["闲情偶寄"];
                    htBID["下载中心"] = h.Value.ToString() == "下载中心" ? h.Key : htBID["下载中心"];
                }
            }

            repAnnounce.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["公告"] == "" ? "0" : htBID["公告"]), " Weight desc,PubTime desc ", 0, 9);
            repAnnounce.DataBind();

            repRelaxInfo.DataSource = infoBll.GetListByPage(string.Format(" (BoardID ={0} or BoardID in(select BoardID from Board where ParentID ={1}) ) and  Status!='0' ", htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"], htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"]), " Weight desc,PubTime desc ", 0, 8);
            repRelaxInfo.DataBind();

            List<Cultural.Model.Board> boardList = new List<Cultural.Model.Board>();
            boardList = boardBll.GetModelList(string.Format(" ParentID ={0} and Status!='0' ", htBID["下载中心"] == "" ? "0" : htBID["下载中心"]));
            repBoardList.DataSource = boardList;
            repBoardList.DataBind();
        }

        public void BindAttachMent(object downID)
        {
            if (downID != null && downID.ToString().Trim() != "")
            {
                Cultural.BLL.DownFile dfBLL = new Cultural.BLL.DownFile();
                repDownAttach.DataSource = dfBLL.GetModelList(string.Format(" DownID={0} and Status!='0' ",downID.ToString().Trim()));
                repDownAttach.DataBind();
            }
        }
    }
}