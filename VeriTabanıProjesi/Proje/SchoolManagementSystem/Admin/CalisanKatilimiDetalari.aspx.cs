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
    public partial class CalisanKatilimiDetalari : System.Web.UI.Page
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

                GetOgretmen();

            }
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

        protected void btnCheckAttendance_Click(object sender, EventArgs e)
        {
            DateTime date = Convert.ToDateTime(txtAy.Text);

            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], t.Isim, ta.Durumu, 
                ta.Tarih from OgretmenKatilimi ta inner join Ogretmen t on t.OgretmenId= ta.OgretmenId where DATEPART(yy,Tarih)= '" + date.Year + "' and DATEPART(M,Tarih)='" + date.Month + "' and ta.Durumu =1  and ta.OgretmenId='" + ddlOgretmen.SelectedValue + "' ");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}