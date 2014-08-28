using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class NewsList : System.Web.UI.Page
    {
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
                                    infoData = infoBll.GetListByPage(string.Format(" BoardID={0} and Status!=0", boardList[0].BoardID), " Weight desc,PubTime desc ", 1, 15);
                                    boardInfoNum.Value = infoBll.GetRecordCount(string.Format(" BoardID={0} and Status!=0", boardList[0].BoardID)).ToString();
                                    repNewsList.DataSource = infoData;
                                    repNewsList.DataBind();
                                }
                                else // 如果没有子版块 
                                {
                                    //给页面子版块赋值null
                                    repBoardList.DataSource = null;
                                    repBoardList.DataBind();
                                    //显示第一个板块的Infomation
                                    DataSet infoData = new DataSet();
                                    infoData = infoBll.GetListByPage(string.Format(" BoardID={0} and Status!=0", board.BoardID), " Weight desc,PubTime desc ", 1, 15);
                                    boardInfoNum.Value = infoBll.GetRecordCount(string.Format(" BoardID={0} and Status!=0", board.BoardID)).ToString();
                                    repNewsList.DataSource = infoData;
                                    repNewsList.DataBind();
                                }
                            }
                            else //非一级板块
                            {
                                //取得该板块所属一级板块
                                Cultural.Model.Board parentBoard = new Cultural.Model.Board();
                                parentBoard = boardBll.GetModel(int.Parse(board.ParentID.ToString()));
                                if (parentBoard != null)
                                {
                                    ParentBName = parentBoard.BoardName;
                                    //给页面子版块赋值null
                                    //取得所有子级板块
                                    List<Cultural.Model.Board> boardList = new List<Cultural.Model.Board>();
                                    boardList = boardBll.GetModelList(string.Format(" ParentID ={0} and Status!='0' ", parentBoard.BoardID));
                                    repBoardList.DataSource = boardList;
                                    repBoardList.DataBind();
                                }
                                //显示该板块的Infomation
                                DataSet infoData = new DataSet();
                                infoData = infoBll.GetListByPage(string.Format(" BoardID={0} and Status!=0", board.BoardID), " Weight desc,PubTime desc ", 1,15);
                                boardInfoNum.Value = infoBll.GetRecordCount(string.Format(" BoardID={0} and Status!=0", board.BoardID)).ToString();
                                repNewsList.DataSource = infoData;
                                repNewsList.DataBind();
                            }
                        }
                        else
                        {
                            ParentBName = Request.QueryString["BName"];
                            Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.暂时无数据\\n       请重试！");
                        }
                    }
                    else
                    {
                        ParentBName = Request.QueryString["BName"];
                        Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.暂时无数据\\n       请重试！");
                    }
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
            //htBID.Clear();
            //htBID.Add("中心概况", "");
            //htBID.Add("新闻动态", "");
            //htBID.Add("闲情偶寄", "");
            //htBID.Add("业界资讯", "");
            //htBID.Add("服务社会", "");
            //htBID.Add("合作单位", "");
            //htBID.Add("专家队伍", "");
            //foreach (DictionaryEntry h in ht)
            //{
            //    htBID["中心概况"] = h.Value.ToString() == "中心概况" ? h.Key : htBID["中心概况"];
            //    htBID["新闻动态"] = h.Value.ToString() == "新闻动态" ? h.Key :htBID["新闻动态"];
            //    htBID["闲情偶寄"] = h.Value.ToString() == "闲情偶寄" ? h.Key :htBID["闲情偶寄"];
            //    htBID["业界资讯"] = h.Value.ToString() == "业界资讯" ? h.Key :htBID["业界资讯"];
            //    htBID["服务社会"] = h.Value.ToString() == "服务社会" ? h.Key :htBID["服务社会"];
            //    htBID["合作单位"] = h.Value.ToString() == "合作单位" ? h.Key :htBID["合作单位"];
            //    htBID["专家队伍"] = h.Value.ToString() == "专家队伍" ? h.Key :htBID["专家队伍"];
            //}
        }
    }
}