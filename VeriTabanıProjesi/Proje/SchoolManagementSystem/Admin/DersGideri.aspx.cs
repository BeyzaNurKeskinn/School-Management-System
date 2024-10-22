using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static OkulYonetimSistemi.Models.CommonFn;

namespace OkulYonetimSistemi.Admin
{
    public partial class DersGideri : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }
            if (!IsPostBack)
            {
                GetSinif();
                GetDersGideri();
            }
        }
        private void GetSinif()
        {
            DataTable dt = fn.Fetch("Select * from Sinif");
            ddlSinif.DataSource = dt;
            ddlSinif.DataTextField = "SinifIsmi";
            ddlSinif.DataValueField = "SinifId";
            ddlSinif.DataBind();
            ddlSinif.Items.Insert(0, "Select Sinif");
        }
        protected void ddlSinif_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sinifId = ddlSinif.SelectedValue;
            DataTable dt = fn.Fetch("Select * from Ders where SinifId  ='" + sinifId + "' ");
            ddlDers.DataSource = dt;
            ddlDers.DataTextField = "DersIsmi";
            ddlDers.DataValueField = "DersId";
            ddlDers.DataBind();
            ddlDers.Items.Insert(0, "Select Ders");
        }

        private void GetDersGideri()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], e.DersGideriId, e.SinifId, c.SinifIsmi, e.DersId,
                s.DersIsmi, e.UcretTutari from DersGideri e inner join Sinif c on e.SinifId = c.SinifId
                inner join  Ders s on e.DersId = s.DersId");
                
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {

            try
            {
                string sinifId = ddlSinif.SelectedValue;
                string dersId = ddlDers.SelectedValue;
                string UcretTutr = txtDersGideriUcrt.Text.Trim();
                DataTable dt = fn.Fetch("Select * from DersGideri where SinifId = '" + sinifId + "'and  DersId = '" + dersId + "' or UcretTutari ='" + UcretTutr + "' ");
                if (dt.Rows.Count == 0)
                {
                    string query = "Insert into DersGideri values('" + sinifId + "','" + dersId + "','" + UcretTutr + "')";
                    fn.Query(query);
                    lblMsg.Text = "Başarıyla Eklendi!";
                    lblMsg.CssClass = "uyarı uyarısı başarılı";
                    ddlSinif.SelectedIndex = 0;
                    ddlDers.SelectedIndex = 0;
                    txtDersGideriUcrt.Text = string.Empty;
                    GetDersGideri();

                }
                else
                {
                    lblMsg.Text = "Girilen <b>Data</b> zaten var. ";
                    lblMsg.CssClass = "uyarı-tehlike";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetDersGideri();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetDersGideri();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int dersgideriId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("Delete from DersGideri where DersGideriId = '" + dersgideriId + "' ");
                lblMsg.Text = "Ders Gideri Başarıyla Silindi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetDersGideri();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetDersGideri();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int dersgideriId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string sinifId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlSinifGv")).SelectedValue;
                string dersId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlDersGv")).SelectedValue;
                string UcretTutr= (row.FindControl("txtDersGideriUcrt") as TextBox).Text.Trim();
                fn.Query(@"Update DersGideri set SinifId ='" + sinifId + "', DersId = '"
                    + dersId + "', UcretTutari ='" + UcretTutr + "' "
                    + "     where DersGideriId ='" + dersgideriId + "' ");
                lblMsg.Text = "Kayıt Başarıyla Güncellendi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetDersGideri();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        protected void ddlSinifGv_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlSinifSelected = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlSinifSelected.NamingContainer;
            if (row != null)
            {
                if ((row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlDersGV = (DropDownList)row.FindControl("ddlDersGv");
                    DataTable dt = fn.Fetch("Select * from Ders where SinifId = '" + ddlSinifSelected.SelectedValue + "' ");
                    ddlDersGV.DataSource = dt;
                    ddlDersGV.DataTextField = "DersIsmi";
                    ddlDersGV.DataValueField = "DersId";
                    ddlDersGV.DataBind();
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlSinif = (DropDownList)e.Row.FindControl("ddlSinifGv");
                    DropDownList ddlDers = (DropDownList)e.Row.FindControl("ddlDersGv");
                    DataTable dt = fn.Fetch("Select * from Ders where SinifId = '" + ddlSinif.SelectedValue + "' ");
                    ddlDers.DataSource = dt;
                    ddlDers.DataTextField = "DersIsmi";
                    ddlDers.DataValueField = "DersId";
                    ddlDers.DataBind();
                    ddlDers.Items.Insert(0, "Select Ders");  
                    string selectedSinif = DataBinder.Eval(e.Row.DataItem, "DersIsmi").ToString();
                    ddlDers.Items.FindByText(selectedSinif).Selected = true;
                }
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}