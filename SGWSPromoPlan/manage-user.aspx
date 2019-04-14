<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="manage-user.aspx.cs" Inherits="adminsection_manage_user" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<link href="../stylesheets/jquery.tables.css" rel="stylesheet" />
    <script src="../js/jquery.dataTables.min.js"></script>--%>
    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <style>
        .text-left-imp {
            text-align: left !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
    <div class="row" id="divfilter">
        <div class="col-md-12">
            <div class="col-md-12">
                <div class="form-group">
                    <div id="divMessage" runat="server">
                    </div>
                    <div class="padding-bottom pull-right">
                        <br />
                        <asp:HyperLink ID="hlAdd" CssClass="btn btn-primary" runat="server">
                        <i class="fa fa-plus" aria-hidden="true">&nbsp;&nbsp;</i>Add User
                        </asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="table-responsive" id="divTableContainer">
                    <table id="tblManageUsers" cellspacing="0" border="0" rules="all" class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                        <thead>
                            <tr role="row">
                                <th class="grid-heading text-left-imp" rowspan="1" colspan="1">First Name</th>
                                <th class="grid-heading text-left-imp" rowspan="1" colspan="1">Last Name</th>
                                <th class="grid-heading text-left-imp" rowspan="1" colspan="1">Email Address</th>
                                <th class="grid-heading text-left-imp" rowspan="1" colspan="1">Role</th>
                                <th class="grid-heading" rowspan="1" colspan="1">Is Active</th>
                                <th class="grid-heading" rowspan="1" colspan="1">Actions</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script>

        $(document).ready(function () {
            JqueryDatatable();
        });

        var tblDatatabletblManageUsers;
        function JqueryDatatable() {

            tblDatatabletblManageUsers = $('#tblManageUsers').dataTable({
                columns: [
                    { 'data': 'FirstName' },
                    { 'data': 'LastName' },
                    { 'data': 'Email' },
                    { 'data': 'Role' },
                    { 'data': 'IsActive', 'class': 'text-center', "orderable": false },
                    { 'data': 'Action', 'class': 'text-center', "orderable": false },
                ],
                iDisplayLength: 100,
                searching: true,
                destroy: true,
                bFilter: true,
                "bAutoWidth": false,
                "processing": true,                
                "responsive": true,
                "order": [[sortindex, sortorder]],
                "oSearch": {
                    "sSearch": searchvalue
                },
                bLengthChange: false,
                bServerSide: true,
                sAjaxSource: '../handlers/UserMasterHandler.ashx'
            });            
        }

        var searchvalue = '';
        var sortindex = 0;
        var sortorder = "asc";
        var isSearchBoxFocused = false;

        function RefillTable() {

            if ($("input[type='search']")) {
                if ($("input[type='search']")[0] != undefined) {
                    searchvalue = $("input[type='search']")[0].value
                    if ($($("input[type='search']")[0]).is(':focus'))
                        isSearchBoxFocused = true;
                }
            }

            var index = 0;

            $("#tblManageUsers thead tr th").each(function () {
                if ($(this).hasClass('sorting_desc') || $(this).hasClass('sorting_asc')) {
                    if ($(this).hasClass('sorting_desc'))
                        sortorder = "desc";
                    else
                        sortorder = "asc";

                    sortindex = index;
                }
                index++;
            });
            JqueryDatatable();
        }

        function Delete(value, lnkbtnid) {
            if (confirm('Are you sure you want to delete the record?')) {
                $.ajax({
                    method: "POST",
                    url: "manage-user.aspx/DeleteRecord",
                    contentType: "application/json; charset=utf-8",
                    data: '{ UserId: "' + value + '"}',
                    success: function (data) {
                        if (data != null && data.d == true) {

                            $("#" + lnkbtnid).parent('td').parent('tr').remove();
                            $('#<%=divMessage.ClientID%>').html('<div class=\"alert alert-success\">Record deleted successfully</div>');
                        }
                        else {
                            $('#<%=divMessage.ClientID%>').html('<div class=\"alert alert-danger\">Record failed to delete</div>');
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#<%=divMessage.ClientID%>').html('<div class=\"alert alert-danger\">Record failed to delete</div>');
                    }
                });
            }
            return false;
        }
       
    </script>


</asp:Content>



