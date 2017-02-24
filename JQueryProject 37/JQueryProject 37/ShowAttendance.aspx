<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ShowAttendance.aspx.cs" Inherits="JQueryProject_37.ShowAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_forContent" runat="server">
    <style>
        .tableDiv {
            width:1200px;
        }
    </style>
    <script src="JQuery/jquery.min.js"></script>
    <link href="//cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="//cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <script src="JQuery/ShowAttendance.js"></script>
    <form id="form1" runat="server">
        
        <div id="content" class="text-center">
            <asp:Label Text="Enter Date To Show Attenadance" runat="server" ForeColor="#669900" />
            <input type="text" name="Date" class="form-control" id="date" />
            <button type="button" class="btn btn-skin btn-block" id="btn_Find">Find</button>
        </div>
        <div id="table_div" class="tableDiv">

        </div>
    </form>
</asp:Content>
