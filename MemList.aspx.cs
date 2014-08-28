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
    public partial class MemList : System.Web.UI.Page
    {
        Cultural.BLL.Member memBll = new Cultural.BLL.Member();
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();

        //public static Hashtable ht = new Hashtable();
        //public static Hashtable htBID = new Hashtable();
        //public static string id = "";
        //public static string ParentBName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                boardIDInfo.Value = "leader";
                try
                {
                    //显示该板块的Infomation
                    DataSet infoData = new DataSet();
                    infoData = memBll.GetListByPage(" Status in ('1','2') ", " MemberID asc ", 1, 15);
                    repNewsList.DataSource = infoData;
                    repNewsList.DataBind();

                }
                catch (Exception ex)
                {
                    Maticsoft.Common.MessageBox.Show(this.Page, "可能原因：\\n         1.网络错误\\n         2.暂时无数据\\n       请重试！" + ex.Message);
                }
            }
        }
        /*
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
        }
        */

        public string GetDepartNameByID(object ID) 
        {
            if (ID != null && ID.ToString().Trim()!="")
            {
                Cultural.BLL.Department departBll = new Cultural.BLL.Department();
                Cultural.Model.Department depart = new Cultural.Model.Department();
                depart = departBll.GetModel(int.Parse(ID.ToString()));
                if (depart != null)
                {
                    return depart.DepartName;
                }
                else 
                {
                    return "";
                }
            }
            else
            {
                return "";
            }
        }
    }
}