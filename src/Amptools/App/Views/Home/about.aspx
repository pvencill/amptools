<%@ Page Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutContent" ContentPlaceHolderID="main" runat="server">
    <div class="article behavior-curved">
		<h1>About Amptools</h1>
		<p>
			Amptools is basically a communications hub and sandbox for 
			prototypes, <a href="/projects">opensource projects</a>, blogging, wiki, and other 
			soon to be identified ideas and concepts.  It only serves
			one developer as of right now (myself), but that could
			easily change in the future.  
		</p>
		<p>
			A good part of this site comes from my spare time and another
			decent amount comes from <a href="http://www.opensourceconnections.com">OSC's</a> <a rel="tag" 
			href="http://en.wikipedia.org/wiki/Big_Hairy_Audacious_Goal"> BHAG (Big Hairy Audacious Goal)</a> 
			program. 
		</p>
    </div>
</asp:Content>
<asp:Content ID="sidebar" ContentPlaceHolderID="sidebar" runat="server">
	<% this.Html.RenderPartial("sidebar"); %>
</asp:Content>