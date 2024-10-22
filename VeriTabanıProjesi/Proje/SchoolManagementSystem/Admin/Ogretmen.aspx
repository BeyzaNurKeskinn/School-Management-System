<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="Ogretmen.aspx.cs" Inherits="OkulYonetimSistemi.Admin.Ogretmen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Öğretmen Ekle</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtIsim">İsim</label>
                    <asp:TextBox ID="txtIsim" runat="server" CssClass="form-control" placeholder="İsim Girin"  required> </asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="İsim, Karakterler içinde olmalıdır"
                        ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtIsim">
                    </asp:RegularExpressionValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtDoB">Doğum Tarihi</label>
                    <asp:TextBox ID="txtDoB" runat="server" CssClass="form-control" TextMode="Date"  required>

                    </asp:TextBox>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlCinsiyet">Cinsiyet</label>
                    <asp:DropDownList ID="ddlCinsiyet" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Cinsiyet Sec</asp:ListItem>
                        <asp:ListItem>Erkek</asp:ListItem>
                        <asp:ListItem>Kadın</asp:ListItem>
                        <asp:ListItem>Diğer</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Cinsiyet Gerekli!"
                            ForeColor="Red" ControlToValidate="ddlCinsiyet" Display="Dynamic" SetFocusOnError="true" InitialValue="Cinsiyet Sec"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtTelefon">Telefon No</label>
                    <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control" TextMode="Number" placeholder="10 Haneli Telefon Numarası Giriniz"   required>

                    </asp:TextBox>
                   
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Geçersiz Telefon No."
                        ForeColor="Red" ValidationExpression="[0-9]{10}" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtTelefon" >

                    </asp:RegularExpressionValidator>

                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email Girin"  TextMode="Email" required> </asp:TextBox>
                    
                </div>
                <div class="col-md-6">
                    <label for="txtSifre">Şifre</label>
                    <asp:TextBox ID="txtSifre" runat="server" CssClass="form-control" placeholder="Şifre Girin" TextMode="Password"  required>

                    </asp:TextBox>
                </div>
            </div>

             <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-12">
                    <label for="txtAdres">Adres</label>
                    <asp:TextBox ID="txtAdres" runat="server" CssClass="form-control" placeholder="Adres girin"  TextMode="MultiLine" required> </asp:TextBox>
                    
                </div>
               </div>



            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Öğretmen Ekle" OnClick="btnAdd_Click" />
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-8">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek kayıt yok!" 
                        AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"  AllowPaging="True" PageSize="4" DataKeyNames="OgretmenId"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit"  OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="İsim">
                                <EditItemTemplate>
                                     <asp:TextBox ID="txtIsim" runat="server" Text='<%# Eval("Isim") %>' CssClass="form-control" Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblIsim" runat="server" Text='<%# Eval("Isim") %>' CssClass="form-control"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Telefon">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTelefon" runat="server" Text='<%# Eval("Telefon") %>' CssClass="form-control" Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTelefon" runat="server" Text='<%# Eval("Telefon") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                             <asp:TemplateField HeaderText="Şifre">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSifre" runat="server" Text='<%# Eval("Sifre") %>' CssClass="form-control" Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSifre" runat="server" Text='<%# Eval("Sifre") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                             <asp:TemplateField HeaderText="Adres">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAdres" runat="server" Text='<%# Eval("Adres") %>' CssClass="form-control" Width="100px" TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAdres" runat="server" Text='<%# Eval("Adres") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                            <asp:CommandField CausesValidation="false" HeaderText="İşlemler" ShowEditButton="True" ShowDeleteButton="true">
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
