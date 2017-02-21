<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JQueryProject_37.Home" %>

<asp:Content ID="attendForm" ContentPlaceHolderID="cph_forContent" runat="server">
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/employees.js"></script>
    <div class="stsTestimonial_content">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-offset-2">
                    <div class="form-wrapper marginbot-50">
                        <div id="sendmessage">Your Data has been set. Thank you!</div>
                        <div id="errormessage"></div>
                        <form id="form1" method="post" class="contactForm">
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
                                <button type="button" class="btn btn-skin btn-block" id="btn_Save">Save</button>
                            </div>
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
