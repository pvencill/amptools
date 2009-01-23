<%@ Control Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewUserControl" %>
			<div class="section behavior-curved">
				<h1>twitter</h1>
				<object data="data:application/x-silverlight," 
						type="application/x-silverlight-2" width="220px" height="290px"> 
					<param name="source" value="http://www.silverlightshow.net/twitter/ClientBin/Silvester.xap"/> 
					<param name="enableHtmlAccess" value="true" />
					<param name="onerror" value="onSilverlightError" /> 
					<param name="background" value="white" /> 
					<param name="initParams" value="twitterUser=michaelherndon" /> 
					<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;"> 
						<img src="http://go.microsoft.com/fwlink/?LinkId=108181"  alt="Get Microsoft Silverlight" style="border-style: none"/> 
					</a> 
				</object>
			</div>
