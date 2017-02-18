<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ShowAttendance.aspx.cs" Inherits="JQueryProject_37.ShowAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_forContent" runat="server">
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        $(function () {
            $("#liattend").addClass("active");
            $("#imgBannertext").html("Show Attendance");
        });
    </script>
</asp:Content>
