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
    public partial class NotlarinDetayiKullaniciKontrolu : System.Web.UI.UserControl
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["admin"] == null)
            //{
            //    Response.Redirect("../Giris.aspx");
            //}

            if (!IsPostBack)
            {
                GetSinif();
                GetNotlar();
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
        private void GetNotlar()
        {
            DataTable dt = fn.Fetch(@"Select ROW_NUMBER() OVER(ORDER BY(Select 1)) as [Sr.No], e.SinavId,e.SinifId,c.SinifIsmi,
                            e.DersId,s.DersIsmi,e.OkulNo, e.ToplamNotlar,e.DigerNotlar from Sinav e
                            inner join Sinif c on c.SinifId = e.SinifId inner join Ders s on s.DersId = e.DersId");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string sinifId = ddlSinif.SelectedValue;
                string okulNo = txtOkulNo.Text.Trim();
                DataTable dt = fn.Fetch(@"Select ROW_NUMBER() OVER(ORDER BY(Select 1)) as [Sr.No], e.SinavId,e.SinifId,c.SinifIsmi,
                            e.DersId,s.DersIsmi,e.OkulNo, e.ToplamNotlar,e.DigerNotlar from Sinav e
                            inner join Sinif c on c.SinifId = e.SinifId inner join Ders s on s.DersId = e.DersId
                            where e.SinifId = '" + sinifId + "' and e.OkulNo = '" + okulNo + "' ");
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
        }
    }
}