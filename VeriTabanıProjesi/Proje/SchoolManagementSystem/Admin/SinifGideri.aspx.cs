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
    public partial class SinifGideri : System.Web.UI.Page
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
                GetSinifGideri();
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string sinifVal = ddlSinif.SelectedItem.Text;
                DataTable dt = fn.Fetch("Select * from SinifGideri where SinifId = '" + ddlSinif.SelectedItem.Value + "'");
                if (dt.Rows.Count == 0)
                {
                    string query = "Insert into SinifGideri values('" + ddlSinif.SelectedItem.Value +"','"+txtSinifGideriTutarlari.Text.Trim()+ "')";
                    fn.Query(query);
                    lblMsg.Text = "Başarıyla eklendi!";
                    lblMsg.CssClass = "uyarı uyarısı başarılı";
                    ddlSinif.SelectedIndex = 0;
                    txtSinifGideriTutarlari.Text = string.Empty;
                    GetSinifGideri();

                }
                else
                {
                    lblMsg.Text = "Girilen Ücretler zaten var <b>'" + sinifVal+"'</b>";
                    lblMsg.CssClass = "uyarı-tehlike";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        private void GetSinifGideri()
        {
            DataTable dt = fn.Fetch(@"Select Row_NUMBER() over(Order by (Select 1)) as [Sr.No],f.SinifGideriId, f.SinifId, c.SinifIsmi,
                            f.SinifGideriTutari from SinifGideri f inner join Sinif c on c.SinifId=f.SinifId");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetSinifGideri();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetSinifGideri();
        }

        

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int SinifGideriId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                fn.Query("Delete from SinifGideri where SinifGideriId = '" + SinifGideriId + "' ");
                lblMsg.Text = "Sınıf Gideri Başarıyla Silindi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetSinifGideri();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetSinifGideri();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int SinifGideriId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string SinifGideriTtr = (row.FindControl("TextBox1") as TextBox).Text;
                fn.Query("Update SinifGideri set SinifGideriTutari ='" + SinifGideriTtr.Trim() + "'where SinifGideriId ='" + SinifGideriId + "' ");
                lblMsg.Text = "SinifGideri Başarıyla Güncellendi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetSinifGideri();
            }
             catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}