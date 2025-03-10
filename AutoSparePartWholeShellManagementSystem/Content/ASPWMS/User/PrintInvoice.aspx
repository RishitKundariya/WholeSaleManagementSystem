﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintInvoice.aspx.cs" Inherits="Content_ASPWMS_Invoice_PrintInvoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PrinInvoice</title>
    
    <link href="<%=ResolveClientUrl("~/bootstrap/css/bootstrap.min.css")%>" rel="stylesheet"> 
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
    <script src="<%=ResolveClientUrl("~/bootstrap/js/bootstrap.min.js")%>"></script>
    <style>
        .w100 {
            width: 100%;
        }

        .w20 {
            width: 20%;
        }

        .w80 {
            width: 80%;
        }

        .auto-style1 {
            width: 918px;
        }

        .bordertlr {
            border-top: 1px solid black;
            border-left: 1px solid black;
            border-right: 1px solid black;
        }

        .borderblr {
            border-bottom: 1px solid black;
            border-left: 1px solid black;
            border-right: 1px solid black;
        }

        .borderlr {
            border-left: 1px solid black;
            border-right: 1px solid black;
        }

        .mt10 {
            margin-top: 1rem
        }

        .mb10 {
            margin-bottom: 1rem
        }

        .ml10 {
            margin-left: 1rem
        }

        .mr10 {
            margin-right: 1rem
        }

        body {
            font-size: 0.7rem;
        }

       .fontst {
            font-family: sans-serif;
            font-weight: 550;
            font-size: 1.2rem;
        }

        .fontsi {
            font-size: 1.7rem;
            font-family: sans-serif;
            font-weight: 600;
            line-height:4rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row" id="invoice">
                <div class="col-md-12">
                    <div class="row" style="margin-bottom: 2rem;margin-left:2rem;margin-right:2rem;">
                        <div class="col-md-5 " style="text-align:left;">
                             <span style="font-size:4rem;font-weight:700;" > ASPWMS </span><br />
                           <span style="font-size:1.5rem;font-weight:600;">   Rajkot, Gujrat, India - 360005 </span><br />
                            <span style="font-size:1.5rem;font-weight:600;">   Email : wms.p2r@gmail.com </span><br />
                            <span style="font-size:1.5rem;font-weight:600;">   Mobile No : 9428049058 </span><br />
                        </div>
                        <div class="offset-3 col-md-4 text-center">
                                        <span style="font-size:4rem;font-weight:700"> Invoice </span>
                        </div>
                    </div>
                    <hr style="height:0.01px;font-weight:800;border:3px solid black;background-color:black;margin-bottom:3rem;"/>

                    <div class="row bordertlr mt10 ml10 mr10 fontsi" style="border-bottom: 1px solid black">
                        <div class="col-md-6">
                            <b>M/S :</b>
                            <asp:Label ID="lblShopName" runat="server" Text=""></asp:Label>
                        </div>

                        <div class="offset-2 col-md-4">
                            <b>Invoice No : </b>
                            <asp:Label ID="lblInvoiceID" runat="server" Text=""></asp:Label>
                        </div>

                    </div>

                    <div class="row borderlr ml10 mr10 fontsi" style="border-bottom: 1px solid black">
                        <div class="col-md-6">
                            <b>Transport Name : </b>
                            <asp:Label ID="lblTransportName" runat="server" Text=""></asp:Label>
                        </div>

                        <div class="offset-2 col-md-4">
                            <b>Date :</b>
                            <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
                        </div>

                    </div>

                    <div class="row borderblr mb10 ml10 mr10 fontsi">

                        <div class="col-md-12">
                            <b>Address :</b>
                            <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                        </div>

                    </div>


                    <div class="row fontst">
                        <div class="col-md-12 table table-responsive " style="padding:2rem;width:95%" >
                            <asp:GridView ID="gvInvoiceItemList" runat="server" GridLines="none"
                                AutoGenerateColumns="False" OnSelectedIndexChanged="gvInvoiceItemList_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr." ItemStyle-Width="7%">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Product_Name" HeaderText="Product Name" ItemStyle-Width="65%" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Qty" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" ItemStyle-Width="14%" />
                                    <asp:BoundField DataField="Total" HeaderText="Total" ItemStyle-Width="20%" />
                                </Columns>

                            </asp:GridView>
                        </div>
                    </div>


                    <div class="row ml10 mr10 mt10">
                        <div class="col-md-6" style="font-weight:500;font-size:1rem;">
                            1.Goods Ones Sold Will Not Be Taken Back.<br />
                            2.This is computer generated Invoice.<br />

                        </div>
                        <div class="col-md-3 fontsi text-right" style="text-align: justify">
                            <b>Bill Amount :</b>
                        </div>
                        <div class="col-md-3 fontsi">
                            ₹ <asp:Label ID="lblGrandTotal" runat="server"></asp:Label> 
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </form>
    <script>
        window.onload = function () {
          window.print();
           <%-- const invoice = this.document.getElementById("invoice");
            console.log(invoice);
            console.log(window);
            var name = document.getElementById('<%= lblShopName.ClientID%>').innerHTML;
            var opt = {
                margin: 0.2,
                filename: name+'.pdf',
                image: { type: 'png', quality: 1 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            };
            html2pdf().from(invoice).set(opt).save();--%>
            setTimeout("location.href = 'InvoiceList.aspx';", 00);

        }

    </script>
</body>
</html>
