<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="ShowAbsence.aspx.cs" Inherits="JQueryProject_37.ShowAbsence" %>

<asp:Content ID="absentForm" ContentPlaceHolderID="cph_forContent" runat="server">
    <script src="JQuery/jquery-3.1.1.js"></script>
    <link href="//cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="//cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <script>
        $(function () {
            //visualization
            $("#liabsense").addClass("active");
            $("#imgBannertext").html("Show Absence");
            //visualization
            //Zima the default data displayed for today #required 
            $.ajax({
                type: "POST",
                url: "Save.aspx/GetCurrentDate",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    $("#date").val(msg.d);
                },
                error: function (r) {
                    alert("error");
                }
            });
            //code
            
            var data;
            var m;
            $.ajax({
                url:"attendanceBook.xml",
                success: function (res) {
                    m = res;
                },
                error: function () {
                    alert("error");
                }
            });
            $.ajax({
                url: "empData.txt",
                success: function (res) {
                    reponse = res;
                    data = JSON.parse(reponse);
                }
            });
            $("#empTable").hide();
            $("#find").on("click", function (event) {
                $("#empTable").hide();
                $("#empTable > tbody").empty();
                txtdate = $("#date").val();
                for (i = 0; i < data.length; i++) {
                    var flag = 1;
                    $(m).find("employee").each(function () {
                        var id = $.trim($(this).children("employeeNo").text());
                        var date = $.trim($(this).children("currentDate").text());
                        if (date == txtdate && id == data[i].id) {
                            flag = 0;
                            return
                        }
                    });
                    if (flag == 1) {
                        $("<td>" + data[i].id + "</td><td>" + data[i].name + "</td></tr>").appendTo("#empTable>tbody");    
                    }
                }
                
                $("#empTable").DataTable();
                $(".dataTables_info").hide();
                $("#empTable").show();
            });
        });
    </script>    
    <form id="form1" runat="server">
     <input type="text" name="date" class="form-control" id="date" />
     <button type="button" class="btn btn-skin btn-block" id="find">Find</button>
        <div id="tableCont">
            <table id="empTable"><thead><tr><td>Emplyee ID</td><td>Employee Name</td></tr></thead><tbody></tbody></table>
        </div>
    </form>

</asp:Content>
