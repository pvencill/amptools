<%@ Page Title="" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
			<div class="section behavior-curved">
				<h1>Wiki</h1>
				<p>
					A simple html wiki based on asp.net mvc framework 
					is currently being worked on. I know people say you should not
					roll your own, but modifying an existing framework or 
					intertwine various stacks tends to be more of a pain
					than its worth in the long run.  
				</p>
				<p>
					I doubt its going to be a hard core wiki engine, but 
					something simple enough to put html into and document
					the various opensource projects, knowledge and things
					that I run into.  
				</p>
				<p>
					<label>Deadline</label> 4/10/09
				</p>
			</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="sidebar" runat="server">
	<% this.Html.RenderPartial("sidebar"); %>
</asp:Content>
