using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// DepartList 的摘要说明
    /// </summary>
    public class DepartList : IHttpHandler
    {
        public class DepartInfo 
        {
            private List<Cultural.Model.Department> _departList;

            public List<Cultural.Model.Department> DepartList
            {
                get { return _departList; }
                set { _departList = value; }
            }

            private int _totalNum;

            public int TotalNum
            {
                get { return _totalNum; }
                set { _totalNum = value; }
            }
        }
        public class DownLoadInfo
        {
            private List<Cultural.Model.DownCenter> _downCenterList;

            public List<Cultural.Model.DownCenter> DownCenterList
            {
                get { return _downCenterList; }
                set { _downCenterList = value; }
            }

            private int _totalNum;

            public int TotalNum
            {
                get { return _totalNum; }
                set { _totalNum = value; }
            }
            //当前板块名
            private string _bName;

            public string BName
            {
                get { return _bName; }
                set { _bName = value; }
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Cultural.BLL.Department departBll = new Cultural.BLL.Department();
            context.Response.ContentType = "text/plain";
            string paraFID = context.Request["FID"];  //读取参数PageSize
            if (paraFID != null && paraFID.Trim() == "DL")//列表界面
            {
                int paraIndex = context.Request["Index"] == null ? 1 : int.Parse(context.Request["Index"]);  //读取参数PageSize
                int paraSize = context.Request["PageSize"] == null ? 10 : int.Parse(context.Request["PageSize"]);  //读取参数PageSize
                string paraBoardID = context.Request["BoardID"] == null ? "0" : context.Request["BoardID"].ToString();  //读取参数
                DepartInfo departInfo = new DepartInfo();
                departInfo.DepartList = departBll.DataTableToList(departBll.GetListByPage(string.Format(" BoardID={0} and Status!='0' ", paraBoardID), " Weight desc,DepartID asc ", (paraIndex - 1) * paraSize , paraIndex * paraSize).Tables[0]);
                departInfo.TotalNum = departBll.GetRecordCount(string.Format(" BoardID={0} and Status!='0' ", paraBoardID));
                context.Response.Write(JsonHelper.Serialize(departInfo));
            }
            if (paraFID != null && paraFID.Trim() == "DownL")//列表界面
            {
                int paraIndex = context.Request["Index"] == null ? 1 : int.Parse(context.Request["Index"]);  //读取参数PageSize
                int paraSize = context.Request["PageSize"] == null ? 10 : int.Parse(context.Request["PageSize"]);  //读取参数PageSize
                string paraBoardID = context.Request["BoardID"] == null ? "0" : context.Request["BoardID"].ToString();  //读取参数
                DownLoadInfo downLoadInfo = new DownLoadInfo();
                Cultural.BLL.DownCenter dcBll = new Cultural.BLL.DownCenter();
                downLoadInfo.DownCenterList = dcBll.DataTableToList(dcBll.GetListByPage(string.Format(" BoardID={0} and Status!='0' ", paraBoardID), " PubTime desc ", (paraIndex - 1) * paraSize , paraIndex * paraSize).Tables[0]);
                foreach (Cultural.Model.DownCenter dc in downLoadInfo.DownCenterList)
                {
                    dc.PubTime = dc.PubTime.Substring(0, 10);
                }
                downLoadInfo.TotalNum = dcBll.GetRecordCount(string.Format(" BoardID={0} and Status!='0' ", paraBoardID));
                context.Response.Write(JsonHelper.Serialize(downLoadInfo));
            }
            if (paraFID != null && paraFID.Trim() == "DownD")//详细界面
            {
                int paraIndex = context.Request["InfoID"] == null ? 0 : int.Parse(context.Request["InfoID"]);  //读取参数InfoID
                Cultural.Model.DownCenter downLoad = new Cultural.Model.DownCenter();
                Cultural.BLL.DownCenter dcBll = new Cultural.BLL.DownCenter();
                downLoad = dcBll.GetModel(paraIndex);
                DownLoadInfo downLoadInfo = new DownLoadInfo();
                downLoadInfo.DownCenterList = new List<Cultural.Model.DownCenter>();
                downLoadInfo.DownCenterList.Add(downLoad);
                Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
                Cultural.Model.Board board = new Cultural.Model.Board();
                board = boardBll.GetModel(int.Parse(downLoad.BoardID.ToString()));
                downLoadInfo.BName = board.BoardName;
                context.Response.Write(JsonHelper.Serialize(downLoadInfo));
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