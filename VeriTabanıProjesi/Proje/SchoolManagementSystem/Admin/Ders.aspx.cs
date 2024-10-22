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
    public partial class Ders: System.Web.UI.Page
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
                
                GetSinif();
                GetDers();
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string sinifVal = ddlSinif.SelectedItem.Text;
                DataTable dt = fn.Fetch("Select * from Ders where SinifId = '" + ddlSinif.SelectedItem.Value + "'and  DersIsmi = '"+txtDers.Text.Trim()+"' ");
                if (dt.Rows.Count == 0)
                {
                    string query = "Insert into Ders values('" + ddlSinif.SelectedItem.Value + "','" + txtDers.Text.Trim() + "')";
                    fn.Query(query);
                    lblMsg.Text = "Başarıyla Eklendi!";
                    lblMsg.CssClass = "başarılı uyarı";
                    ddlSinif.SelectedIndex = 0;
                    txtDers.Text = string.Empty;
                    GetDers();

                }
                else
                {
                    lblMsg.Text = "Girilen ders için zaten var <b>'" + sinifVal + "'</b>";
                    lblMsg.CssClass = "tehlikeli uyarı";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        private void GetDers()
        {
            DataTable dt = fn.Fetch(@"Select Row_NUMBER() over(Order by (Select 1)) as [Sr.No], s.DersId, s.SinifId, c.SinifIsmi,
                            s.DersIsmi from Ders s inner join Sinif c on c.SinifId=s.SinifId");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetDers();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetDers();
        }




        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetDers();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int dersId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string sinifId = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[2].FindControl("DropDownList1")).SelectedValue;
                string dersIsmi = (row.FindControl("TextBox1") as TextBox).Text;
                fn.Query("Update Ders set SinifId ='" +sinifId+ "', DersIsmi = '"+ dersIsmi +"' where DersId ='" + dersId + "' ");
                lblMsg.Text = "Ders başarıyla güncellendi!";
                lblMsg.CssClass = "başarılı uyarı";
                GridView1.EditIndex = -1;
                GetDers();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}