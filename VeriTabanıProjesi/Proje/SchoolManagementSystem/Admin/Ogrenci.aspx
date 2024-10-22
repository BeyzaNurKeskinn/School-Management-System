<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="Ogrenci.aspx.cs" Inherits="OkulYonetimSistemi.Admin.Ogrenci" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Öğrenci Ekle </h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtIsim">İsim</label>
                    <asp:TextBox ID="txtIsim" runat="server" CssClass="form-control" placeholder="İsim Gir"  required> </asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="İsim belirli karakterler arasında olmalıdır."
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
                        <asp:ListItem>E</asp:ListItem>
                        <asp:ListItem>K</asp:ListItem>
                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Cinsiyet Gerekli!"
                            ForeColor="Red" ControlToValidate="ddlCinsiyet" Display="Dynamic" SetFocusOnError="true" InitialValue="Cinsiyet Sec"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtTelefon">İletişim No</label>
                    <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control" TextMode="Number" placeholder="10 Haneli Telefon No"   required>

                    </asp:TextBox>
                   
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Geçerli Telefon No girin."
                        ForeColor="Red" ValidationExpression="[0-9]{10}" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtTelefon" >

                    </asp:RegularExpressionValidator>

                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtOkulNo">Okul Numarası</label>
                    <asp:TextBox ID="txtOkulNo" runat="server" CssClass="form-control" placeholder="Okul No Girin:" required> 
                     </asp:TextBox>
                    
                </div>
                <div class="col-md-6">
                    <label for="ddlSinif">Sınıf</label>
                    <asp:DropDownList ID="ddlSinif" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Sınıf Gerekli."
                        ControlToValidate="ddlSinif" Display="Dynamic" ForeColor="Red" InitialValue="Sınıf Sec" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
            </div>

             <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-12">
                    <label for="txtAdres">Adres</label>
                    <asp:TextBox ID="txtAdres" runat="server" CssClass="form-control" placeholder="Adres Girin"  TextMode="MultiLine" required> </asp:TextBox>
                    
                </div>
               </div>



            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Öğrenci Ekle" OnClick="btnAdd_Click" />
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-8">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek Kayıt Yok!" 
                        AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"  AllowPaging="True" PageSize="4" DataKeyNames="OgrenciId"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit"  OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating" OnRowDataBound="GridView1_RowDataBound">
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
                             
                             <asp:TemplateField HeaderText="Okul Numarası">
                                 <EditItemTemplate>
                                
                                    <asp:TextBox  ID="txtOkulNo" runat="server" Text='<%# Eval("OkulNo") %>' CssClass="form-control"
                                        Width="100px"></asp:TextBox>
                                    </EditItemTemplate>
                                 <ItemTemplate>
                                    <asp:Label ID="lblOkulNo" runat="server"  Text='<%# Eval("OkulNo") %>'></asp:Label>
                                     </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                             <asp:TemplateField HeaderText="Sınıf">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlSinif" runat="server" CssClass="form-control" Width="120px"></asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSinif" runat="server" Text='<%# Eval("SinifIsmi") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                             <asp:TemplateField HeaderText="Adres">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAdres" runat="server" Text='<%# Eval("Adres") %>' CssClass="form-control" Width="130px"
                                        TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAdres" runat="server" Text='<%# Eval("Adres") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                            <asp:CommandField CausesValidation="false" HeaderText="İşlemler" ShowEditButton="True">
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
