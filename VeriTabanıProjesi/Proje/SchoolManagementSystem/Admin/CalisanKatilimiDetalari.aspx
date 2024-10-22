<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="CalisanKatilimiDetalari.aspx.cs" Inherits="OkulYonetimSistemi.Admin.CalisanKatilimiDetalari" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Öğretmen Katılımı Detayları</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlSinif">Öğretmenler</label>
                    <label for="ddlOgretmen">Öğretmen</label>
                    <asp:DropDownList ID="ddlOgretmen" runat="server" CssClass="form-control" Height="27px" Width="131px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Öğretmen gerekli."
                        ControlToValidate="ddlOgretmen" Display="Dynamic" ForeColor="Red" InitialValue="Ogretmen Secin" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="ddlDers">Ay</label>
                    <asp:TextBox ID="txtAy" CssClass="form-control" runat="server" TextMode="Month"> </asp:TextBox>             
                 </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnCheckAttendance" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Katılımı Kontrol Et" 
                        OnClick="btnCheckAttendance_Click" />
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                     <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek kayıt yok!" 
                        AutoGenerateColumns="False">
                        <Columns>                        
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Isim" HeaderText="Isim">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <%--
                               <asp:BoundField DataField="Durumu" HeaderText="Durumu">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField> --%>
                            <asp:TemplateField HeaderText="Durumu">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="label1" Text='<%# Boolean.Parse(Eval("Durumu").ToString()) ? "Mevcut" : "Mevcut Değil" %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Tarih" HeaderText="Tarih" DataFormatString="{0:dd MM yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                          
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                    </asp:GridView>

                    </div>
                 </div>
        </div>
    </div>

</asp:Content>
