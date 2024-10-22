<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NotlarinDetayiKullaniciKontrolu.ascx.cs" Inherits="OkulYonetimSistemi.NotlarinDetayiKullaniciKontrolu" %>

  <div style="background-image:url('../Image/bg4.jpg'); width:100%; height:720px; background-repeat: no-repeat; background-size:cover; background-attachment:fixed;"> 
        <div class="container p-md-4 p-sm-4">
            <div>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </div>
            <h3 class="text-center">Notların Detayı</h3>

            <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">
                <div class="col-md-6">
                    <label for="ddlSinif">Sınıf</label>
                    <asp:DropDownList ID="ddlSinif" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Sınıf Gerekli." ControlToValidate="ddlSinif" Display="Dynamic" ForeColor="Red" InitialValue="Sınıf sec" SetFocusOnError="True">

                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-md-6">
                    <label for="txtOkulNo">Öğrenci Numarası</label>
                    <asp:TextBox ID="txtOkulNo" runat="server" CssClass="form-control" placeholder="Öğrenci Okul No gir"  required>

                    </asp:TextBox>
                </div>
            </div>

            <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-3 col-md-offset-2 mb-3">
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-block" BackColor="#5558C9" Text="Get Marks" OnClick="btnAdd_Click" />
                    </div>
                </div>
            
             <div class="row mb-3 mr-lg-5 ml-lg-5">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered" EmptyDataText="Görüntülenecek kayıt yok!" 
                        AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"  AllowPaging="true" PageSize="8" >
                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                                 </asp:BoundField>
                             <asp:BoundField DataField="SinavId" HeaderText="SınavId">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SinifIsmi" HeaderText="Sınıf">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="DersIsmi" HeaderText="Ders">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="OkulNo" HeaderText="Okul Numarası">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="ToplamNotlar" HeaderText="Toplam Notların Ortalaması">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="DigerNotlar" HeaderText="Diğer Notların Ortalaması">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            
                        </Columns>
                        <HeaderStyle BackColor="#5558C9" ForeColor="White" />
                    </asp:GridView>

                    </div>
                 </div>
        </div>
    </div>
