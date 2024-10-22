<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="SinifGideri.aspx.cs" Inherits="OkulYonetimSistemi.Admin.SinifGideri" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
      <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Yeni Gider</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlSinif">Sınıf</label>
                    <asp:DropDownList ID="ddlSinif" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="sınıf gerekli." ControlToValidate="ddlSinif" Display="Dynamic" ForeColor="Red" InitialValue="Sınıf Seçin" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtSinifGideriTutarlari">Sınıf Gideri(Yıllık) </label>
                    <asp:TextBox ID="txtSinifGideriTutarlari" runat="server" CssClass="form-control" placeholder="Sınıf Giderini Girin" TextMode="Number" required>

                    </asp:TextBox>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Gider Ekle" OnClick="btnAdd_Click" />
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-8">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek kayıt yok!" 
                        AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"  AllowPaging="true" PageSize="4" DataKeyNames="SinifGideriId"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating">
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SinifIsmi" HeaderText="Sınıf" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Sınıf Gideri(Yıllık)">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("SinifGideriTutari") %>' CssClass="form-control"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("SinifGideriTutari") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:CommandField CausesValidation="false" HeaderText="Operation" ShowDeleteButton="True" ShowEditButton="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:CommandField>
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                    </asp:GridView>

                    </div>
                 </div>
        </div>
    </div>




</asp:Content>
