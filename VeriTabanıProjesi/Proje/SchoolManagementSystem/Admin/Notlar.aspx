<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="Notlar.aspx.cs" Inherits="OkulYonetimSistemi.Admin.Notlar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Not Ekle</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlSinif">Sınıf</label>
                    <asp:DropDownList ID="ddlSinif" runat="server" AutoPostBack="true" OnSelectedIndexChanged = "ddlSinif_SelectedIndexChanged" CssClass="form-control" Height="27px" Width="131px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Sınıf Gerekli."
                        ControlToValidate="ddlSinif" Display="Dynamic" ForeColor="Red" InitialValue="Sınıf Sec" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="ddlDers">Ders</label>
                   <asp:DropDownList ID="ddlDers" runat="server" CssClass="form-control" Width="132px"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Ders Gerekli."
                        ControlToValidate="ddlDers" Display="Dynamic" ForeColor="Red" InitialValue="Ders Sec" SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </div>
           

            <div class="col-md-12 mt-2">
                    <label for="txtOkulNo">Öğrenci Okul Numarası</label>
                <asp:TextBox ID="txtOkulNo" runat="server" CssClass="form-control" placeholder="Öğrencinin Okul Numarasını Girin" 
                    required></asp:TextBox>
            </div>

                <div class="col-md-6 mt-2">
                    <label for="txtToplamNotlar">Toplam Notlar(Öğrenci Notları)</label>
                <asp:TextBox ID="txtToplamNotlar" runat="server" CssClass="form-control" placeholder="Öğrencinin Not ortalamasını girin "
                    TextMode="Number" required></asp:TextBox>
            </div>

                 <div class="col-md-6 mt-2">
                    <label for="txtDigerNotlar">Diğer Notlar</label>
                <asp:TextBox ID="txtDigerNotlar" runat="server" CssClass="form-control" placeholder="Diger Notların Ortalamasını Girin"
                    TextMode="Number" required></asp:TextBox>
            </div>

            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Not Ekle" OnClick="btnAdd_Click"/>
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek Kayıt Yok!" 
                        AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"  AllowPaging="True" PageSize="4" 
                        DataKeyNames="SinavId" OnRowCancelingEdit="GridView1_RowCancelingEdit"  OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating"  OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Sınıf">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlSinifGv" runat="server" DataSourceID="SqlDataSource1" DataTextField="SinifIsmi" 
                                        DataValueField="SinifId" SelectedValue='<%# Eval("SinifId") %>' CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSinifGv_SelectedIndexChanged" >
                                        <asp:ListItem>Sınıf Sec</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OkulYntmSystmDBConnectionString %>"
                                        SelectCommand="SELECT * FROM [Sinif]"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("SinifIsmi") %>' CssClass="form-control"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Ders">
                                <EditItemTemplate>
                                   <asp:DropDownList ID="ddlDersGv" runat="server" CssClass="form-control"></asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("DersIsmi") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Okul No">
                                <EditItemTemplate>
                                 <asp:TextBox ID="txtOkulNoGv" runat="server" CssClass="form-control" Text='<%# Eval("OkulNo") %>' TextMode="Number"></asp:TextBox>   
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("OkulNo") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Toplam Notlar">
                                <EditItemTemplate>
                                 <asp:TextBox ID="txtToplamNotlarGv" runat="server" CssClass="form-control" Text='<%# Eval("ToplamNotlar") %>' TextMode="Number"></asp:TextBox>   
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("ToplamNotlar") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Diğer Notlar">
                                <EditItemTemplate>
                                 <asp:TextBox ID="txtDigerNotlarGv" runat="server" CssClass="form-control" Text='<%# Eval("DigerNotlar") %>' TextMode="Number"></asp:TextBox>   
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("DigerNotlar") %>' ></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:CommandField CausesValidation="false" HeaderText="Operation" ShowEditButton="True">
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
