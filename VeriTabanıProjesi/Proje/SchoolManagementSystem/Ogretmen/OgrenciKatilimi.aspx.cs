using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static OkulYonetimSistemi.Models.CommonFn;

namespace OkulYonetimSistemi.Ogretmen
{
    public partial class OgrenciKatilimi : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staff"] == null)
            {
                Response.Redirect("../Giris.aspx");
            }
            if (!IsPostBack)
            {
                GetSinif();
                btnKatilimİsaretleme.Visible = false;
            }
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString();
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
        protected void ddlSinif_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sinifId = ddlSinif.SelectedValue;
            DataTable dt = fn.Fetch("Select * from Ders where SinifId  ='" + sinifId + "' ");
            ddlDers.DataSource = dt;
            ddlDers.DataTextField = "DersIsmi";
            ddlDers.DataValueField = "DersId";
            ddlDers.DataBind();
            ddlDers.Items.Insert(0, "Select Ders");
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataTable dt = fn.Fetch(@"Select OgrenciId, OkulNo, Isim, Telefon from Ogrenci where SinifId= '"+ddlSinif.SelectedValue+"' ");

            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (dt.Rows.Count>0)
            {
                btnKatilimİsaretleme.Visible = true;
            }
            else
            {
                btnKatilimİsaretleme.Visible = false;
            }
        }

        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            bool isTrue = false;
            foreach (GridViewRow row in GridView1.Rows)
            {
                string okulNo =row.Cells[2].Text.Trim();
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
                fn.Query(@"Insert into OgrenciKatilimi values ('" + ddlSinif.SelectedValue + "','" + ddlDers.SelectedValue + "'," +
                    "'" +okulNo + "','" + durumu + "','" + DateTime.Now.ToString("yyyy/MM/dd") + "' )");
                isTrue = true;
               
            }
            if (isTrue)
            {
                lblMsg.Text = " Başarıyla Eklendi!";
                lblMsg.CssClass = "başarılı uyarı";
            }
            else
            {
                lblMsg.Text = " Something went wrong!";
                lblMsg.CssClass = "tehlikeli uyarı";
            }
        }
    }
}