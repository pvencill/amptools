<%@ Page Title="amptools.net: Amplify&#39;s WCF Twitter API Client Library v0.2" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="System.Web.Mvc.ViewPage" %>
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
		

                  
			<h2 class="blog-title"><a name="458120713693871790"></a>
				
				 Amplify&#39;s WCF Twitter API Client Library v0.2
				
				<span class="blog-byline">
				by: michael herndon, at: 7/28/2008 12:33:00 AM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>After some playing around with WCF and Flickr, I decided to move everything internally for the twitter library to use WCF with it's <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.servicecontractattribute.aspx">ServiceContract</a>.&#160; It was more of a pain that initially thought it would be. WCF is amazingly customizable but still has a couple of downfalls thanks to REST and people not writing their API for all technologies.&#160; </p>   <p>The biggest issue is that Twitter throws an Http 403 unknown exception when you call a page and something is incorrect in the url.&#160; Well with WCF, it throws a <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.security.messagesecurityexception.aspx">System.ServiceModel.Security.MessageSecurityException</a>, due to the url returning a status code other than 200, and it wraps the inner exceptions inside of that. </p>   <p>I'm sure there is a better way to get around this, but each proxy call is now wrapped by a try/catch in the client class methods in order to check for the <a href="http://msdn.microsoft.com/en-us/library/system.servicemodel.security.messagesecurityexception.aspx">MessageSecurityException</a>, then it checks the inner exception and determines if twitter sent back a response error message. If it does the library now throws a twitter exception with error information, otherwise you would only see the WCF exception that would mask the real issue.&#160; </p>   <p>Also I renamed the &quot;Service&quot; classes to &quot;Client&quot; seeing that is the proper term for them.&#160; The tests are now updated as well to reflect the changes.&#160; The tests are a good way of seeing of how to use the library. Last but not least, methods now return arrays instead of lists in order to be more REST friendly. </p>  <p></p>  <pre class="code csharp">using Amplify.Twitter;
using System.Security;

// ... stuff

public void Test() 
{
	try {
		string temp = &quot;password&quot;;
	
		Twitter.SetCredentials(&quot;Username&quot;, temp);

		StatusClient client = Twitter.CreateStatusClient();
 		// or StatusClient client = new StatusClient(&quot;Username&quot;, temp);

        	Status[] tweets = service.GetUserTimeline();
	} catch (TwitterException ex) {
		Log.Write(ex.ToString()); // write the twitter rest error. 
	}

}</pre>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/JSON.aspx">JSON</a>, <a rel='tag' href="http://www.amptools.net/labels/REST.aspx">REST</a>, <a rel='tag' href="http://www.amptools.net/labels/Twitter.aspx">Twitter</a>, <a rel='tag' href="http://www.amptools.net/labels/WCF.aspx">WCF</a></p>
			 </div>
			 <div class="blog-footer">  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=458120713693871790" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			<div id="comments">
				<a name="comments"></a>
				<h4>
					2 Comments:
				</h4>
				<dl id="comments-block">
					
					<dt class="comment-poster" id="c4712346130961515687"><a name="c4712346130961515687"></a>
						<span style="line-height:16px" class="comment-icon blogger-comment-icon"><img src="http://www.blogger.com/img/b16-rounded.gif" alt="Blogger" style="display:inline;" /></span>&nbsp;<a href="http://www.blogger.com/profile/04478286305000823638" rel="nofollow">msftguy</a> said...
					</dt>
					<dd class="comment-body">
						<p>i would love to see more examples of using the library. do you have an example of using the IUserClient interface?<BR/><BR/>thanks!</p>
					</dd>
					<dd class="comment-timestamp"><a href="http://www.amptools.net/2008/07/amplify-wcf-twitter-api-client-library.aspx?showComment=1219010640000#c4712346130961515687" title="comment permalink">8/17/2008 06:04:00 PM</a>
						<span class="item-control blog-admin pid-1557148521"><a style="border:none;" href="http://www.blogger.com/delete-comment.g?blogID=7043853799247804655&postID=4712346130961515687" title="Delete Comment" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dd>
					<dt class="comment-poster" id="c2035320385458963659"><a name="c2035320385458963659"></a>
						<span style="line-height:16px" class="comment-icon blogger-comment-icon"><img src="http://www.blogger.com/img/b16-rounded.gif" alt="Blogger" style="display:inline;" /></span>&nbsp;<a href="http://www.blogger.com/profile/17310931859288502137" rel="nofollow">michael herndon</a> said...
					</dt>
					<dd class="comment-body">
						<p>use cases or just the general concept?</p>
					</dd>
					<dd class="comment-timestamp"><a href="http://www.amptools.net/2008/07/amplify-wcf-twitter-api-client-library.aspx?showComment=1219330980000#c2035320385458963659" title="comment permalink">8/21/2008 11:03:00 AM</a>
						<span class="item-control blog-admin pid-92452089"><a style="border:none;" href="http://www.blogger.com/delete-comment.g?blogID=7043853799247804655&postID=2035320385458963659" title="Delete Comment" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dd>
					
				</dl>
				<p class="comment-timestamp">
					<a class="comment-link" href="http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=458120713693871790">Post a Comment</a>
				</p>
				<p id="postfeeds"></p>
				<a name="links"></a>
				<h4>Links to this post:</h4>
				<dl id="comments-block"><script type="text/javascript" src="http://www.blogger.com/dyn-js/backlink.js?blogID=7043853799247804655&postID=458120713693871790" charset="utf-8" defer="true">
