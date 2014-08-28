using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class DepartModify : System.Web.UI.Page
    {
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();
        public static string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id=Request.QueryString["id"];
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
            List<Cultural.Model.Board> bList = boardBll.GetModelList(" BoardName='合作单位' and Status ='1' ");
            board = bList.Count > 0 ? bList[0] : null;
            if (board != null)
            {
                bList = boardBll.GetModelList(string.Format(" ParentID={0} and Status ='1' ", board.BoardID));
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
                txtDepartName.Text = depart.DepartName;
                txtChargeName.Text = depart.MainCharge;
                txtAddress.Text = depart.Address;
                txtConnect.Text = depart.Phone;
                ddlDepartType.SelectedIndex = ddlDepartType.Items.IndexOf(ddlDepartType.Items.FindByValue(depart.BoardID.ToString()));
                ddlShow.SelectedIndex = depart.Weight == 0 ? 0 : 1;
                MemPhoto.ImageUrl =@"../../Image/DepartPhoto/"+ depart.PicURL;
                txtResume.Text= depart.Describ;
                hidFilePath.Value = depart.PicURL;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            string strErr = "";
            if (this.txtDepartName.Text.Trim().Length == 0)
            {
                strErr += "单位名称不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }

            Cultural.Model.Department depart = new Cultural.Model.Department();
            depart.DepartName = txtDepartName.Text.Trim();
            depart.MainCharge = txtChargeName.Text.Trim();
            depart.Address = txtAddress.Text.Trim();
            depart.Phone = txtConnect.Text.Trim();
            depart.BoardID = int.Parse(ddlDepartType.SelectedItem.Value);
            
            string RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            depart.Status = "1";
            depart.PicURL = hidFilePath.Value;
            depart.Describ = txtResume.Text.Trim();
            if (id != null && id.ToString() != "")
            {
                depart.Weight = ddlShow.SelectedIndex == 0 ? 0 : departBll.GetModel(int.Parse(id)).Weight;
                depart.DepartID = int.Parse(id);
                departBll.Update(depart);
            }
            else
            {
                depart.Weight = ddlShow.SelectedIndex;
                departBll.Add(depart);
            }
            
            int tempid = departBll.GetMaxId() - 1;
            if (tempid != 0)
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "ShowDepartSingle.aspx?id=" + tempid.ToString());
            }

        }

        public void btnCancle_Click(object sender, EventArgs e)
        {
            Response.Redirect("list.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strErr = "";
            if (this.txtDepartName.Text.Trim().Length == 0)
            {
                strErr += "单位名称不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }

            Cultural.Model.Department depart = new Cultural.Model.Department();
            depart.DepartName = txtDepartName.Text.Trim();
            depart.MainCharge = txtChargeName.Text.Trim();
            depart.Address = txtAddress.Text.Trim();
            depart.Phone = txtConnect.Text.Trim();
            depart.BoardID = int.Parse(ddlDepartType.SelectedItem.Value);
            string RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            depart.Status = "1";
            depart.PicURL = hidFilePath.Value;
            depart.Describ = txtResume.Text.Trim();

            if (id != null && id.ToString() != "")
            {
                depart.Weight = ddlShow.SelectedIndex == 0 ? 0 : departBll.GetModel(int.Parse(id)).Weight;
                depart.DepartID = int.Parse(id);
                departBll.Update(depart);
            }
            else
            {
                depart.Weight = ddlShow.SelectedIndex;
                departBll.Add(depart);
            }
            Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "AddMember.aspx");
        }
    }
}