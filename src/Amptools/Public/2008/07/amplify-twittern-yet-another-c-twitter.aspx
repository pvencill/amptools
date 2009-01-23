<%@ Page Title="amptools.net: Amplify&#39;s TwitterN, Yet Another C# Twitter REST API Library" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="System.Web.Mvc.ViewPage" %>
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
		

                  
			<h2 class="blog-title"><a name="3907268195622759157"></a>
				
				 Amplify&#39;s TwitterN, Yet Another C# Twitter REST API Library
				
				<span class="blog-byline">
				by: michael herndon, at: 7/13/2008 03:08:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p><a href="http://code.google.com/p/twittern">http://code.google.com/p/twittern</a></p>  <p>I put together a C# twitter library that uses WCF's <a href="http://msdn.microsoft.com/en-us/library/system.runtime.serialization.datacontractattribute.aspx">DataContract</a> &amp; <a href="http://msdn.microsoft.com/en-us/library/system.runtime.serialization.datamemberattribute.aspx">DataMembers</a> and .Net 3.5's <a href="http://msdn.microsoft.com/en-us/library/system.runtime.serialization.json.datacontractjsonserializer.aspx">DataContractJsonSerializer</a>.&#160; Its currently in alpha stage, as I need to finish writing the tests, documentation and make a simple WPF client for twitter.&#160; I needed a twitter library for a personal &quot;secret&quot; project of mine and found that most twitter libraries do not keep up with the twitter API and break when using them. Plus they tend to go to great lengths when parsing the xml.&#160; Unfortunately I do not know if this will work on mono yet. It seems that they have &quot;<a href="http://www.mono-project.com/WCF">Olive</a>&quot;, which is mono's version of WCF and I've seen where they have a path for the &quot;DataContractJsonSerializer&quot;.&#160; If there are any one familiar enough with mono, please by all means use the code, join the project.&#160; </p>  <p>One design decision that I made was to use Json rather than xml as its more compact and less data to transfer.&#160; I used WCF because with DataContract &amp; DataMembers you can parse Json and you can name your properties the property way with Pascal Case properties and then tell wcf what attributes of json they represent. This way you don't have properties that look like ruby like &quot;screen_name&quot; or&#160; &quot;profile_sidebar_border_color&quot; in your <a href="http://martinfowler.com/eaaCatalog/dataTransferObject.html">Data Transfer Object</a> in order to deserialize the Json response from twitter. </p>  <p>&#160;</p>  <p>A basic sample of how to use the library is below. </p>  <pre class="code csharp">

using Amplify.Twitter;
using System.Security;

// ... stuff

public void Test() 
{
	SecureString password = new SecureString();
	string temp = "password";
	for (var i = 0; i &lt; temp.Length; i++)
		password.AppendChar(temp[i]);
	
	password.MakeReadOnly();
	Twitter.SetCredentials("Username", password);

	StatusService service = Twitter.CreateStatusService();
 	// or StatusService service = new StatusService("Username", password);

        List&lt;Status&gt; tweets = service.GetUserTimeline("MichaelHerndon");
}

