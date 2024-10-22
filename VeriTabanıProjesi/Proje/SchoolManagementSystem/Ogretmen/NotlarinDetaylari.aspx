<%@ Page Title="" Language="C#" MasterPageFile="~/Ogretmen/OgretmenMst.Master" AutoEventWireup="true" CodeBehind="NotlarinDetaylari.aspx.cs" Inherits="OkulYonetimSistemi.Ogretmen.NotlarinDetaylari %>

<%@ Register Src="~/NotlarinDetayiKullaniciKontrolu.ascx" TagPrefix="uc" TagName="NotlarinDetayi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   <%-- <h1>New Marks Details</h1> --%>
    <uc:NotlarinDetayi runat="server" ID="NotlarinDetayi1" />

</asp:Content>
