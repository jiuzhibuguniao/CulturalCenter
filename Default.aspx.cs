using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class _Default : System.Web.UI.Page
    {
        Cultural.BLL.Information infoBll = new Cultural.BLL.Information();
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        Cultural.BLL.Link linkBll = new Cultural.BLL.Link();
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();
        Cultural.BLL.HomeImg homeImgBll = new Cultural.BLL.HomeImg();

        public static Hashtable ht = new Hashtable();
        public static Hashtable htBID = new Hashtable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<Cultural.Model.Board> bList = boardBll.GetModelList(" Status!='0' ");
                ht.Clear();
                for (int i = 0; i < bList.Count; i++)
                {
                    ht.Add(bList[i].BoardID, bList[i].BoardName);
                }
                htBID.Clear();
                htBID.Add("公告","");
                htBID.Add("中心动态","");
                htBID.Add("闲情偶寄","");
                htBID.Add("业界资讯","");
                htBID.Add("服务社会","");
                htBID.Add("合作单位","");
                htBID.Add("友情链接","");
                foreach(DictionaryEntry h in ht)
                {
                    htBID["公告"]= h.Value.ToString()=="公告"?h.Key:htBID["公告"];
                    htBID["中心动态"] = h.Value.ToString() == "中心动态" ? h.Key : htBID["中心动态"];
                    htBID["闲情偶寄"] = h.Value.ToString() == "闲情偶寄" ? h.Key :htBID["闲情偶寄"];
                    htBID["业界资讯"] = h.Value.ToString() == "业界资讯" ? h.Key : htBID["业界资讯"];
                    htBID["服务社会"] = h.Value.ToString() == "服务社会" ? h.Key : htBID["服务社会"];
                    htBID["合作单位"] = h.Value.ToString() == "合作单位" ? h.Key :htBID["合作单位"];
                    htBID["友情链接"] = h.Value.ToString() == "友情链接" ? h.Key :htBID["友情链接"];
                }
            }

            repAnnounce.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["公告"].ToString() == "" ? "0" : htBID["公告"]), " Weight desc,PubTime desc ", 0, 9);
            repAnnounce.DataBind();

            repCenterNews.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["中心动态"].ToString() == "" ? "0" : htBID["中心动态"]), " Weight desc,PubTime desc ", 0, 9);
            repCenterNews.DataBind();

            repRelaxInfo.DataSource = infoBll.GetListByPage(string.Format(" (BoardID ={0} or BoardID in(select BoardID from Board where ParentID ={1}) ) and  Status!='0' ", htBID["闲情偶寄"].ToString() == "" ? "0" : htBID["闲情偶寄"], htBID["闲情偶寄"] == "" ? "0" : htBID["闲情偶寄"]), " Weight desc,PubTime desc ", 0, 8);
            repRelaxInfo.DataBind();

            repFieldInfo.DataSource = infoBll.GetListByPage(string.Format(" BoardID={0} and  Status!='0' ", htBID["业界资讯"].ToString() == "" ? "0" : htBID["业界资讯"]), " Weight desc,PubTime desc ", 0, 8);
            repFieldInfo.DataBind();

            repTrainInfo.DataSource = infoBll.GetListByPage(string.Format(" (BoardID ={0} or BoardID in(select BoardID from Board where ParentID ={1}) ) and  Status!='0' ", htBID["服务社会"].ToString() == "" ? "0" : htBID["服务社会"], htBID["服务社会"] == "" ? "0" : htBID["服务社会"]), " Weight desc,PubTime desc ", 0, 8);
            repTrainInfo.DataBind();

            repPartner.DataSource = departBll.GetListByPage(string.Format("Status!='0' and  Weight>0", htBID["合作单位"].ToString() == "" ? "0" : htBID["合作单位"]), " Weight desc ", 0, 10);
            repPartner.DataBind();

            repFriendsLink.DataSource = linkBll.GetListByPage(string.Format(" Status='2' "), " Weight desc ", 0, 20);
            repFriendsLink.DataBind();

            repImgShow.DataSource = homeImgBll.GetListByPage(" Status='2' ", " ImgID desc ",0,6);
            repImgShow.DataBind();
        }
    }
}