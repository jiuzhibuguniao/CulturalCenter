using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class ShowDepartSingle : System.Web.UI.Page
    {
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id = Request.QueryString["id"];
                DropDownListBind();
                if (id != null && id.ToString() != "")
                {
                    TextBoxBind(int.Parse(id));
                }
            }
        }

        public void DropDownListBind()
        {
            Cultural.Model.Board board = new Cultural.Model.Board();
            List<Cultural.Model.Board> bList = boardBll.GetModelList(" BoardName='单位类型' and Status ='0' ");
            board = bList.Count > 0 ? bList[0] : null;
            if (board != null)
            {
                bList = boardBll.GetModelList(string.Format(" ParentID={0} and Status ='0' ", board.BoardID));
                for (int i = 0; i < bList.Count; i++)
                {
                    ddlDepartType.Items.Add(new ListItem(bList[i].BoardName, bList[i].BoardID.ToString()));
                }
            }
        }

        public void TextBoxBind(int id)
        {
            Cultural.Model.Department depart = new Cultural.Model.Department();
            depart = departBll.GetModel(id);
            if (depart != null)
            {
                lblDepartName.Text = depart.DepartName;
                lblChargeName.Text = depart.MainCharge;
                lblAddress.Text = depart.Address;
                lblConnect.Text = depart.Phone;
                ddlDepartType.SelectedIndex = ddlDepartType.Items.IndexOf(ddlDepartType.Items.FindByValue(depart.BoardID.ToString()));
                ddlShow.SelectedIndex = depart.Weight == 0 ? 0 : 1;
                MemPhoto.ImageUrl = @"../../Image/DepartPhoto/" + depart.PicURL;
                txtResume.Text = depart.Describ;
            }
        }
    }
}