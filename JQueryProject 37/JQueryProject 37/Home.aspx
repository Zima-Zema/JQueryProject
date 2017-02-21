<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JQueryProject_37.Home" %>
<asp:Content ID="attendForm" ContentPlaceHolderID="cph_forContent" runat="server">
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
        $(function () {
            //visaual effects 
            $("#lihome").addClass("active");
            $("#imgBannertext").html("Home");
            //jquery code
            var time;
            var date1="";
            var reponse;
            getDate();
            $("#sendmessage").hide();
            intervalid = setInterval(function () {
                var now = new Date();
                $("#date").val(now.toLocaleTimeString('en-GB'));
            }, 1000);
            function getDate() {
                $.ajax({
                    type: "POST",
                    url: "Save.aspx/GetCurrentDate",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        date1 = msg.d;
                    },
                    error: function (r) {
                        alert("error");
                    }
                });
            }
               
            var data = new Array();
            $.ajax({
                url: "empData.txt",
                success: function (res) {
                    reponse = res;
                    data = JSON.parse(reponse);
                    for (var i = 0; i < data.length; i++) {
                        $("#empName").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                    }
                }
            });
            
            $("#empName").change(function () {
                $("#empId").val($("#empName option:selected").val());
            });
            var obj = {};
            var m;
            $.ajax({
                url: "attendanceBook.xml",
                success: function (res) {
                    m = res;
                    //console.log($(m).find("attendanceBook").find("employee").html());
                },
                error: function () {
                    alert("error");
                }
            });
            
            $("#btn_Save").on("click", function () {
                var dayDate = $.trim(date1);
                var empId=$.trim($("#empId").val());
                var empName=$("#empName option:selected").text();
                var aTime = $.trim($("#date").val());
                var lTime = 0;
                var status = $("#attendaceType option:selected").text();
                var txt = $(m).find("attendanceBook").html();
                var employee;
                if (status == "Attendance") {
                    var found = 1;
                    if ($(m).find("employee").length == 0) {
                        employee = " <employee><currentDate>" + dayDate + "</currentDate><employeeNo>" + empId + "</employeeNo><employeName>" + empName + "</employeName><arrivalTime>" + aTime + "</arrivalTime><leaveTime>" + lTime + "</leaveTime><totalHours>" + 0 + "</totalHours></employee>";
                        found = 0;
                    }
                    else {
                        $(m).find("employee").each(function (index) {
                            {
                                var date = $.trim($(this).children("currentDate").text());
                                var id = $.trim($(this).children("employeeNo").text());
                                if (dayDate == date && empId == id) {
                                    $("#errormessage").text("Employee " + empName + " Can't Attend twice Aday");
                                    $("#errormessage").addClass("navbar-brand");
                                    found = 0;
                                    return;
                                }
                            }

                        });
                        alert(found);
                        if (found !== 0) {
                            employee = " <employee><currentDate>" + dayDate + "</currentDate><employeeNo>" + empId + "</employeeNo><employeName>" + empName + "</employeName><arrivalTime>" + aTime + "</arrivalTime><leaveTime>" + lTime + "</leaveTime><totalHours>" + 0 + "</totalHours></employee>";
                        }
                    };
                }
                else {

                }
                //for (i = 0; i < $(m).find("attendanceBook").children.length-1; i++) {
                //    var xmldate = $.trim($(m).find("attendanceBook").find("employee").eq(i).find("currentDate").html());
                //    var employeNUM = $.trim($(m).find("attendanceBook").find("employee").eq(i).find("employeeNo").html());
                //    var arrivaltime = $.trim($(m).find("attendanceBook").find("employee").eq(i).find("arrivalTime").html());
                //    var leavetime = $.trim($(m).find("attendanceBook").find("employee").eq(i).find("leaveTime").html());
                //    alert(xmldate + '*' + dayDate);
                //    if (status == "Attendance" && empId != employeNUM && xmldate==dayDate && aTime==null) {
                //        lTime = 0;
                //        var employee = "<employee><time>" + $("#date").val() + "</time><currentDate>" + dayDate + "</currentDate><employeeNo>" + empId + "</employeeNo><employeName>" + empName + "</employeName><arrivalTime>" + aTime + "</arrivalTime><leaveTime>" + lTime + "</leaveTime><totalHours>0</totalHours></employee>";
                //    }
                //    else if (status == "Attendance" && empId == employeNUM && arrivaltime != null && xmldate == dayDate) {
                //        alert("attend before");
                //        //$("$sendmessage").val("Employee had attended before");
                //    }
                //    else if (status == "Leave" && xmldate == dayDate && arrivaltime != null && empId == employeNUM && leavetime=='0') {
                //        alert("leaved");
                //        lTime = $("#date").val();
                //    }
                //    else if (status == "Leave" && xmldate == dayDate && arrivaltime != null && leavetime != null) {
                //        alert("didn't come");
                //        //$("#lblst").text = "Employee doesn't have any attendence today!! ";
                //    }
                //}
                
                $(m).find("attendanceBook").append(employee);
                var obj = {};
                obj.xmlStr = "<attendanceBook>" + $(m).find("attendanceBook").html() + "</attendanceBook>";
                obj.path = "attendanceBook.xml";
                $.ajax({
                    //url--class+method
                    url: "Save.aspx/WriteXML",
                    //shape of data that will send
                    contentType: "application/json; charset=utf-8",
                    //if not write --will send data in querystring
                    type: "POST",
                    //obj that send from text
                    data: JSON.stringify(obj),
                    //shape of data that will recevied
                    dataType: "json",
                    //success
                    success: function (respond) {
                        //alert(respond);
                        alert(respond.d);
                    },
                    //error
                    error: function () {
                        alert("go away you fool");
                    }
                });//ajax

       
       
            });
        });
    </script>
    <div class="stsTestimonial_content">
                                <div class="container">

                                    <div class="row">
                                        <div class="col-lg-8 col-md-offset-2">
                                            <div class="form-wrapper marginbot-50">
                                                <div id="sendmessage">Your Data has been sent. Thank you!</div>
                                                <div id="errormessage"></div>
                                                <form id="form1" method="post"  class="contactForm">
                                                    <div class="form-group">
                                                        <input type="text" name="Date" class="form-control" id="date" readonly="readonly" />
                                                        <%--<div class="validation"></div>--%>
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" name="id" id="empId" placeholder="Employee ID" data-msg="Please enter a valid ID" readonly="readonly" />
                                                        <div class="validation"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control" id="empName" name="test">
                                                            <option hidden="hidden">Select Employee</option>
                                                        </select>
                                                        <!--<input type="dr" class="form-control" name="subject" id="subject" placeholder="Employee Name" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />-->
                                                        <div class="validation"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control" id="attendaceType" name="test">
                                                            <option hidden="hidden">Select Status</option>
                                                            <option value="in">Attendance</option>
                                                            <option value="out">Leave</option>


                                                        </select>
                                                    </div>

                                                    <div class="text-center">
                                                        <button type="button" class="btn btn-skin btn-block" id="btn_Save">Save</button></div>
                                                </form>
                                            </div>
                                            <div class="text-center">
                                                <br>
                                                <p>
                                                </p>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
</asp:Content>