<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="SinifEkle.aspx.cs" Inherits="OkulYonetimSistemi.Admin.SinifEkle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Yeni Sınıf</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtSinif">Sınıf İsmi </label>
                    <asp:TextBox ID="txtSinif" runat="server" CssClass="form-control" placeholder="Sınıf İsmi Giriniz" required></asp:TextBox>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Sınıf Ekle" OnClick="btnAdd_Click" />
                    </div>
                </div>
            


             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-6">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" DataKeyNames="SinifId" AutoGenerateColumns="False"
                        EmptyDataText="Görüntülenecek Kayıt Yok!" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                        OnRowEditing="GridView1_RowEditing"  OnRowUpdating="GridView1_RowUpdating" AllowPaging="true" PageSize="4" >
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Sınıf">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSinifEdit" runat="server" Text='<%# Eval("SinifIsmi") %>' CssClass="form-control"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSinifIsmi" runat="server" Text='<%# Eval("SinifIsmi") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:CommandField CausesValidation="False" HeaderText="Operation" ShowEditButton="True" />
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                            
                     </asp:GridView>

                    </div>
                 </div>
        </div>
    </div>











</asp:Content>
