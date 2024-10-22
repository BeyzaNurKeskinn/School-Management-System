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
    public partial class Notlar : System.Web.UI.Page
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
                GetNotlar();
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
        private void GetNotlar()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], e.SinavId, e.SinifId, c.SinifIsmi, e.DersId,
                s.DersIsmi, e.OkulNo, e.ToplamNotlar, e.DigerNotlar from Sinav e inner join Sinif  c on e.SinifId = c.SinifId
                inner join  Ders s on e.DersId = s.DersId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
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


        protected void btnAdd_Click(object sender, EventArgs e)
        {

            try
            {
                string sinifId = ddlSinif.SelectedValue;
                string dersId = ddlDers.SelectedValue;
                string okulNo = txtOkulNo.Text.Trim();
                string toplamNotlar = txtToplamNotlar.Text.Trim();
                string digerNotlar = txtDigerNotlar.Text.Trim();
                DataTable dttbl = fn.Fetch(@"Select OgrenciId from Ogrenci where SinifId = '" + sinifId +
                    "'and  OkulNo = '" + okulNo + "' ");

                if (dttbl.Rows.Count > 0)
                {
                    DataTable dt = fn.Fetch(@"Select * from Sinav where SinifId = '" + sinifId +
                        "'and  DersId = '" + dersId + "' and OkulNo ='" + okulNo + "' ");
                    if (dt.Rows.Count == 0)
                    {
                        string query = "Insert into Sinav values('" + sinifId + "','" + dersId + "','" + okulNo + "','" + toplamNotlar + "','" + digerNotlar + "')";
                        fn.Query(query);
                        lblMsg.Text = "Başarıyla Eklendi!";
                        lblMsg.CssClass = "uyarı uyarısı başarılı";
                        ddlSinif.SelectedIndex = 0;
                        ddlDers.SelectedIndex = 0;
                        txtOkulNo.Text = string.Empty;
                        txtToplamNotlar.Text = string.Empty;
                        txtDigerNotlar.Text = string.Empty;
                        GetNotlar();

                    }
                    else
                    {
                        lblMsg.Text = "Girilen <b>Data</b> zaten var";
                        lblMsg.CssClass = "tehlikeli uyarı";
                    }
                }
                else
                {
                    lblMsg.Text = "Girilen OkulNo <b>"+ okulNo +"</b> Seçilen sınıf içn mevcut değil! ";
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
            GetNotlar();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetNotlar();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

            GridView1.EditIndex = e.NewEditIndex;
            GetNotlar();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int sinavId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string sinifId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlSinifGv")).SelectedValue;
                string dersId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("ddlDersGv")).SelectedValue;
                string okulNo = (row.FindControl("txtOkulNoGv") as TextBox).Text.Trim();
                string toplamNotlar = (row.FindControl("txtToplamNotlarGv") as TextBox).Text.Trim();
                string digerNotlar = (row.FindControl("txtDigerNotlarGv") as TextBox).Text.Trim();
                fn.Query(@"Update Sinav set SinifId ='" + sinifId + "', DersId = '"
                    + dersId + "', OkulNo='" + okulNo + "',ToplamNotlar = '"+toplamNotlar+"', DigerNotlar ='"+ digerNotlar +"' where SinavId ='" + sinavId + "' ");
                lblMsg.Text = "Kayıt Başarıyla Eklendi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetNotlar();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
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

    }
}