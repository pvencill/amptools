<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl" %>
	<% 
		this.Html.RenderPartial("home/social");
		this.Html.RenderPartial("home/feeds");
		this.Html.RenderPartial("home/twitter");
	%>