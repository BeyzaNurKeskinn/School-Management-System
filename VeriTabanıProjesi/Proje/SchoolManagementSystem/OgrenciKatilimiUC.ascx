<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OgrenciKatilimiUC.ascx.cs" Inherits="OkulYonetimSistemi.OgrenciKatilimiUC" %>

<div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>


           



            <h3 class="text-center">Öğrenci Katılımı Detayları</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlSinif">Sınıf</label>
                    <asp:DropDownList ID="ddlSinif" runat="server" AutoPostBack="true" OnSelectedIndexChanged = "ddlSinif_SelectedIndexChanged" CssClass="form-control" Height="27px" Width="131px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Sınıg gerekli."
                        ControlToValidate="ddlSinif" Display="Dynamic" ForeColor="Red" InitialValue="Sınıf Sec" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="ddlDers">Ders</label>
                   <asp:DropDownList ID="ddlDers" runat="server" CssClass="form-control" Width="132px"></asp:DropDownList>
                  
                </div>
           </div>



             <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="txtOkulNo">Okul Numarası</label>
                    <asp:TextBox  ID="txtOkulNo" runat="server" CssClass="form-control" placeholder="Öğrencinin okul No. girin"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Okul No Gerekli."
                        ControlToValidate="txtOkulNo" Display="Dynamic" ForeColor="Red"  SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtAy">Ay</label>
                   <asp:TextBox  ID="txtAy" runat="server" CssClass="form-control" TextMode="Month"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Ay gerekli."
                        ControlToValidate="txtAy" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
           </div>
            
            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnCheckAttendance" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Katılım Kontrolu" OnClick="btnCheckAttendance_Click"/>
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
                            <asp:BoundField DataField="Isim" HeaderText="İsim">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                           
                            <asp:TemplateField HeaderText="Durumu">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="label1" Text='<%# Boolean.Parse(Eval("Durumu").ToString()) ? "Mevcut" : "Mevcut Değil" %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Date" HeaderText="Tarih" DataFormatString="{0:dd MM yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                          
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                    </asp:GridView>

                    </div>
                 </div>
             
        </div>
    </div>
