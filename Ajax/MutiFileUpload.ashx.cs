using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// MutiFileUpload 的摘要说明
    /// </summary>
    public class MutiFileUpload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string paraFID = context.Request["FID"];  //读取参数PageSize
            if (paraFID != null && paraFID.Trim() == "HomePic")//中心概括界面
            {
                Cultural.BLL.HomeImg homeBll = new Cultural.BLL.HomeImg();
                string paraImgDesc = context.Request["ImgDesc"] == null ? "" : context.Request["ImgDesc"];  //读取参数图片描述
                string paraImgURL = context.Request["ImgURL"] == null ? "" : context.Request["ImgURL"];  //读取参数图片路径
                if (paraImgURL != null && paraImgURL.ToString().Trim() != "")
                {
                    try
                    {
                        Cultural.Model.HomeImg homeImg = new Cultural.Model.HomeImg();
                        homeImg.ImgDesc = CommonFun.ClearHtml(paraImgDesc);
                        homeImg.ImgURL = paraImgURL;
                        homeImg.Status = "1";
                        homeBll.Add(homeImg);
                    }
                    catch 
                    {
                        context.Response.Write(JsonHelper.Serialize("error"));
                    }
                }
                context.Response.Write(JsonHelper.Serialize("success"));
            }
            else if (paraFID != null && paraFID.Trim() == "DownInfo")
            {
                string Title = context.Request["Title"] == null ? "" : context.Request["Title"];
                string Desc = context.Request["Desc"] == null ? "" : context.Request["Desc"];
                int BoardID = context.Request["BoardID"] == null ? 0 : int.Parse(context.Request["BoardID"]);
                int Author = context.Request["Author"] == null ? 0 : int.Parse(context.Request["Author"]);
                Cultural.BLL.DownCenter downCBll = new Cultural.BLL.DownCenter();
                Cultural.Model.DownCenter downCenter = new Cultural.Model.DownCenter();
                downCenter.Author = Author;
                downCenter.BoardID = BoardID;
                downCenter.DownDesc = Desc;
                downCenter.DownTitle = Title;
                downCenter.PubTime = string.Format("{0}-{1}-{2} {3}:{4}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'), DateTime.Now.Hour.ToString().PadLeft(2, '0'), DateTime.Now.Minute.ToString().PadLeft(2, '0'));
                downCenter.Status = "1";
                try
                {
                    List<Cultural.Model.DownCenter> tdList = new List<Cultural.Model.DownCenter>();
                    tdList = downCBll.GetModelList(string.Format(" DownTitle='{0}' ",  downCenter.DownTitle));
                    if (tdList != null && tdList.Count > 0)
                    {
                        context.Response.Write(JsonHelper.Serialize("error"));
                    }
                    else
                    {
                        downCBll.Add(downCenter);
                        List<Cultural.Model.DownCenter> dList = new List<Cultural.Model.DownCenter>();
                        dList = downCBll.GetModelList(string.Format(" Author={0} and BoardID={1} and  DownTitle='{2}' order by PubTime desc ", downCenter.Author, downCenter.BoardID, downCenter.DownTitle));
                        if (dList != null && dList.Count > 0)
                        {
                            context.Response.Write(JsonHelper.Serialize(dList[0].DownID));
                        }
                        else
                        {
                            context.Response.Write(JsonHelper.Serialize("error"));
                        }
                    }
                }
                catch
                {
                    context.Response.Write(JsonHelper.Serialize("error"));
                }
            }
            else if (paraFID != null && paraFID.Trim() == "DownFile")
            {
                string FileOriName = context.Request["FileOriName"] == null ? "" : context.Request["FileOriName"];
                string FilePath = context.Request["FilePath"] == null ? "" : context.Request["FilePath"];
                int DownID = context.Request["DownID"] == null ? 0 : int.Parse(context.Request["DownID"]);
                if (DownID != 0)
                {
                    Cultural.BLL.DownFile downFBll = new Cultural.BLL.DownFile();
                    Cultural.Model.DownFile downFile = new Cultural.Model.DownFile();
                    downFile.DownID = DownID;
                    downFile.FileOriName = FileOriName;
                    downFile.FilePath = FilePath;
                    downFile.Status = "1";
                    try
                    {
                        downFBll.Add(downFile);
                        context.Response.Write(JsonHelper.Serialize("success"));
                    }
                    catch
                    {
                        context.Response.Write(JsonHelper.Serialize("error"));
                    }
                }
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