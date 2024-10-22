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
    public partial class SinifEkle : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["admin"]== null)
            {
                Response.Redirect("../Giris.aspx");
            }
            if (!IsPostBack)
            {
                GetSinif();
            }


        }

        private void GetSinif()
        {
            DataTable dt= fn.Fetch("Select Row_NUMBER() over(Order by (Select 1)) as [Sr.No], SinifId, SinifIsmi from Sinif");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        

        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = fn.Fetch("Select * from Sinif where SinifIsmi = '"+txtSinif.Text.Trim() + "'");
                 if(dt.Rows.Count == 0)
                {
                    string query = "Insert into Sinif values('" + txtSinif.Text.Trim() + "')";
                    fn.Query(query);
                    lblMsg.Text = "Başarıyla eklendi!";
                    lblMsg.CssClass = "uyarı uyarısı başarılı";
                    txtSinif.Text = string.Empty;
                    GetSinif();
                
                }
                else
                {
                    lblMsg.Text = "Girilen Sınıf zaten var!";
                    lblMsg.CssClass = "uyarı-tehlike";
                }
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetSinif();
            
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetSinif();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
                GridView1.EditIndex = e.NewEditIndex;
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {

                GridViewRow row = GridView1.Rows[e.RowIndex];
                int sId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string SinifIsmi = (row.FindControl("txtSinifEdit") as TextBox).Text;
                fn.Query("Update  sinif set SinifIsmi= '" + SinifIsmi + "' where SinifId = '" + sId + "'");
                lblMsg.Text = "Sınıf Güncellemesi Başarılı!";
                lblMsg.CssClass= "uyarı uyarısı başarılı";
                GridView1.EditIndex = -1;
                GetSinif();

            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

        }
    }
}