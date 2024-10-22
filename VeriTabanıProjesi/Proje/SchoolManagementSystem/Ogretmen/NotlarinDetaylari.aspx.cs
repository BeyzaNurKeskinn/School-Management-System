using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OkulYonetimSistemi.Teacher
{
    public partial class NotlarinDetaylari : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staff"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }
        }
    }
}