</pre>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/DataContractJsonSerializer.aspx">DataContractJsonSerializer</a>, <a rel='tag' href="http://www.amptools.net/labels/JSON.aspx">JSON</a>, <a rel='tag' href="http://www.amptools.net/labels/REST.aspx">REST</a>, <a rel='tag' href="http://www.amptools.net/labels/Twitter.aspx">Twitter</a>, <a rel='tag' href="http://www.amptools.net/labels/WCF.aspx">WCF</a></p>
			 </div>
			 <div class="blog-footer">  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=3907268195622759157" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			<div id="comments">
				<a name="comments"></a>
				<h4>
					3 Comments:
				</h4>
				<dl id="comments-block">
					
					<dt class="comment-poster" id="c139390911459707853"><a name="c139390911459707853"></a>
						<span style="line-height:16px" class="comment-icon blogger-comment-icon"><img src="http://www.blogger.com/img/b16-rounded.gif" alt="Blogger" style="display:inline;" /></span>&nbsp;<a href="http://www.blogger.com/profile/04478286305000823638" rel="nofollow">msftguy</a> said...
					</dt>
					<dd class="comment-body">
						<p>i keep getting a 401 from twitter when i call GetFriendsTimeline() but GetUserTimeline() works fine.</p>
					</dd>
					<dd class="comment-timestamp"><a href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx?showComment=1216696680000#c139390911459707853" title="comment permalink">7/21/2008 11:18:00 PM</a>
						<span class="item-control blog-admin pid-1557148521"><a style="border:none;" href="http://www.blogger.com/delete-comment.g?blogID=7043853799247804655&postID=139390911459707853" title="Delete Comment" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dd>
					<dt class="comment-poster" id="c7087361998530217911"><a name="c7087361998530217911"></a>
						<span style="line-height:16px" class="comment-icon blogger-comment-icon"><img src="http://www.blogger.com/img/b16-rounded.gif" alt="Blogger" style="display:inline;" /></span>&nbsp;<a href="http://www.blogger.com/profile/17310931859288502137" rel="nofollow">michael herndon</a> said...
					</dt>
					<dd class="comment-body">
						<p>i'll take a look at this later today after my shift. Thanks!</p>
					</dd>
					<dd class="comment-timestamp"><a href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx?showComment=1216723200000#c7087361998530217911" title="comment permalink">7/22/2008 06:40:00 AM</a>
						<span class="item-control blog-admin pid-92452089"><a style="border:none;" href="http://www.blogger.com/delete-comment.g?blogID=7043853799247804655&postID=7087361998530217911" title="Delete Comment" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dd>
					<dt class="comment-poster" id="c6920235020468629322"><a name="c6920235020468629322"></a>
						<span style="line-height:16px" class="comment-icon blogger-comment-icon"><img src="http://www.blogger.com/img/b16-rounded.gif" alt="Blogger" style="display:inline;" /></span>&nbsp;<a href="http://www.blogger.com/profile/17310931859288502137" rel="nofollow">michael herndon</a> said...
					</dt>
					<dd class="comment-body">
						<p>if your using the Twitter.CreateStatusService, make sure you call <BR/><BR/><BR/>Twitter.SetCredentials("username", "password");  <BR/><BR/><BR/>or<BR/><BR/>are you running the tests that come with it?  if so, make sure the Username and password set in the AssemblyFixture.cs<BR/><BR/>  <BR/><BR/><BR/>                 public static readonly string Username = "Username"; <BR/> <BR/><BR/>  [FixtureSetUp]<BR/>  public void OnStartUp()<BR/>  {<BR/><BR/>   Twitter.SetCredentials(Username.ToLower(), "yourpassword"); <BR/><BR/>   AccountService service = Twitter.CreateAccountService();<BR/>   service.Verify();<BR/>  }<BR/><BR/><BR/><BR/>if those are not set, you will get a 401 unauthorized error because those urls required http basic authentication.<BR/><BR/>if this doesn't solve your problem, please let me know and send a code example of what your doing.</p>
					</dd>
					<dd class="comment-timestamp"><a href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx?showComment=1216726320000#c6920235020468629322" title="comment permalink">7/22/2008 07:32:00 AM</a>
						<span class="item-control blog-admin pid-92452089"><a style="border:none;" href="http://www.blogger.com/delete-comment.g?blogID=7043853799247804655&postID=6920235020468629322" title="Delete Comment" ><span class="delete-comment-icon">&nbsp;</span></a></span>
					</dd>
					
				</dl>
				<p class="comment-timestamp">
					<a class="comment-link" href="http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=3907268195622759157">Post a Comment</a>
				</p>
				<p id="postfeeds"></p>
				<a name="links"></a>
				<h4>Links to this post:</h4>
				<dl id="comments-block"><script type="text/javascript" src="http://www.blogger.com/dyn-js/backlink.js?blogID=7043853799247804655&postID=3907268195622759157" charset="utf-8" defer="true">
</script>
<noscript><a href="http://blogsearch.google.com/?ui=blg&q=link%3Ahttp%3A%2F%2Fwww.amptools.net%2F2008%2F07%2Famplify-twittern-yet-another-c-twitter.aspx">See links to this post</a></noscript>
<div id="blogger-dcom-block" style="display:none">
					<dt class="comment-title">
						<span class="comment-toggler">&nbsp;</span>
						<a href="<$BlogBacklinkURL$>" rel="nofollow"><$BlogBacklinkTitle$></a> <span class="item-control blog-admin"><a style="border:none;" href="http://www.blogger.com/delete-backlink.g?blogID=7043853799247804655&amp;postID=3907268195622759157&amp;backlinkURL=%3C$BlogBacklinkURLEscaped$%3E" title="Remove Link" ><span class="delete-comment-icon">&nbsp;</span></a></span>
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
				
					<li><a href="http://www.amptools.net/2008/07/determining-developmenttesting-mode-in.aspx">Determining Development/Testing Mode in .Net</a></li>
				
					<li><a href="http://www.amptools.net/2008/06/pursuit-of-rails-like-active-record-for.aspx">Pursuit of Rails like Active Record for C#</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/thoughts-on-developing-linq-to-sql.aspx">Thoughts on Developing a Linq To SQL Layer</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx">Gallio &amp; Mb-Unit 3 With BDD style tests, I mean sp...</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/test-posting.aspx">Simplicity</a></li>
				
			</ul>
		</div>
	
</asp:Content>