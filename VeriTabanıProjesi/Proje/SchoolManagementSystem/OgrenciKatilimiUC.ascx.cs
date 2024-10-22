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
    public partial class OgrenciKatilimiUC : System.Web.UI.UserControl
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                GetSinif();
                
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

        protected void btnCheckAttendance_Click(object sender, EventArgs e)
        {
            DataTable dt;
            DateTime tarih = Convert.ToDateTime(txtAy.Text);
            if(ddlDers.SelectedValue=="Select Ders")
            {
                dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], s.Isim, sa.Durumu, 
                sa.Tarih from OgrenciKatilimi sa inner join Ogrenci s on s.OkulNo= sa.OkulNo where sa.SinifId='"+ddlSinif.SelectedValue+"' and "+
                "sa.OkulNo= '"+ txtOkulNo.Text.Trim()+"' and DATEPART(yy,Tarih)= '" + tarih.Year + "' and " +
                "DATEPART(M,Tarih)='" + tarih.Month + "' and sa.Durumu =1");

            }
            else
            {
                dt = fn.Fetch(@"Select ROW_NUMBER() over(Order by(Select 1)) as [Sr.No], s.Isim, sa.Durumu, 
                 sa.Tarih from OgrenciKatilimi sa inner join Ogrenci s on s.OkulNo= sa.OkulNo where sa.SinifId='" + ddlSinif.SelectedValue + "' and " +
               "sa.OkulNo= '" + txtOkulNo.Text.Trim() + "' and sa.DersId='" +ddlDers.SelectedValue+ "' and" +
               " DATEPART(yy,Tarih)= '" + tarih.Year + "' and DATEPART(M,Tarih)='" + tarih.Month + "' and sa.Durumu =1");
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}