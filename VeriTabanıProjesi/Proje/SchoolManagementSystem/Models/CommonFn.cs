using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OkulYonetimSistemi.Models
{
    public class CommonFn
    {
        public class Commonfnx
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolCS"].ConnectionString);

            public void Query( string query)
            {
                if(con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand(query,con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            public System.Data.DataTable Fetch( string query)
            {
                if(con.State == ConnectionState.Closed)
                {
                    con.Open();

                }
                SqlCommand cmd = new SqlCommand(query,con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                sda.Fill(dt);
                return dt; 
            }
        }
    }
}