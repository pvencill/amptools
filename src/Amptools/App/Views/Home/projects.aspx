<%@ Page Title="" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
	<div id="overview" class="section behavior-curved">
		<h1>Projects</h1>
		<p>
			Opensource Projects that I'm persueing in my spare time
			in order to make the world a better place.  
		</p>
	</div>
	<div id="amplify" class="section behavior-curved">
		<h1>Amplify</h1>
		<p>
		 	 A C# .net application contractual framework that aims to 
		 	 deliver a pluggable, maintainable, scalable, core well
		 	 documented framework built on top of dot net with few 
		 	 dependencies, high use of interfaces, with a clean 
		 	 intuititive api.
			
		</p>
		<p>
			<label>repository</label> <a href="http://github.com/michaelherndon/amplify/tree/master">http://github.com/michaelherndon/amplify/tree/master</a>
		</p>
	</div>
	
	<div id="twittern" class="section behavior-curved">
		<h1>Twittern</h1>
		<p>
			TwitterN is a yet another c# version of the twitter api.  It uses 
			json, wcf datacontracts, generics, and c# 3.0 to create a 
			cleaner code base. 
			
		</p>
		<p>
			<label>repository</label> <a href="http://code.google.com/p/twittern/">http://code.google.com/p/twittern/</a>
		</p>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
	<% this.Html.RenderPartial("sidebar"); %>
</asp:Content>

