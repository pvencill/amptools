<%@ Page Title="amptools.net: Pursuit of Rails like Active Record for C#" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="System.Web.Mvc.ViewPage" %>
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
		

                  
			<h2 class="blog-title"><a name="7486419527659460638"></a>
				
				 Pursuit of Rails like Active Record for C#
				
				<span class="blog-byline">
				by: michael herndon, at: 6/12/2008 05:25:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>After trying <a href="http://msdn.microsoft.com/en-us/library/bb425822.aspx" rel="tag">linq to sql</a>, <a href="http://msdn.microsoft.com/en-us/library/aa697427(VS.80).aspx" rel="tag">the ado.net entity framework</a>, php's <a href="http://codeigniter.com/">code igniter</a> framework, php's <a href="http://www.cakephp.org/" rel="rel">cake framework</a>; I'm realizing how much of rails really depends on the inner workings of ruby itself to do what it is able to do.&#160; I've looked and poked around <a href="http://www.cakephp.org/" rel="rel">Castle's Active Record</a> and it does some heavy lifting, but it still seems to deviate too much from rails's version of active record.&#160; One of the key things of porting a concept, is to keep it as close as possible so that developers can rely more on the same convention without having to relearn the concept in a different domain specific language.&#160; Plus, I cringe a little when it leans too much on using <a href="http://www.hibernate.org/343.html" rel="tag">NHibernate</a>. </p>  <p>It goes back to the whole &quot;Don't make me think principle&quot;, that developers often to have to keep in mind when developing for an end user.&#160; At first, I was thinking about creating a port would be simpler using linq with either &quot;linq to sql&quot; or the currently released &quot;ado.net entity framework&quot;. After investigating, it would take a ton of invested time to either write a code generator for visual studio that would changed the way the pocos (plain old c# objects) are generated in order in corporate the changes. Also not to mention that these frameworks heavily rely on a repository pattern, that would probably cause too much pain to change for just one developer.&#160; </p>  <p>Square one?&#160; Well close enough. C# and ruby have different strengths and weaknesses. However with enough thought and using C#3.0, I think its completely possible to get something that closely resembles rails enough to give anyone who has worked with rails, something that would be familiar if they needed to work on a project in .Net.&#160; </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Active Record.aspx">Active Record</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Linq To Sql.aspx">Linq To Sql</a>, <a rel='tag' href="http://www.amptools.net/labels/Rails.aspx">Rails</a></p>
			 </div>
			 <div class="blog-footer">  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=7486419527659460638" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			<div id="comments">
				<a name="comments"></a>
				<h4>
					0 Comments:
				</h4>
				<dl id="comments-block">
					
					
				</dl>
				<p class="comment-timestamp">
					<a class="comment-link" href="http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=7486419527659460638">Post a Comment</a>
				</p>
				<p id="postfeeds"></p>
				<a name="links"></a>
				<h4>Links to this post:</h4>
				<dl id="comments-block"><script type="text/javascript" src="http://www.blogger.com/dyn-js/backlink.js?blogID=7043853799247804655&postID=7486419527659460638" charset="utf-8" defer="true">
</script>
<noscript><a href="http://blogsearch.google.com/?ui=blg&q=link%3Ahttp%3A%2F%2Fwww.amptools.net%2F2008%2F06%2Fpursuit-of-rails-like-active-record-for.aspx">See links to this post</a></noscript>
<div id="blogger-dcom-block" style="display:none">
					<dt class="comment-title">
						<span class="comment-toggler">&nbsp;</span>
						<a href="<$BlogBacklinkURL$>" rel="nofollow"><$BlogBacklinkTitle$></a> <span class="item-control blog-admin"><a style="border:none;" href="http://www.blogger.com/delete-backlink.g?blogID=7043853799247804655&amp;postID=7486419527659460638&amp;backlinkURL=%3C$BlogBacklinkURLEscaped$%3E" title="Remove Link" ><span class="delete-comment-icon">&nbsp;</span></a></span>
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
				
					<li><a href="http://www.amptools.net/2008/04/thoughts-on-developing-linq-to-sql.aspx">Thoughts on Developing a Linq To SQL Layer</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx">Gallio &amp; Mb-Unit 3 With BDD style tests, I mean sp...</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/test-posting.aspx">Simplicity</a></li>
				
			</ul>
		</div>
	
</asp:Content>