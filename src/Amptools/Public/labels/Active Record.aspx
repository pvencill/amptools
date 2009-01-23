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
		

                  
			<h2 class="blog-title"><a name="7486419527659460638"></a>
				
				 Pursuit of Rails like Active Record for C#
				
				<span class="blog-byline">
				by: michael herndon, at: 6/12/2008 05:25:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>After trying <a href="http://msdn.microsoft.com/en-us/library/bb425822.aspx" rel="tag">linq to sql</a>, <a href="http://msdn.microsoft.com/en-us/library/aa697427(VS.80).aspx" rel="tag">the ado.net entity framework</a>, php's <a href="http://codeigniter.com/">code igniter</a> framework, php's <a href="http://www.cakephp.org/" rel="rel">cake framework</a>; I'm realizing how much of rails really depends on the inner workings of ruby itself to do what it is able to do.&#160; I've looked and poked around <a href="http://www.cakephp.org/" rel="rel">Castle's Active Record</a> and it does some heavy lifting, but it still seems to deviate too much from rails's version of active record.&#160; One of the key things of porting a concept, is to keep it as close as possible so that developers can rely more on the same convention without having to relearn the concept in a different domain specific language.&#160; Plus, I cringe a little when it leans too much on using <a href="http://www.hibernate.org/343.html" rel="tag">NHibernate</a>. </p>  <p>It goes back to the whole &quot;Don't make me think principle&quot;, that developers often to have to keep in mind when developing for an end user.&#160; At first, I was thinking about creating a port would be simpler using linq with either &quot;linq to sql&quot; or the currently released &quot;ado.net entity framework&quot;. After investigating, it would take a ton of invested time to either write a code generator for visual studio that would changed the way the pocos (plain old c# objects) are generated in order in corporate the changes. Also not to mention that these frameworks heavily rely on a repository pattern, that would probably cause too much pain to change for just one developer.&#160; </p>  <p>Square one?&#160; Well close enough. C# and ruby have different strengths and weaknesses. However with enough thought and using C#3.0, I think its completely possible to get something that closely resembles rails enough to give anyone who has worked with rails, something that would be familiar if they needed to work on a project in .Net.&#160; </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Active Record.aspx">Active Record</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Linq To Sql.aspx">Linq To Sql</a>, <a rel='tag' href="http://www.amptools.net/labels/Rails.aspx">Rails</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=7486419527659460638"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=7486419527659460638;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/06/pursuit-of-rails-like-active-record-for.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=7486419527659460638" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
			<h2 class="blog-title"><a name="1442753008958214520"></a>
				
				 Thoughts on Developing a Linq To SQL Layer
				
				<span class="blog-byline">
				by: michael herndon, at: 4/09/2008 04:46:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>Amplify is going to have a Data Namespace that will serve as a basis for dealing with data including, validation, database migrations &amp; fixtures similar to rails and even give some basic patterns to use.&#160; One of these patterns will be an Active Record pattern and another will be a Repository pattern, since the repository tends to favor <a href="http://msdn2.microsoft.com/en-us/library/bb425822.aspx">Linq to Sql.</a> </p>  <p>One of the biggest debates on <a href="http://msdn2.microsoft.com/en-us/library/bb425822.aspx" rel="tag">Linq to Sql</a> is whether or not it supports the <a href="http://www.lhotka.net/weblog/ShouldAllAppsBeNtier.aspx" rel="tag">NTier</a> scenario. Of course many people are still confusing the difference between physical Tiers and virtual layers in code (DAL is a data access layer, not a tier). Linq to Sql can support layers out of the box, depending on how the developer uses the generated objects.&#160;&#160; Linq to Sql does not support WCF out of the box and you pretty much have to really massage Linq to Sql in order work disconnected, even within a Web Environment the default tight <a href="http://www.west-wind.com/weblog/posts/162336.aspx">relationship between an object and the DataContext</a> can be a bit of a pain. Linq to Sql does follow Domain Driven Design heavily. </p>  <p>With <a href="http://www.asp.net/mvc/">Asp.Net Mvc</a> on the horizon, I think it would be proper for a Linq to Sql to have some form of an <a href="http://martinfowler.com/eaaCatalog/activeRecord.html" rel="tag">Active Record</a> harness that provides much of the same functionality as possible as the <a title="tag" href="http://wiki.rubyonrails.org/rails/pages/ActiveRecord">Rail's Active Record</a> does. Obviously c# is not ruby and a developer can not do everything the same way in c# that you can in ruby.&#160; A good reason to get as close as possible to rails api for active record is to simply help developers who know specific concept like rails active record to hit the ground running with Amplify.&#160; </p>  <p>The reason I see for doing creating an Active Record for Linq to SQL is so that you can wrap validation, business/domain logic and encapsulate it into one object, versus having to know where the separate rules are kept for data, which can create a simpler api for the developer and clue a person to in to what the domain entity is capable of and should be able to do.&#160; This would hopefully shield the developer from being tempted to do the following with Linq to Sql, which could lead to invalid data or even worse.&#160; </p>  <pre class="code csharp">	private void Bind() { // bad practice
		using(DataContext db = CreateContext()) {
 			this.datagrid.DataSource = (from o in db.Clients select o);
			this.datagrid.DataBind();
		} 
	}</pre>

<p>Which is a good reason for Amplify to help provide some basic interfaces and even base classes / wrappers for Linq. Now the question is, what do you support? Do support the linq objects that sqlmetal generates, provide your own CodeGen tool for Visual Studio?&#160; Since <a href="http://msdn2.microsoft.com/en-us/library/bb386987.aspx" rel="tag">SqlMetal</a> generates the partial on<strong><em>PropertyName</em></strong>Change methods which are crude and does not help to reduce code or really support code reuse. If you support classes that SqlMetal generates, you need to use some form of Reflection or a Linq Expression to do any kind of business rules evaluation of the incoming values.&#160; Do you create your own kind of UnitOfWork pattern and force Linq To Sql to work disconnected and keep track of your own changes, if not what is the best way of keeping track of the DataContext that your object is now tied to?&#160; </p>

<p>And if you do your own UnitOfWork pattern, you have to either add a binary timestamp or int version to the table or you have to keep the intial values of the object stashed or you have to fetch the current object in the database in order to use DataContext.GetTable&lt;T&gt;().Attach(entity, oldEntity); Not exactly what I would call very performant (yes I know, its not in the dictionary, but I like the word performant). </p>

<p>If you have any comments, suggestions, questions, feel free to drop me a line. </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Active Record.aspx">Active Record</a>, <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/Linq.aspx">Linq</a>, <a rel='tag' href="http://www.amptools.net/labels/Linq To Sql.aspx">Linq To Sql</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1442753008958214520"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1442753008958214520;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/04/thoughts-on-developing-linq-to-sql.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=1442753008958214520" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
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