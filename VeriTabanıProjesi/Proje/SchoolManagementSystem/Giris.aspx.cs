using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static OkulYonetimSistemi.Models.CommonFn;

namespace OkulYonetimSistemi
{
    public partial class Giris : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = inputEmail.Value.Trim();
            string sifre = inputPassword.Value.Trim();
            DataTable dt = fn.Fetch("Select * from Ogretmen where Email ='" + email + "' and sifre ='" + sifre + "'");
            if (email == "Admin" && sifre == "123")
            {
                Session["admin"] = email;
                Response.Redirect("Admin/AdminAnaSayfa.aspx");
            }
            else if (dt.Rows.Count > 0)
            {
                Session["staff"] = email;
                Response.Redirect("Ogretmen/OgretmenAnaSayfa.aspx");
            }
            else
            {
                lblMsg.Text = "Giriş Başarısız!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}