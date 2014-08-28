using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class AchieveList : System.Web.UI.Page
    {
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();
        Cultural.BLL.Information infoBll = new Cultural.BLL.Information();
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();

        public static Hashtable ht = new Hashtable();
        public static Hashtable htBID = new Hashtable();
        public static string id = "";
        public static string ParentBName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id = GetBIDByQueryStr(Request.QueryString["BName"]);
                boardIDInfo.Value = id;
                try
                {
                    if (id != null && id.ToString().Trim() != "")
                    {
                        //取得该id的板块信息
                        Cultural.Model.Board board = new Cultural.Model.Board();
                        board = boardBll.GetModel(int.Parse(id));
                        if (board != null)
                        {
                            if (board.ParentID == 0)//为第一级板块
                            {
                                //一级板块名赋值
                                ParentBName = board.BoardName;
                                //取得所有子级板块
                                List<Cultural.Model.Board> boardList = new List<Cultural.Model.Board>();
                                boardList = boardBll.GetModelList(string.Format(" ParentID ={0} and Status!='0' ", board.BoardID));
                                //如果有子版块
                                if (boardList.Count > 0)
                                {
                                    //给页面子版块赋值
                                    repBoardList.DataSource = boardList;
                                    repBoardList.DataBind();
                                    //显示第一个板块的Infomation
                                    boardIDInfo.Value = boardList[0].BoardID.ToString();
                                    DataSet infoData = new DataSet();
                                    infoData = departBll.GetListByPage(string.Format(" BoardID={0} and Status!=0", boardList[0].BoardID), " Weight desc,DepartID asc ", 1, 15);
                                    boardInfoNum.Value = departBll.GetRecordCount(string.Format(" BoardID={0} and Status!=0", boardList[0].BoardID)).ToString();
                                    repAchList.DataSource = infoData;
                                    repAchList.DataBind();
                                }
                                else // 如果没有子版块 
                                {
                                    //给页面子版块赋值null
                                    repBoardList.DataSource = null;
                                    repBoardList.DataBind();
                                    //显示第一个板块的Infomation
                                    DataSet infoData = new DataSet();
                                    infoData = departBll.GetListByPage(string.Format(" BoardID={0} and Status!=0", board.BoardID), " Weight desc,DepartID asc ", 1, 15);
                                    boardInfoNum.Value = departBll.GetRecordCount(string.Format(" BoardID={0} and Status!=0", board.BoardID)).ToString();
                                    repAchList.DataSource = infoData;
                                    repAchList.DataBind();
                                }
                            }
                            else //非一级板块
                            {
                                repAchList.DataSource = null;
                                repAchList.DataBind();
                            }
                        }
                        else
                        {
                            ParentBName = Request.QueryString["BName"];
                            Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.初始化错误\\n解决方案：\\n          1.浏览器“工具--选项--高级”中，浏览器设置为非兼容模式\\n       2.联系管理员\\n       请重试！");
                        }
                    }
                    else
                    {
                        ParentBName = Request.QueryString["BName"];
                        Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.暂时无数据\\n       请重试！");
                    }
                    repAnnounce.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["公告"] == "" ? "0" : htBID["公告"]), " Weight desc,PubTime desc ", 0, 9);
                    repAnnounce.DataBind();

                    repRelaxInfo.DataSource = infoBll.GetListByPage(string.Format(" (BoardID ={0} or BoardID in(select BoardID from Board where ParentID ={1}) ) and  Status!='0' ", htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"], htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"]), " Weight desc,PubTime desc ", 0, 8);
                    repRelaxInfo.DataBind();
                }
                catch (Exception ex)
                {
                    ParentBName = Request.QueryString["BName"];
                    Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.暂时无数据\\n       请重试！" + ex.Message);
                }
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
            htBID.Add("公告", "");
            htBID.Add("闲情偶寄", "");
            foreach (DictionaryEntry h in ht)
            {
                htBID["公告"] = h.Value.ToString() == "公告" ? h.Key : htBID["公告"];
                htBID["闲情偶寄"] = h.Value.ToString() == "闲情偶寄" ? h.Key : htBID["闲情偶寄"];
            }
        }
    }
}