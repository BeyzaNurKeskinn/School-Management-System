<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="AdminAnaSayfa.aspx.cs" Inherits="OkulYonetimSistemi.Admin.AdminAnaSayfa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image:url('../Image/bg3.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
     
        
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
        <link href="../Content/StyleSheet1.css" rel="stylesheet" />
 <div class="container">
    <div class="row pt-5" >
    <div class="col-md-3">
      <div class="card-counter primary">
        <i class="fa fa-users"></i>
        <span class="count-numbers"><% Response.Write(Session["ogrenci"]); %></span>
        <span class="count-name">Toplam Öğrenciler</span>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card-counter danger">
        <i class="fa fa-chalkboard-teacher"></i>
        <span class="count-numbers"><% Response.Write(Session["ogretmen"]); %></span>
        <span class="count-name">Toplam Öğretmenler</span>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card-counter success">
        <i class="fa fa-building"></i>
        <span class="count-numbers"><% Response.Write(Session["sinif"]); %></span>
        <span class="count-name">Toplam Sınıflar</span>
      </div>
    </div>

    <div class="col-md-3">
      <div class="card-counter info">
        <i class="fa fa-book"></i>
        <span class="count-numbers"><% Response.Write(Session["ders"]); %></span>
        <span class="count-name">Toplam Dersler</span>
      </div>
    </div>
  </div>
</div>
    </div>

</asp:Content>
