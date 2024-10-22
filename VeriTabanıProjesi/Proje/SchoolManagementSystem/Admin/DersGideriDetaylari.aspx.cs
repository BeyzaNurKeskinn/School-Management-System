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
    public partial class DersGideriDetaylari : System.Web.UI.Page
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
                GetDersGideriDetaylari();
            }
        }
      


       
        private void GetDersGideriDetaylari()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], e.DersGideriId, e.SinifId, c.SinifIsmi, e.DersId,
                s.DersIsmi, e.UcretTutari from DersGideri e inner join Sinif c on e.SinifId = c.SinifId
                inner join  Ders s on e.DersId = s.DersId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}