<%@ Page Title="" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
		<div class="section behavior-curved">
			<h1>Contact</h1>
			<ul id="hcard-Michael-Herndon" class="details-view vcard"> 
				<li> 
					<label>name</label>      
       				<span class="fn">Michael Herndon</span> 
				</li> 
				<li> 
					<label>organization</label> 
					<a href="http://www.opensourceconnections.com" class="org">Opensource 
					Connections</a> 
				</li> 
				<li> 
					<label>email</label> 
					<a class="email" href="mailto:info@amptools.net">info@amptools.net</a> 
				</li> 
				<li> 
					<label>addresses</label> 
					<ul class="details-view adr"> 
						<li><label class="type">work</label></li> 
						<li class="street-address">609 E. Market Street, Ste. 206</li> 
						<li> 
							<span class="locality">Charlottesville</span>,
							<span class="region">Va</span> 
							<span class="postal-code">22902</span> 
						</li> 
						<li class="country-name">USA</li> 
						<li> 
							<iframe width="425" height="350" frameborder="0" scrolling="no" 
								marginheight="0" marginwidth="0" 
								src="http://maps.google.com/maps?f=q&amp;hl=en&amp;geocode=&amp;q=609+E.+Market+Street,+Ste.+206+charlottesville,+va+22902&amp;sll=37.0625,-95.677068&amp;sspn=32.610437,66.621094&amp;ie=UTF8&amp;s=AARTsJpWL8B5DhDCnCIVdxiyWfJTDwuDsw&amp;ll=38.039304,-78.47311&amp;spn=0.02366,0.036478&amp;z=14&amp;iwloc=addr&amp;output=embed"> 
							</iframe> 
							<p> 
								<small> 
									<a href="http://maps.google.com/maps?f=q&amp;hl=en&amp;geocode=&amp;q=609+E.+Market+Street,+Ste.+206+charlottesville,+va+22902&amp;sll=37.0625,-95.677068&amp;sspn=32.610437,66.621094&amp;ie=UTF8&amp;ll=38.039304,-78.47311&amp;spn=0.02366,0.036478&amp;z=14&amp;iwloc=addr&amp;source=embed"> 
										View Larger Map
									</a> 
								</small> 
							</p> 
						</li> 
					</ul> 
				</li> 
				<li> 
					<label>telephones</label> 
					<ul class="details-view telephones"> 
						<li class="tel"> 
							<label class="type">work</label> 
							<span class="value">1.888.639.4445</span> 
							<span style="display:block"> 
								(call this only if interested in consulting or contractual work)
							</span>	
						</li> 
					</ul> 
				</li> 
				<li> 
					<label>instant messaging</label> 
					<ul class="details-view ims"> 
						<li><a class="url" href="aim:goim?screenname=amptools">AIM</a></li> 
 						<li><a class="url" href="ymsgr:sendIM?amptools">YIM</a></li> 
 						<li><a class="url" href="xmpp:mherndon@amptools.net">Jabber</a></li> 
 						<li><a class="url" href="skype:michaelherndon?add">Skype</a></li> 
					</ul> 
				</li> 
				<li> 
					<span>vCard:</span> 
					<a href="/public/documents/michaelherndon.vcf"> 
					michaelherndon.vcf</a> 
				</li> 
			</ul> 
		</div> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="sidebar" runat="server">
		<% this.Html.RenderPartial("sidebar"); %>
</asp:Content>
