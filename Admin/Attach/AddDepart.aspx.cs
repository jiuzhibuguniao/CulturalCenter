using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Attach
{
    public partial class AddDepart : System.Web.UI.Page
    {
        Cultural.BLL.Board boardBll = new Cultural.BLL.Board();
        Cultural.BLL.Department departBll = new Cultural.BLL.Department();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DropDownListBind();
            }
        }

        public void DropDownListBind()
        {
            Cultural.Model.Board board = new Cultural.Model.Board();
            List<Cultural.Model.Board> bList = boardBll.GetModelList(" BoardName='单位类型' and Status ='1' ");
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
            depart.Weight = ddlShow.SelectedIndex==1?7:0;
            string RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            depart.Status = "0";
            depart.PicURL = hidFilePath.Value;
            depart.Describ = txtResume.Text.Trim();

            departBll.Add(depart);
            int id = departBll.GetMaxId() - 1;
            if (id != null)
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "ShowDepartSingle.aspx?id=" + id.ToString());
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
            depart.Weight = ddlShow.SelectedIndex;
            string RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            depart.Status = "1";
            depart.PicURL = hidFilePath.Value;
            depart.Describ = txtResume.Text.Trim();

            departBll.Add(depart);
            Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "AddMember.aspx");
        }
    }
}