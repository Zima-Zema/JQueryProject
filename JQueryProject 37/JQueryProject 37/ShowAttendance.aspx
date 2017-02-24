<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ShowAttendance.aspx.cs" Inherits="JQueryProject_37.ShowAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_forContent" runat="server">
    <style>
        .laterow{
            background-color:yellow;
        }
        .latecell {
            background-color:red;
        }
        .tableDiv {
            width:1200px;
        }
    </style>
    <script src="JQuery/jquery.min.js"></script>
    <link href="//cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="//cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>

        <script>
            $(function () {
                //visualization
                $("#liattend").addClass("active");
                $("#imgBannertext").html("Show Attendance");
                //code
                function timeToSeconds(time) {
                    timeArray = time.split(':')
                    var minutes = (timeArray[0] * 60) + (timeArray[1] * 1);
                    var seconds = (minutes * 60) + (timeArray[2] * 1);
                    return seconds;
                }
                //*************************************************
                var m;
                $.ajax({
                    url: "attendanceBook.xml",
                    success: function (res) {
                        m = res;
                    },
                    error: function () {
                        alert("error");
                    }
                });
                //*************************************************
                $('<table id="empData"><thead><tr><td>EmpID</td><td>EmpName</td><td>A.time</td><td>L.time</td><td>T.hours</td></tr></thead><tbody></tbody><tfoot></tfoot></table>').appendTo("#table_div");
                $("#empData").hide();
                $("#btn_Find").on("click", function (event) {
                    var date = $("#date").val();
                    $(m).find("employee").each(function (index) {
                        var Xmldate = $.trim($(this).children("currentDate").text());
                        var empId = $.trim($(this).children("employeeNo").text());
                        var empName = $.trim($(this).children("employeName").text());
                        var empAtt = $.trim($(this).children("arrivalTime").text());
                        var empLeft = $.trim($(this).children("leaveTime").text());
                        var totalHours = $.trim($(this).children("totalHours").text());
                        var latePoint = timeToSeconds("08:00:00");
                        var employeeAttendTime = timeToSeconds(empAtt);
                        var class1 = "latecell";
                        if (Xmldate == date) {
                            if (employeeAttendTime > latePoint) {
                                $("<tr><td>" + empId + "</td><td>" + empName + "</td><td class=" + class1 + ">" + empAtt + "</td><td>" + empLeft + "</td><td>" + totalHours + "</td></tr>").addClass("laterow").appendTo("#empData tbody");
                            }
                            else {
                                $("<tr><td>" + empId + "</td><td>" + empName + "</td><td>" + empAtt + "</td><td>" + empLeft + "</td><td>" + totalHours + "</td></tr>").appendTo("#empData tbody");
                            }
                        }
                        else {
                        }
                    });
                    $("#empData").DataTable();
                    //$(".dataTables_empty").remove();
                    //$("#empDate tbody tr").addClass("laterow");
                    $(".laterow").addBack().css({ "background-color": "yellow" });
                    $(".latecell").addBack().css({ "background-color": "red" })
                    $("#empData").show();
                    
                   
                });
                
            });
        </script>
    <form id="form1" runat="server">
        
        <div id="content" class="text-center">
            <input type="text" name="Date" class="form-control" id="date" />
            <button type="button" class="btn btn-skin btn-block" id="btn_Find">Find</button>
        </div>
        <div id="table_div" class="tableDiv">

        </div>
        
    </form>
</asp:Content>
