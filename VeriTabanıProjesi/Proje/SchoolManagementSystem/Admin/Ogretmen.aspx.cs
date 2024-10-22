
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using static OkulYonetimSistemi.Models.CommonFn;

namespace OkulYonetimSistemi.Admin
{
    public partial class Ogretmen : System.Web.UI.Page
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
                 GetOgretmenler();
                
            }

        }
        private void GetOgretmenler()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() OVER(ORDER BY (SELECT 1)) as [Sr.No], OgretmenId, [Isim] , DoB , Cinsiyet , Telefon, Email , [Adres],  [Sifre]  from Ogretmen");
                            
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlCinsiyet.SelectedValue != "0")
                {
                    string email = txtEmail.Text.Trim();
                    DataTable dt = fn.Fetch("Select * from Ogretmen where Email = '" + email + "' ");
                    if (dt.Rows.Count == 0)
                    {
                        string query = "Insert into Ogretmen values('" + txtIsim.Text.Trim() + "','" + txtDoB.Text.Trim() + "','" +
                            ddlCinsiyet.SelectedValue + "','" + txtTelefon.Text.Trim() + "','" + txtEmail.Text.Trim() + "','" +
                            txtAdres.Text.Trim() + "','" + txtSifre.Text.Trim() + "')";
                        fn.Query(query);
                        lblMsg.Text = "Başarıyla Eklendi!";
                        lblMsg.CssClass = "uyarı uyarısı başarılı!";
                        ddlCinsiyet.SelectedIndex = 0;
                        txtIsim.Text = string.Empty;
                        txtDoB.Text = string.Empty;
                        txtTelefon.Text = string.Empty;
                        txtEmail.Text = string.Empty;
                        txtAdres.Text = string.Empty;
                        txtSifre.Text = string.Empty;
                        GetOgretmenler();
                    }
                    else
                    {
                        lblMsg.Text = "Girilen <b>'" + email + "'</b> zaten var!";
                        lblMsg.CssClass = "tehlikeli uyarı!";
                    }
                    //   

                   

                }
                else
                {
                    lblMsg.Text = "Cinsiyet Gerekli!";
                    lblMsg.CssClass = "tehlikeli uyarı!";
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
            GetOgretmenler();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetOgretmenler();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetOgretmenler();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int ogretmenId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                
                string isim = (row.FindControl("txtIsim") as TextBox).Text;
                string telefon = (row.FindControl("txtTelefon") as TextBox).Text;
                string sifre = (row.FindControl("txtSifre") as TextBox).Text;
                string adres = (row.FindControl("txtAdres") as TextBox).Text;
                fn.Query("Update Ogretmen set Isim ='" + isim.Trim() + "', Telefon = '" + telefon.Trim() + "', Adres = '" +
                    adres.Trim() +"', Sifre = '" + sifre.Trim() +"' where OgretmenId ='" + ogretmenId + "' ");
                lblMsg.Text = "Ogretmen Başarıyla Güncellendi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı!";
                GridView1.EditIndex = -1;
                GetOgretmenler();
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
                int OgretmenId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("Delete from Ogretmen where OgretmenId = '" + OgretmenId + "' ");
                lblMsg.Text = "Ogretmen Başarıyla Silindi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı!";
                GridView1.EditIndex = -1;
                GetOgretmenler();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}