</script>
<noscript><a href="http://blogsearch.google.com/?ui=blg&q=link%3Ahttp%3A%2F%2Fwww.amptools.net%2F2008%2F07%2Famplify-wcf-twitter-api-client-library.aspx">See links to this post</a></noscript>
<div id="blogger-dcom-block" style="display:none">
					<dt class="comment-title">
						<span class="comment-toggler">&nbsp;</span>
						<a href="<$BlogBacklinkURL$>" rel="nofollow"><$BlogBacklinkTitle$></a> <span class="item-control blog-admin"><a style="border:none;" href="http://www.blogger.com/delete-backlink.g?blogID=7043853799247804655&amp;postID=458120713693871790&amp;backlinkURL=%3C$BlogBacklinkURLEscaped$%3E" title="Remove Link" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dt>
					<dd class="comment-body">
						<$BlogBacklinkSnippet$>
						<br />
						<span class="comment-poster">
							<em><$I18NPostedByBacklinkAuthor$> @ <$BlogBacklinkDateTime$></em>
						</span>
					</dd></div>
<script type="text/javascript">if (typeof BL_addOnLoadEvent == 'function') { BL_addOnLoadEvent(function() { BL_writeBacklinks(); }); }</script>

				</dl>
				<p class="comment-timestamp">
					<script type="text/javascript">function BlogThis() {
Q=''; x=document; y=window;
if(x.selection) {
  Q=x.selection.createRange().text;
} else if (y.getSelection) {
  Q=y.getSelection();
} else if (x.getSelection) {
  Q=x.getSelection();
}
popw = y.open('http://www.blogger.com/blog-this.g?t=' +
  escape(Q) + '&u=' + escape(location.href) + '&n=' +
  escape(document.title),'bloggerForm',
  'scrollbars=no,width=475,height=300,top=175,left=75,status=yes,resizable=yes');
void(0);
}
</script>
<a class="comment-link" href="javascript:BlogThis();" id="b-backlink">Create a Link</a>
				</p>
				<p class="comment-timestamp">
					<a href="http://www.amptools.net/Index.aspx">&lt;&lt; Home</a>
				</p>
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
				
					<li><a href="http://www.amptools.net/2008/07/use-c-to-determine-where-and-what.aspx">Use C# to determine where and what version of java...</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/using-wcf-to-access-flickr-json-api.aspx">Using WCF to access the Flickr JSON API</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/sample-mixins-for-httprequestbase-to.aspx">Sample Mixins for HttpRequestBase to use with Asp....</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx">Amplify&#39;s TwitterN, Yet Another C# Twitter REST AP...</a></li>
				
					<li><a href="http://www.amptools.net/2008/07/determining-developmenttesting-mode-in.aspx">Determining Development/Testing Mode in .Net</a></li>
				
					<li><a href="http://www.amptools.net/2008/06/pursuit-of-rails-like-active-record-for.aspx">Pursuit of Rails like Active Record for C#</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/thoughts-on-developing-linq-to-sql.aspx">Thoughts on Developing a Linq To SQL Layer</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx">Gallio &amp; Mb-Unit 3 With BDD style tests, I mean sp...</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/test-posting.aspx">Simplicity</a></li>
				
			</ul>
		</div>
	
</asp:Content>