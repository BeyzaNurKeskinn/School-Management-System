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
    public partial class AdminAnaSayfa : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }
            else
            {
                OgrenciCount();
                OgretmenCount();
                DersCount();
                SinifCount();
            }
        }
        void OgrenciCount()
        {
            DataTable dt = fn.Fetch(" Select Count(*) from Ogrenci");
            Session["ogrenci"] = dt.Rows[0][0];
        }
        void OgretmenCount()
        {
            DataTable dt = fn.Fetch(" Select Count(*) from Ogretmen");
            Session["ogretmen"] = dt.Rows[0][0];
        }
        void SinifCount()
        {
            DataTable dt = fn.Fetch(" Select Count(*) from Sinif");
            Session["sinif"] = dt.Rows[0][0];
        }
        void DersCount()
        {
            DataTable dt = fn.Fetch(" Select Count(*) from Ders");
            Session["ders"] = dt.Rows[0][0];
        }
    }
}