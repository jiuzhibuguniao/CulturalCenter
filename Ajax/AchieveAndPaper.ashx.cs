using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// AchieveAndPaper 的摘要说明
    /// </summary>
    public class AchieveAndPaper : IHttpHandler
    {

        public class AchInfo
        {
            private List<Cultural.Model.Achievement> _departList;

            public List<Cultural.Model.Achievement> AchList
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

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Cultural.BLL.Achievement achBll = new Cultural.BLL.Achievement();
            context.Response.ContentType = "text/plain";
            string paraFID = context.Request["FID"];  //读取参数PageSize
            if (paraFID != null && paraFID.Trim() == "ACHL")//列表界面
            {
                int paraIndex = context.Request["Index"] == null ? 1 : int.Parse(context.Request["Index"]);  //读取参数PageSize
                int paraSize = context.Request["PageSize"] == null ? 10 : int.Parse(context.Request["PageSize"]);  //读取参数PageSize
                string paraBoardID = context.Request["BoardID"] == null ? "0" : context.Request["BoardID"].ToString();  //读取参数
                AchInfo achInfoInfo = new AchInfo();
                achInfoInfo.AchList = achBll.DataTableToList(achBll.GetListByPage(string.Format(" BoardID={0} and Status!='0' ", paraBoardID), " AchieveID desc", (paraIndex - 1) * paraSize, paraIndex * paraSize).Tables[0]);
                for (int i = 0; i < achInfoInfo.AchList.Count; i++)
                {
                    achInfoInfo.AchList[i].AccURL = achInfoInfo.AchList[i].AccURL == null ? "" : Maticsoft.Common.CommonFun.URLConverToServer("FileUpload/" + achInfoInfo.AchList[i].AccURL);
                }
                achInfoInfo.TotalNum = achBll.GetRecordCount(string.Format(" BoardID={0} and Status!='0' ", paraBoardID));
                context.Response.Write(JsonHelper.Serialize(achInfoInfo));
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