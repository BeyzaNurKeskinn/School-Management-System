<%@ Page Title="" Language="C#" MasterPageFile="~/Ogretmen/OgretmenMst.Master" AutoEventWireup="true" CodeBehind="OgrenciKatilimi.aspx.cs" Inherits="OkulYonetimSistemi.Ogretmen.OgrenciKatilimi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>

            <div class="ml-auto text-right">

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>
                        <asp:Label ID="lblTime" runat="server" Font-Bold="true"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>



            <h3 class="text-center">Öğrencilerin Katılımı</h3>

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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Ders gerekli."
                        ControlToValidate="ddlDers" Display="Dynamic" ForeColor="Red" InitialValue="Ders sec" SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </div>
           </div>

            
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Getir" OnClick="btnSubmit_Click" />
                    </div>
                </div>

             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered"
                        EmptyDataText="Görüntülenecek Kayıt Yok!"  >
                        <Columns>
                           
                            <asp:TemplateField HeaderText="Sınıf">
                                <ItemTemplate>
                                    <div class="form-check form-check-inline">
                                        <asp:RadioButton ID="RadioButton1" runat="server" Text="Mevcut" Checked="true" GroupName="katilim" CssClass="form-check-input"/>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <asp:RadioButton ID="RadioButton2" runat="server" Text="Mevcut Değil" GroupName="katilim" CssClass="form-check-input"/>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                            
                     </asp:GridView>

                    </div>
                 </div>
              <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-6 col-lg-4 col-xl-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnKatilimİsaretleme" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Katılımı İşaretleme" OnClick="btnMarkAttendance_Click"  />
                    </div>
                </div>
            
        </div>
    </div>




</asp:Content>
