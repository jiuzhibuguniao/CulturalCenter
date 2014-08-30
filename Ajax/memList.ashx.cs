using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// memList 的摘要说明
    /// </summary>
    public class memList : IHttpHandler
    {
        public class VMemberInfo 
        {
            private List<Cultural.Model.ViewMemDepart> _vmember;

            public List<Cultural.Model.ViewMemDepart> Vmember
            {
                get { return _vmember; }
                set { _vmember = value; }
            }

            private string _num;

            public string Num
            {
                get { return _num; }
                set { _num = value; }
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string paraBoardID = context.Request["BoardID"];  //读取参数索引
            int paraIndex = context.Request["Index"] == null ? 1 : int.Parse(context.Request["Index"]);  //读取参数Index
            int paraSize = context.Request["PageSize"] == null ? 10 : int.Parse(context.Request["PageSize"]);  //读取参数PageSize
            VMemberInfo VmemInfo = new VMemberInfo();
            Cultural.BLL.ViewMemDepart memBLL = new Cultural.BLL.ViewMemDepart();
            if (paraBoardID != null && paraBoardID.Trim() == "leader")
            {
                VmemInfo.Vmember = memBLL.DataTableToList(memBLL.GetListByPage(" Status in ('1','2') ", " MemberID asc ", (paraIndex - 1) * paraSize , paraIndex * paraSize).Tables[0]);
                VmemInfo.Num = memBLL.GetRecordCount(" Status in ('1','2') ").ToString();
            }
            else if (paraBoardID != null && paraBoardID.Trim() == "expert")
            {
                VmemInfo.Vmember = memBLL.DataTableToList(memBLL.GetListByPage(" Status in ('0','2') ", " MemberID asc ", (paraIndex - 1) * paraSize , paraIndex * paraSize).Tables[0]);
                VmemInfo.Num = memBLL.GetRecordCount(" Status in ('0','2') ").ToString();
            }
            context.Response.Write(JsonHelper.Serialize(VmemInfo));
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