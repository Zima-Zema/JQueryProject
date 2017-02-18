<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="EmployeeReport.aspx.cs" Inherits="JQueryProject_37.EmployeeReport" %>


<asp:Content ID="reportForm" ContentPlaceHolderID="cph_forContent" runat="server">
        <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        $(function () {
            $("#lireport").addClass("active");
            $("#imgBannertext").html("Show Employee Report");
        });
    </script>

</asp:Content>

