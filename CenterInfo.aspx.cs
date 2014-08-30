using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class CenterInfo : System.Web.UI.Page
    {
        Cultural.BLL.Information infoBll = new Cultural.BLL.Information();
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        public static Hashtable ht = new Hashtable();
        public static Hashtable htBID = new Hashtable();
        public static string id = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id = GetBIDByQueryStr(Request.QueryString["BName"]);
                if (id != null && id.ToString().Trim() != "" && id.ToString() != "0")
                {
                    //绑定板块标签
                    List<Cultural.Model.Board> bList = boardBll.GetModelList(string.Format(" Status!='0' and ParentID={0} ", id));
                    repBoardList.DataSource = bList;
                    repBoardList.DataBind();
                    //板块ID隐藏域赋值
                    if (bList != null && bList.Count > 0)
                    {
                        InfoID.Value = bList[0].BoardID.ToString();
                    }
                    else
                    {
                        InfoID.Value = "0";
                    }
                }
                else
                {
                    repBoardList.DataSource = null;
                    repBoardList.DataBind();
                    InfoID.Value = "0";
                }
                repAnnounce.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["公告"] == "" ? "0" : htBID["公告"]), " Weight desc,PubTime desc ", 0, 9);
                repAnnounce.DataBind();

                repRelaxInfo.DataSource = infoBll.GetListByPage(string.Format(" (BoardID ={0} or BoardID in(select BoardID from Board where ParentID ={1}) ) and  Status!='0' ", htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"], htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"]), " Weight desc,PubTime desc ", 0, 8);
                repRelaxInfo.DataBind();
            }          
        }

        public string GetBIDByQueryStr(object queryStr)
        {
            string tempid = "0";
            ResetHashTable();
            if (queryStr != null && queryStr.ToString().Trim() != "")
            {
                foreach (DictionaryEntry h in ht)
                {
                    if (queryStr.ToString().Trim() == h.Value.ToString())
                    {
                        tempid = h.Key.ToString();
                        break;
                    }
                    else
                    {
                        continue;
                    }
                }
                return tempid;
            }
            else
            {
                return "0";
            }
        }

        public void ResetHashTable()
        {
            List<Cultural.Model.Board> bList = boardBll.GetModelList(" Status!='0' ");
            ht.Clear();
            for (int i = 0; i < bList.Count; i++)
            {
                ht.Add(bList[i].BoardID, bList[i].BoardName);
            }
            htBID.Clear();
            htBID.Add("公告", 0);
            htBID.Add("中心概况", 0);
            htBID.Add("中心动态", 0);
            htBID.Add("闲情偶寄", 0);
            htBID.Add("业界资讯", 0);
            htBID.Add("服务社会", 0);
            htBID.Add("合作单位", 0);
            htBID.Add("专家队伍", 0);
            foreach (DictionaryEntry h in ht)
            {
                htBID["公告"] = h.Value.ToString() == "公告" ? h.Key : htBID["公告"];
                htBID["中心概况"] = h.Value.ToString() == "中心概况" ? h.Key : htBID["中心概况"];
                htBID["中心动态"] = h.Value.ToString() == "中心动态" ? h.Key : htBID["中心动态"];
                htBID["闲情偶寄"] = h.Value.ToString() == "闲情偶寄" ? h.Key : htBID["闲情偶寄"];
                htBID["业界资讯"] = h.Value.ToString() == "业界资讯" ? h.Key : htBID["业界资讯"];
                htBID["服务社会"] = h.Value.ToString() == "服务社会" ? h.Key : htBID["服务社会"];
                htBID["合作单位"] = h.Value.ToString() == "合作单位" ? h.Key : htBID["合作单位"];
                htBID["专家队伍"] = h.Value.ToString() == "专家队伍" ? h.Key : htBID["专家队伍"];
            }
        }
    }
}