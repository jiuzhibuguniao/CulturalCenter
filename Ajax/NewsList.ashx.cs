using Cultural;
using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// NewsList 的摘要说明
    /// </summary>
    public class NewsList : IHttpHandler
    {
        public class NewsInfo
        {
            //父板块ID
            private string _boardID;

            public string BoardID
            {
                get { return _boardID; }
                set { _boardID = value; }
            }
            //父板块名
            private string _boardName;

            public string BoardName
            {
                get { return _boardName; }
                set { _boardName = value; }
            }
            //当前板块名
            private string _bName;

            public string BName
            {
                get { return _bName; }
                set { _bName = value; }
            }
            private string _author;

            public string Author
            {
                get { return _author; }
                set { _author = value; }
            }

            private int _totalNum;

            public int TotalNum
            {
                get { return _totalNum; }
                set { _totalNum = value; }
            }

            private List<Cultural.Model.Information> _info;

            public List<Cultural.Model.Information> Info
            {
                get { return _info; }
                set { _info = value; }
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            Cultural.BLL.Information infoBLL = new Cultural.BLL.Information();
            context.Response.ContentType = "text/plain";
            string paraFID = context.Request["FID"];  //读取参数PageSize
            if (paraFID != null && paraFID.Trim()=="NL")//列表界面
            {
                int paraIndex = context.Request["Index"] == null ? 1 : int.Parse(context.Request["Index"]);  //读取参数PageSize
                int paraSize = context.Request["PageSize"] == null ? 10 : int.Parse(context.Request["PageSize"]);  //读取参数PageSize
                string paraBoardID = context.Request["BoardID"] == null ? "0" : context.Request["BoardID"].ToString();  //读取参数
                NewsInfo newsInfo = new NewsInfo();
                newsInfo.Info = infoBLL.DataTableToList(infoBLL.GetListByPage(string.Format(" BoardID={0} and Status!='0' ", paraBoardID), " Weight desc,PubTime desc ", (paraIndex - 1) * paraSize, paraIndex * paraSize).Tables[0]);
                newsInfo.TotalNum = infoBLL.GetRecordCount(string.Format(" BoardID={0} and Status!='0' ", paraBoardID));
                newsInfo.BoardID = paraBoardID;
                for (int i = 0; i < newsInfo.Info.Count; i++)
                {
                    newsInfo.Info[i].Content = newsInfo.Info[i].Content == null ? "" : Maticsoft.Common.CommonFun.ClearHtml(newsInfo.Info[i].Content).Length > 230 ? Maticsoft.Common.CommonFun.ClearHtml(newsInfo.Info[i].Content).Substring(0, 229) + "…" :CommonFun.ClearHtml( newsInfo.Info[i].Content);
                }
                context.Response.Write(JsonHelper.Serialize(newsInfo));
            }
            else if(paraFID!=null && paraFID.Trim()=="ND")//详细界面
            {
                int paraID = context.Request["InfoID"] == null ? 1 : int.Parse(context.Request["InfoID"]);  //读取参数PageSize
                if (paraID != null && paraID.ToString().Trim() != "")
                {
                    Cultural.Model.Information info = new Cultural.Model.Information();
                    info = infoBLL.GetModel(paraID);
                    NewsInfo newsInfo = new NewsInfo();
                    newsInfo.Info = new List<Cultural.Model.Information>();
                    if (info != null)
                    {
                        newsInfo.Info.Add(info);
                        //阅读次数更新
                        info.ReadNum += 1;
                        infoBLL.Update(info);
                        Cultural.BLL.Member memBll = new Cultural.BLL.Member();
                        newsInfo.Author = memBll.GetModel(int.Parse(info.Author.ToString().Trim())).MembName;
                        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
                        Cultural.Model.Board board = new Cultural.Model.Board();
                        board = boardBll.GetModel(int.Parse(info.BoardID.ToString()));
                        if (board != null && board.ParentID == 0)
                        {
                            newsInfo.BoardID = board.BoardID.ToString();
                            newsInfo.BoardName = board.BoardName;
                            newsInfo.BName = "";
                        }
                        else if (board != null && board.ParentID != 0)
                        {
                            Cultural.Model.Board board2 = new Cultural.Model.Board();
                            board2 = boardBll.GetModel(int.Parse(board.ParentID.ToString()));
                            if (board2 != null)
                            {
                                newsInfo.BoardID = board2.BoardID.ToString();
                                newsInfo.BoardName = board2.BoardName;
                                newsInfo.BName = board.BoardName;
                            }
                            else
                            {
                                newsInfo.BoardID = board.BoardID.ToString();
                                newsInfo.BoardName = board.BoardName;
                                newsInfo.BName = "";
                            }
                        }
                        else
                        {
                            newsInfo.BoardID = board.BoardID.ToString();
                            newsInfo.BoardName = board.BoardName;
                            newsInfo.BName = "";
                        }
                    }
                    context.Response.Write(JsonHelper.Serialize(newsInfo));
                }
                else
                {
                    context.Response.Write(JsonHelper.Serialize("error"));
                }
            }
            else if (paraFID != null && paraFID.Trim() == "CND")//中心概括界面  邹瑶修改20140225
            {
                int paraID = context.Request["InfoID"] == null ? 1 : int.Parse(context.Request["InfoID"]);  //读取参数PageSize
                NewsInfo newsInfo = new NewsInfo();
                if (paraID != null && paraID.ToString().Trim() != "")
                {
                    newsInfo.Info = infoBLL.GetModelList(string.Format(" BoardID ={0} and  Status!='0' order by Weight desc,PubTime desc  ", paraID));
                }
                context.Response.Write(JsonHelper.Serialize(newsInfo));
            }
            else
            {
                context.Response.Write(JsonHelper.Serialize("error"));
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}