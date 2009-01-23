<%@ Page Title="amptools.net" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">   
       	<link href='/Content/default/css/syntax-highlighter.css' rel="stylesheet" type="text/css" />
	<link rel="alternate" type="application/rss+xml" title="amptools.net - RSS" href="http://feeds.feedburner.com/amptoolsnet" />
	<link rel="service.post" type="application/atom+xml" title="amptools.net - Atom" href="http://www.blogger.com/feeds/7043853799247804655/posts/default" />
	<link rel="EditURI" type="application/rsd+xml" title="RSD" href="http://www.blogger.com/rsd.g?blogID=7043853799247804655" />
	<style type="text/css">
		@import url("http://www.blogger.com/css/blog_controls.css");
		@import url("http://www.blogger.com/dyn-css/authorization.css?targetBlogID=7043853799247804655");
	</style>

	<script type="text/javascript" src="http://www.blogger.com/js/backlink.js"></script>
	<script type="text/javascript" src="http://www.blogger.com/js/backlink_control.js"></script>
	<script type="text/javascript">var BL_backlinkURL = "http://www.blogger.com/dyn-js/backlink_count.js";var BL_blogId = "7043853799247804655";</script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Javascript" runat="server">
		<script type="text/javascript" src="~/javascripts/prototype.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shCore.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushCSharp.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushRuby.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushJScript.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushCss.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushSql.js"></script>
		<script type="text/javascript" src="~/javascripts/syntax-highlighter/shBrushXml.js"></script>
		<script type="text/javascript">
			//<[CDATA[
			dp.SyntaxHighlighter.HighlightAll('code'); 
			//]]>
		</script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
      
	
		<div class="left">
 			<h2 class="silver">
				&quot;Working on the complexity that is always indirectly implied by simpilicity.&quot;
			</h2>
		

                  
			<h2 class="blog-title"><a name="1989566401714559482"></a>
				
				 Sample Mixins for HttpRequestBase to use with Asp.Net MVC
				
				<span class="blog-byline">
				by: michael herndon, at: 7/16/2008 12:40:00 AM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>Being a semi avid user of rails for my day job, you tend to miss a couple of things that rails has that is not in Asp.Net's MVC framework. It is a great start and the control over the html (minus laziness of whoever ever developed their &quot;Html.DropDownList&quot; extension method, grrr INDENT YOUR NEW LINES!!), is much greater than what webforms gives you. One of the missing things that I miss is the request.xhr?, request.post?, etc methods that end to be helpful when deciding if this is an AJAX call or an actual action call to return the correct page. </p>  <p>So how do you determine if the request is an ajax request or just a regular page request. What about enforcing that a page is SSL?&#160; What about doing different things depending if the request is a GET or POST?&#160; </p>  <p>So after some googling about headers, rails, and such: here are the first go around of extension methods for HttpRequestBase that should come in handy. </p>  <pre class="code csharp">public static class ControllerMixins
{

		public static bool IsPost(this HttpRequestBase obj)
		{
			return obj.Headers[&quot;REQUEST_METHOD&quot;].ToLower() == &quot;post&quot;;
		}

		public static bool IsGet(this HttpRequestBase obj)
		{
			return obj.Headers[&quot;REQUEST_METHOD&quot;].ToLower() == &quot;get&quot;;
		}

		public static bool IsXhr(this HttpRequestBase obj)
		{
			string value = obj.Headers[&quot;HTTP_X_REQUESTED_WITH&quot;];
			return (!string.IsNullOrEmpty(value) &amp;&amp; value.ToLower() == &quot;xmlhttprequest&quot;);
		}

		public static bool IsSSL(this HttpRequestBase obj)
		{
			return obj.Headers[&quot;HTTPS&quot;] == &quot;on&quot; ||
				obj.Headers[&quot;'HTTP_X_FORWARDED_PROTO'&quot;] == &quot;https&quot;;
		}
}</pre>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Asp.Net.aspx">Asp.Net</a>, <a rel='tag' href="http://www.amptools.net/labels/Asp.Net Mvc.aspx">Asp.Net Mvc</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Mixins.aspx">Mixins</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1989566401714559482"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1989566401714559482;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/07/sample-mixins-for-httprequestbase-to.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=1989566401714559482" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			
		</div>
		<div class="right">
			<h3>
				Connect
			</h3>
			<ul>
				<li>
					<a href="http://www.twitter.com/michaelherndon">
						<img src="/content/images/twitter-badge.png" alt="Twitter badge" /> 
					</a>
				</li>
				<li>
					<a href="http://www.facebook.com/profile.php?id=824905532">
						<img src="/content/images/facebook-badge.png" alt="Facebook badge" /> 
					</a>
				</li>
				<li>
					<a href="skype:michaelherndon?add">
						<img src="http://download.skype.com/share/skypebuttons/buttons/add_green_transparent_118x23.png" alt="Add me to Skype" />
					</a>
				</li>
			</ul>
			
			<h3>
				<a href="http://feeds.feedburner.com/amptoolsnet" rel="alternate" type="application/rss+xml">
					Subscribe in a reader <img src="http://www.feedburner.com/fb/images/pub/feed-icon32x32.png" style="vertical-align:middle" alt="" />
				</a>
			</h3>
			<ul>
				<li>
				
				</li>
				<li>
					<a href="http://feeds.feedburner.com/amptoolsnet">
						<img src="http://feeds.feedburner.com/~fc/amptoolsnet?bg=990066&amp;fg=CCCCCC&amp;anim=0"  alt="" />
					</a>
				</li>
				<li>
					<a href="http://add.my.yahoo.com/rss?url=http://feeds.feedburner.com/amptoolsnet" title="amptools.net">
						<img src="http://us.i1.yimg.com/us.yimg.com/i/us/my/addtomyyahoo4.gif" alt="" />
					</a>
				</li>
				<li>
					<a href="http://fusion.google.com/add?feedurl=http://feeds.feedburner.com/amptoolsnet">
						<img src="http://buttons.googlesyndication.com/fusion/add.gif"   alt="Add to Google Reader or Homepage"/>
					</a>
				</li>
				<li>
					<a href="http://www.pageflakes.com/subscribe.aspx?url=http://feeds.feedburner.com/amptoolsnet" title="Add to Pageflakes">
						<img src="http://www.pageflakes.com/ImageFile.ashx?instanceId=Static_4&amp;fileName=ATP_blu_91x17.gif" alt="Add to Pageflakes"/>
					</a>
				</li>
				<li>
					<a href="http://www.bloglines.com/sub/http://feeds.feedburner.com/amptoolsnet" title="amptools.net" type="application/rss+xml">
						<img src="http://www.bloglines.com/images/sub_modern11.gif" alt="Subscribe in Bloglines" />
					</a>
				</li>
				<li>
					<a href="http://www.newsgator.com/ngs/subscriber/subext.aspx?url=http://feeds.feedburner.com/amptoolsnet" title="amptools.net">
						<img src="http://www.newsgator.com/images/ngsub1.gif" alt="Subscribe in NewsGator Online" />
					</a>
				</li>
			</ul>
			<h3 class="sidebar-title">
				Previous Posts
			</h3>
			<ul id="recently">
				
					<li><a href="http://www.amptools.net/2008/11/simple-log-in-amplify.aspx">Simple Log in Amplify </a></li>
				
					<li><a href="http://www.amptools.net/2008/10/gallio-and-mb-unit-release-v304.aspx">Gallio and Mb-Unit release v3.0.4</a></li>
				
					<li><a href="http://www.amptools.net/2008/10/moving-amplify-to-git-hub.aspx">Moving Amplify To Git Hub...</a></li>
				
					<li><a href="http://www.amptools.net/2008/08/getting-datadirectory-folder-in-c-sharp.aspx">Getting the |DataDirectory| folder in C sharp</a></li>
				
					<li><a href="http://www.amptools.net/2008/08/ampliy-fusion-javascript-libraries.aspx">Amplify-Fusion, JavaScript libraries compatibility...</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/amplify-wcf-twitter-api-client-library.aspx">Amplify&#39;s WCF Twitter API Client Library v0.2</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/use-c-to-determine-where-and-what.aspx">Use C# to determine where and what version of java...</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/using-wcf-to-access-flickr-json-api.aspx">Using WCF to access the Flickr JSON API</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/sample-mixins-for-httprequestbase-to.aspx">Sample Mixins for HttpRequestBase to use with Asp....</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx">Amplify&#39;s TwitterN, Yet Another C# Twitter REST AP...</a></li>
				
			</ul>
			<h3 class="sidebar-title">
				Archives
			</h3>
			<ul class="archive-list">
   				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_03_30_index.aspx">03.30.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_04_06_index.aspx">04.06.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_06_08_index.aspx">06.08.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_07_06_index.aspx">07.06.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_07_13_index.aspx">07.13.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_07_20_index.aspx">07.20.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_07_27_index.aspx">07.27.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_08_03_index.aspx">08.03.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_08_10_index.aspx">08.10.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_10_26_index.aspx">10.26.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_11_02_index.aspx">11.02.2008</a></li>
				
			</ul>
		</div>
	
</asp:Content>