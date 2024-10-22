<%@ Page Title="" Language="C#" MasterPageFile="~/Ogretmen/OgretmenMst.Master" AutoEventWireup="true" CodeBehind="OgrenciKatilimiDetaylari.aspx.cs" Inherits="OkulYonetimSistemi.Ogretmen.OgrenciKatilimiDetaylari" %>

<%@ Register  Src="~/OgrenciKatilimiUC.ascx" TagPrefix="uc" TagName="OgrenciKatilimi"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <uc:OgrenciKatilimi ID="OgrenciKatilimi" runat="server" />



</asp:Content>
