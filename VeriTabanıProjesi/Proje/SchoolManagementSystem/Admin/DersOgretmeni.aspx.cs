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
    public partial class DersOgretmeni : System.Web.UI.Page
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
                GetOgretmen();
                GetDersOgretmeni();
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

        private void GetOgretmen()
        {
            DataTable dt = fn.Fetch("Select * from Ogretmen");
            ddlOgretmen.DataSource = dt;
            ddlOgretmen.DataTextField = "Isim";
            ddlOgretmen.DataValueField = "OgretmenId";
            ddlOgretmen.DataBind();
            ddlOgretmen.Items.Insert(0, "Select Ogretmen");
        }

        private void GetDersOgretmeni()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], ts.Id, ts.SinifId, c.SinifIsmi, ts.DersId,
                s.DersIsmi, ts.OgretmenId, t.Isim from DersOgretmeni ts inner join Sinif c on ts.SinifId = c.SinifId inner join Ders s on ts.DersId = s.DersId
                inner join Ogretmen t on ts.OgretmenId = t.OgretmenId");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void ddlSinif_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sinifId = ddlSinif.SelectedValue;
            DataTable dt = fn.Fetch("Select * from Ders where SinifId  ='"+ sinifId +"' ");
            ddlDers.DataSource = dt;
            ddlDers.DataTextField = "DersIsmi";
            ddlDers.DataValueField = "DersId";
            ddlDers.DataBind();
            ddlDers.Items.Insert(0, "Select Ders");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string sinifId = ddlSinif.SelectedValue;
                string dersId = ddlDers.SelectedValue;
                string ogretmenId = ddlOgretmen.SelectedValue;
                DataTable dt = fn.Fetch("Select * from DersOgretmeni where SinifId = '" + sinifId + "'and  DersId = '" + dersId  + "' or OgretmenId ='" + ogretmenId +"' ");
                if (dt.Rows.Count == 0)
                {
                    string query = "Insert into DersOgretmeni values('" + sinifId + "','" + dersId + "','" + ogretmenId + "')";
                    fn.Query(query);
                    lblMsg.Text = "Başarıyla Eklendi!";
                    lblMsg.CssClass = "başarılı uyarı"; 
                    ddlSinif.SelectedIndex = 0;
                    ddlDers.SelectedIndex = 0;
                    ddlOgretmen.SelectedIndex = 0;
                    GetDersOgretmeni();

                }
                else
                {
                    lblMsg.Text = "Girilen <b>Teacher Subject</b> zaten var ";
                    lblMsg.CssClass = "tehlikeli uyarı";
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
            GetDersOgretmeni();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetDersOgretmeni();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetDersOgretmeni();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int dersOgretmeniId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string sinifId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlSinifGv")).SelectedValue;
                string dersId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlDersGv")).SelectedValue;
                string ogretmenId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlOgretmenGv")).SelectedValue;
                fn.Query(@"Update DersOgretmeni set SinifId ='" + sinifId + "', DersId = '"
                    + dersId + "', OgretmenId ='" + ogretmenId + "' " 
                    + "     where Id ='" + dersOgretmeniId + "' ");
                lblMsg.Text = "Kayıt Başarıyla Güncellendi!";
                lblMsg.CssClass = "başarılı uyarı";
                GridView1.EditIndex = -1;
                GetDersOgretmeni();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int dersOgretmeniId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("Delete from DersOgretmeni where Id = '" + dersOgretmeniId + "' ");
                lblMsg.Text = "Ders Öğretmeni Başarıyla Silindi!";
                lblMsg.CssClass = "başarılı uyarı";
                GridView1.EditIndex = -1;
                GetDersOgretmeni();
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
                if((row.RowState & DataControlRowState.Edit) > 0)
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
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                if((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlSinif = (DropDownList)e.Row.FindControl("ddlSinifGv");
                    DropDownList ddlDers = (DropDownList)e.Row.FindControl("ddlDersGv");
                    DataTable dt = fn.Fetch("Select * from Ders where SinifId = '" + ddlSinif.SelectedValue + "' ");
                    ddlDers.DataSource = dt;
                    ddlDers.DataTextField = "DersIsmi";
                    ddlDers.DataValueField = "DersId";
                    ddlDers.DataBind();
                    ddlDers.Items.Insert(0, "Select Ders");
                    string selectedDers = DataBinder.Eval(e.Row.DataItem, "DersIsmi").ToString();
                    ddlDers.Items.FindByText(selectedDers).Selected = true;
                }
            }
        }
    }
}