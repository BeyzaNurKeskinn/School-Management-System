<%@ Page Title="" Language="C#" MasterPageFile="~/Ogretmen/OgretmenMst.Master" AutoEventWireup="true" CodeBehind="OgretmenAnaSayfa.aspx.cs" Inherits="OkulYonetimSistemi.Ogretmen.OgretmenAnaSayfa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image:url('../Image/bg3.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h2 class="text-center">Öğretmen Ana Sayfası</h2>
        </div>
    </div>

</asp:Content>
