<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="NotDetaylari.aspx.cs" Inherits="OkulYonetimSistemi.Admin.NotDetaylari" %>


<%@ Register Src="~/NotlarinDetayiKullaniciKontrolu.ascx" TagPrefix="uc" TagName="NotlarinDetayi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     

    <uc:NotlarinDetayi runat="server" ID="NotlarinDetayi1" />


</asp:Content>
