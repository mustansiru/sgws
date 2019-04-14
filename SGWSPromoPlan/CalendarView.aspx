<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CalendarView.aspx.cs" Inherits="CalendarView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .container {
            margin: 0px;
            width: 100%;
        }
    </style>
    <div class="container">

    
    <div class="row">
        <div class="col-md-6">
            <div class="row">

                    <%--<asp:Label ID="Label1" runat="server" Text="Select a Supplier:"></asp:Label>--%>
                    <asp:dropdownlist id="ddlSuppliers" runat="server">
                    </asp:dropdownlist>
                    OR
                    <asp:dropdownlist id="ddlBrands" runat="server">
                    </asp:dropdownlist>

                    <asp:button id="btnPopulate" runat="server" text="Populate" cssclass="btn btn-primary" onclick="btnPopulate_Click" />
                    <br />

            </div>
        </div>
    </div>
    <div class="row">
        <asp:Label runat="server" ID="errMessage" Visible="False" ForeColor="Red"></asp:Label>
    </div>
    </div>
    <div class="clearfix"></div>
    <div>&nbsp;</div>
    <div class="container">
    <div class="row">
        <style type="text/css">
            table tr th {
                text-align:center;
                padding: 4px;
            }

            .pagination-ys {
                /*display: inline-block;*/
                padding-left: 0;
                margin: 20px 0;
                border-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td {
                display: inline;
            }
 
            .pagination-ys table > tbody > tr > td > a,
            .pagination-ys table > tbody > tr > td > span {
                position: relative;
                float: left;
                padding: 8px 12px;
                line-height: 1.42857143;
                text-decoration: none;
                color: #dd4814;
                background-color: #ffffff;
                border: 1px solid #dddddd;
                margin-left: -1px;
            }
 
            .pagination-ys table > tbody > tr > td > span {
                position: relative;
                float: left;
                padding: 8px 12px;
                line-height: 1.42857143;
                text-decoration: none;    
                margin-left: -1px;
                z-index: 2;
                color: #aea79f;
                background-color: #f5f5f5;
                border-color: #dddddd;
                cursor: default;
            }
 
            .pagination-ys table > tbody > tr > td:first-child > a,
            .pagination-ys table > tbody > tr > td:first-child > span {
                margin-left: 0;
                border-bottom-left-radius: 4px;
                border-top-left-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td:last-child > a,
            .pagination-ys table > tbody > tr > td:last-child > span {
                border-bottom-right-radius: 4px;
                border-top-right-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td > a:hover,
            .pagination-ys table > tbody > tr > td > span:hover,
            .pagination-ys table > tbody > tr > td > a:focus,
            .pagination-ys table > tbody > tr > td > span:focus {
                color: #97310e;
                background-color: #eeeeee;
                border-color: #dddddd;
            }
        </style>    
        <asp:gridview id="gvData" runat="server" AutoGenerateColumns="False" allowpaging="True" PageSize="10" AllowSorting="True" showfooter="False" width="100%" ShowHeaderWhenEmpty="True" OnRowDataBound="gvData_RowDataBound" OnSorting="gvData_Sorting" OnPageIndexChanging="gvData_PageIndexChanging">
            <RowStyle HorizontalAlign="Center"></RowStyle>
            <EmptyDataRowStyle BackColor="#F9F9F9" /> 
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />

            
            <AlternatingRowStyle BackColor="#F9F9F9" BorderWidth="1px" /> 

            <HeaderStyle BackColor="#4F5F6F" ForeColor="#FFFFFF" Font-Bold="True"  Height="20px"/>
            
            <Columns>
                <asp:BoundField DataField="Code" HeaderText="Province" SortExpression="Code" />
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" />
                <asp:BoundField DataField="AlternateName" HeaderText="Product Description" SortExpression="AlternateName" />
                <asp:BoundField DataField="ContainerVolume" HeaderText="Size" SortExpression="ContainerVolume" />
                <asp:BoundField DataField="SKUSpecific" HeaderText="Is SKUSpecific" SortExpression="SKUSpecific" />
                <asp:BoundField DataField="ProgramType" HeaderText="Program Type" SortExpression="ProgramType" />
                <asp:BoundField DataField="P01" HeaderText="P01 (JAN)" SortExpression="P01" />
                <asp:BoundField DataField="P02" HeaderText="P02 (FEB)" SortExpression="P02" />
                <asp:BoundField DataField="P03" HeaderText="P03 (MAR)" SortExpression="P03" />
                <asp:BoundField DataField="P04" HeaderText="P04 (APR)" SortExpression="P04" />
                <asp:BoundField DataField="P05" HeaderText="P05 (MAY)" SortExpression="P05" />
                <asp:BoundField DataField="P06" HeaderText="P06 (JUN)" SortExpression="P06" />
                <asp:BoundField DataField="P07" HeaderText="P07 (JUL)" SortExpression="P07" />
                <asp:BoundField DataField="P08" HeaderText="P08 (AUG)" SortExpression="P08" />
                <asp:BoundField DataField="P09" HeaderText="P09 (SEP)" SortExpression="P09" />
                <asp:BoundField DataField="P10" HeaderText="P10 (SEP-OCT)" SortExpression="P10" />
                <asp:BoundField DataField="P11" HeaderText="P11 (OCT)" SortExpression="P11" />
                <asp:BoundField DataField="P12" HeaderText="P12 (NOV)" SortExpression="P12" />
                <asp:BoundField DataField="P13" HeaderText="P13 (DEC)" SortExpression="P13" />

            </Columns>

        </asp:gridview>
    </div>
    </div>
</asp:Content>

