<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JQueryProject_37.Home" %>
<asp:Content ID="attendForm" ContentPlaceHolderID="cph_forContent" runat="server">
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        $(function () {
            $("#lihome").addClass("active");
            $("#imgBannertext").html("Home");
        });
    </script>
    <div class="stsTestimonial_content">
                                <div class="container">

                                    <div class="row">
                                        <div class="col-lg-8 col-md-offset-2">
                                            <div class="form-wrapper marginbot-50">
                                                <div id="sendmessage">Your Data has been sent. Thank you!</div>
                                                <div id="errormessage"></div>
                                                <form id="contact-form" action="get" method="post" role="form" class="contactForm">
                                                    <div class="form-group">
                                                        <input type="date" name="Date" class="form-control" id="name" placeholder="Current Date" data-msg="Please enter Valid Date" />
                                                        <div class="validation"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" name="id" id="email" placeholder="Employee ID" data-msg="Please enter a valid ID" />
                                                        <div class="validation"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control" name="test">
                                                            <option hidden="hidden">select a name</option>
                                                            <option value="Cash">Haidy Hatem</option>
                                                            <option value="Draft">Abd Elazeem</option>
                                                            <option value="Cheque">Ahmed Tolemy</option>
                                                            <option value="Cheque">Ahmed Diab</option>
                                                        </select>
                                                        <!--<input type="dr" class="form-control" name="subject" id="subject" placeholder="Employee Name" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />-->
                                                        <div class="validation"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control" name="test">
                                                            <option hidden="hidden">select Status</option>
                                                            <option value="Cash">Attendance</option>
                                                            <option value="Draft">Absence</option>
                                                            <option value="Draft">Leave</option>


                                                        </select>
                                                    </div>

                                                    <div class="text-center">
                                                        <button type="submit" class="btn btn-skin btn-block" id="btnContactUs">Save</button></div>
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