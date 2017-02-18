<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="ShowAbsence.aspx.cs" Inherits="JQueryProject_37.ShowAbsence" %>

<asp:Content ID="absentForm" ContentPlaceHolderID="cph_forContent" runat="server">
        <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        $(function () {
            $("#liabsense").addClass("active");
            $("#imgBannertext").html("Show Absence");
        });
    </script>

</asp:Content>



