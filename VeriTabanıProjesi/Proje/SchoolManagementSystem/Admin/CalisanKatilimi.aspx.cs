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
    public partial class CalisanKatilimi : System.Web.UI.Page
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
                Katilim();
            }
        }

        private void Katilim()
        {
            DataTable dt = fn.Fetch("Select OgretmenId, Isim , Telefon, Email from Ogretmen");
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            foreach(GridViewRow row in GridView1.Rows)
            {
                int ogretmenId = Convert.ToInt32(row.Cells[1].Text);
                RadioButton rb1 = (row.Cells[0].FindControl("RadioButton1") as RadioButton);
                RadioButton rb2 = (row.Cells[0].FindControl("RadioButton2") as RadioButton);
                int durumu = 0;
                if (rb1.Checked)
                {
                    durumu = 1;
                }
                else if (rb2.Checked)
                {
                    durumu = 0;
                }
                fn.Query(@"Insert into OgretmenKatilimi values ('" + ogretmenId + "','" + durumu + "'," +
                    "'" + DateTime.Now.ToString("yyyy/MM/dd") + "')");
                lblMsg.Text = " Başarıyla Eklendi!";
                lblMsg.CssClass = "uyarı uyarısı başarılı";
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString();
        }
    }
}