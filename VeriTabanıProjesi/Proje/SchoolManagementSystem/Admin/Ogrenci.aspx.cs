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
    public partial class Ogrenci : System.Web.UI.Page
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
                GetOgrenciler();
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
        private void GetOgrenciler()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() OVER(ORDER BY (SELECT 1)) as [Sr.No], s.OgrenciId, s.[Isim], s.DOB, s.Cinsiyet,s.Telefon,
                    s.OkulNo, s.[Adres], c.SinifId, c.SinifIsmi from Ogrenci s inner join Sinif c on c.SinifId = s.SinifId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlCinsiyet.SelectedValue != "0")
                {
                    string okulNo = txtOkulNo.Text.Trim();
                    DataTable dt = fn.Fetch("Select * from Ogrenci where SinifId = '"+ddlSinif.SelectedValue+ "' and OkulNo = '" + okulNo + "' ");
                    if (dt.Rows.Count == 0)
                    {
                        string query = "Insert into Ogrenci values('" + txtIsim.Text.Trim() + "','" + txtDoB.Text.Trim() + "','" +
                            ddlCinsiyet.SelectedValue + "','" + txtTelefon.Text.Trim() + "','" + txtOkulNo.Text.Trim() + "','" +
                            txtAdres.Text.Trim() + "','" + ddlSinif.SelectedValue + "')";
                        fn.Query(query);
                        lblMsg.Text = "Başarıyla Eklendi!";
                        lblMsg.CssClass = "uyarı uyarısı başarılı!";
                        ddlCinsiyet.SelectedIndex = 0;
                        txtIsim.Text = string.Empty;
                        txtDoB.Text = string.Empty;
                        txtTelefon.Text = string.Empty;
                        txtOkulNo.Text = string.Empty;
                        txtAdres.Text = string.Empty; 
                        ddlSinif.SelectedIndex = 0;
                        GetOgrenciler();
                    }
                    else
                    {
                        lblMsg.Text = "Girilen Okul Numarası <b>'" + okulNo + "'</b> seçilen sınıf için zaten var!";
                        lblMsg.CssClass = "tehlikeli uyarı";
                    }
                    //   



                }
                else
                {
                    lblMsg.Text = "Cinsiyet Gerekli!";
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
            GetOgrenciler();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetOgrenciler();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetOgrenciler();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int ogrenciId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);

                string isim = (row.FindControl("txtIsim") as TextBox).Text;
                string telefon = (row.FindControl("txtTelefon") as TextBox).Text;
                string okulNo = (row.FindControl("txtOkulNo") as TextBox).Text;
                string adres = (row.FindControl("txtAdres") as TextBox).Text;
                string sinifId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[4].FindControl("ddlSinif")).SelectedValue;
                fn.Query("Update Ogrenci set Isim ='" + isim.Trim() + "', Telefon = '" + telefon.Trim() + "', Adres = '" +
                    adres.Trim() + "', OkulNo = '" + okulNo.Trim() + "',SinifId = '"+sinifId+"' where OgrenciId ='" + ogrenciId + "' ");
                lblMsg.Text = "Ogrenci başarıyla güncellendi!";
                lblMsg.CssClass = "başarılı uyarı";
                GridView1.EditIndex = -1;
                GetOgrenciler();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex ==e.Row.RowIndex)
            {

                    DropDownList ddlSinif = (DropDownList)e.Row.FindControl("ddlSinif");
                    DataTable dt = fn.Fetch("Select * from Sinif");
                    ddlSinif.DataSource = dt;
                    ddlSinif.DataTextField = "SinifIsmi";
                    ddlSinif.DataValueField = "SinifId";
                    ddlSinif.DataBind();
                    ddlSinif.Items.Insert(0, "Select Sinif");
                    string selectedSinif = DataBinder.Eval(e.Row.DataItem, "SinifIsmi").ToString();
                    ddlSinif.Items.FindByText(selectedSinif).Selected = true; 
                
            }
        }
    }
}