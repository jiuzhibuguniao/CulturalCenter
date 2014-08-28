using System;
using System.Collections.Generic;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// DepartMana 的摘要说明
    /// </summary>
    public class DepartMana : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string Show = context.Request["SHOW"];
            string Hide = context.Request["HIDE"];
            List<string> ShowList = new List<string>();
            List<string> HideList = new List<string>();

            Cultural.BLL.Department bll = new Cultural.BLL.Department();
            if (Show!=null && Show.ToString().Trim()!="")
            {
                
                string[] arrayS = new string[7];
                arrayS=Show.Split('|');
                foreach (string data in arrayS)
                {
                    if (data.Trim() != "")
                    {
                        ShowList.Add(data);
                    }
                }
                bll.SortShowData(ShowList);
                if (Hide != null && Hide.ToString().Trim() != "")
                {
                    int num = Hide.Length - Hide.Replace("|", "").Length;
                    string[] arrayH = new string[num];
                    arrayH = Hide.Split('|');
                    foreach (string data in arrayH)
                    {
                        if (data.Trim() != "")
                        {
                            HideList.Add(data);
                        }
                    }
                    bll.SortHideData(HideList); 
                }
                context.Response.Write("Success");
            }
            else
            {
                context.Response.Write("Failed");
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