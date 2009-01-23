<%@ Page Title="amptools.net: 03.30.2008" Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="System.Web.Mvc.ViewPage" %>
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
		

                  
			<h2 class="blog-title"><a name="8687698153489958182"></a>
				
				 Gallio &amp; Mb-Unit 3 With BDD style tests, I mean specs
				
				<span class="blog-byline">
				by: michael herndon, at: 4/05/2008 08:49:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p><a href="http://www.amptools.net/content/users/michaelherndon/images/GallioMbUnit3withBDDstyletestsImeanspecs_11EDC/behaviordrivendevelopmentex.jpg"><img style="margin: 0px 0px 10px 25px" height="148" alt="Only sky is the limit" src="http://www.amptools.net/content/users/michaelherndon/images/GallioMbUnit3withBDDstyletestsImeanspecs_11EDC/behaviordrivendevelopmentex_thumb.jpg" width="240" align="right" /></a><a href="http://en.wikipedia.org/wiki/Behavior_Driven_Development">BDD</a>, Behavior Driven Development, is basically a fusion of <a href="ttp://en.wikipedia.org/wiki/Domain_driven_design">Domain Driven Design</a> and <a href="http://www.amptools.net/content/users/michaelherndon/images/GallioMbUnit3withBDDstyletestsImeanspecs_11EDC/behaviordrivendevelopmentex.jpg">Test Driven Development</a> (what is with you developers and your love for acronyms, I'll never know, maybe it comes from developing software in the government sector?). The basic premise has to do with business value of handing over code that is maintainable and readable specific to their domain, versus an over all process/methodology change like going from <a href="http://en.wikipedia.org/wiki/Agile_software_development">Agile</a> to <a href="http://en.wikipedia.org/wiki/Waterfall_model">Waterfall.</a> Granted projects like <a href="http://rspec.info/">Rspec</a> have added much to the overall terminology that <a href="http://dannorth.net/introducing-bdd">Dan North first came up with (Given, When, and Then).</a> BDD is an attempt at having a Domain Specific Language for code and having a mechanism that supplies the company, business, client, or whoever that must maintain that application, with what the application &quot;should&quot; do given in a certain context, i.e. specifications written in code. </p>  <p>Following to what I previously posted on the <a href="http://www.opensourceconnections.com/blog/">OSC blog</a>...with <a href="http://www.opensourceconnections.com/2008/03/19/catching-up-net-for-bdd-and-unit-testing-with-gallio-nbehave-and-moq/">ramping up .net for BDD</a>, and spending time working with <a href="http://www.gallio.org/" rel="tag">Gallio</a> and MB-Unit 3.0, and time in thought about BDD in general and how it relates to .Net, I've come to some conclusions as I want to set the standard for writing tests/specifications for both <a title="tag" href="http://code.google.com/p/amptools">Amptools</a> and <a href="http://code.google.com/p/amplify-net" rel="tag">Amplify</a>.</p>  <p>The obvious one is, <strong>c# is not ruby</strong>. <a href="http://rspec.info/" rel="tag">Rspec</a> can add keywords to ruby since ruby is a dynamic language and you can pre parse a file that is code, then execute it. C# is heavily tied to the default IDE Visual Studio for most developers and it would be a pain to create your own keywords, but at the same time, typing long sentences and having underscores in your method names that should be Pascal cased according to <a href="http://blogs.msdn.com/brada/articles/361363.aspx">MS standards</a> is just ugly.</p>  <p>Gallio makes good use of meta Attribute tags such as Mb-Unit's AuthorAttribute, CategoryAttribute, and TestsOnAttribute. Gallio's GUI client, Icarus, lets you sort by these attributes for running tests. The DescriptionAttribute however is only visible when running the reports, though it would be nice if it were readable/visible in the GUI as well. </p>  <p>Rspec has a &quot;Describe&quot; keyword that basically encapsulates description for a spec, which is often related to a class somewhere else. You can rename the TestsOnAttribute to become &quot;Describe&quot; and now you can categorize all your specs/tests that tests on a certain class. You can also Describe something in different contexts, to which the DescriptionAttribute can help you describe in what context you are using writing this specification for, which would <a href="http://rspec.info/examples.html">replace the nested &quot;describe&quot; keywords in rspec</a>. </p>  <p>Obvious Replacements would be renaming FixtureSetupAttribute to &quot;BeforeAll&quot; for Rspecs &quot;before(:all)&quot;, FixtureTearDownAttribute to &quot;AfterAll&quot;, SetupAttribute to &quot;BeforeEach&quot;, and TearDownAttribute to &quot;AfterEach&quot;. Rename the TestAttribute to &quot;It&quot;, DescriptionAttribute to &quot;Should&quot;, AuthorAttribute to &quot;By&quot;, and CategoryAttribute to &quot;Tag&quot; (since we're in that web 2.0 tag everything phase. </p>  <p>What you might end up with is something below, which is a code specification for a &quot;ValidatePresence&quot; class which comes from a localized prototyping version of Amplify that I have on my local drive.</p>  <pre class="code csharp">namespace Amplify.Data.Validation
{
	#region Using Statements
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;

	using MbUnit.Framework;

	using Describe = MbUnit.Framework.TestsOnAttribute;
	using InContext = MbUnit.Framework.DescriptionAttribute;
	using It = MbUnit.Framework.TestAttribute;
	using Should = MbUnit.Framework.DescriptionAttribute;
	using By = MbUnit.Framework.AuthorAttribute;
	using Tag = MbUnit.Framework.CategoryAttribute;
	#endregion
	
	[
 		Describe(typeof(ValidatePresence)),
 		InContext(&quot;should validate the presence of a value.&quot;),
 		Tag(&quot;Functional&quot;),
 		By(&quot;Michael Herndon&quot;, &quot;mherndon@amptools.com&quot;, &quot;www.amptools.net&quot;)
	]
	public class ValidatePresenceObject : Spec
	{
		[It, Should(&quot; have a public default constructor. &quot;)]
		public void InvokeConstructor()
		{
			ValidatePresence obj = new ValidatePresence();
			obj.ShouldNotBeNull();
  			obj.RuleName.ShouldBe(&quot;ValidatePresence&quot;);
		}

		[It, Should(&quot; validate the value passed to the object. &quot;)]
		public void ValidateValue()
		{
			ValidatePresence obj = new ValidatePresence();
			obj.DefaultValue = &quot;&quot;;
			obj.Validate(&quot;&quot;).ShouldBeFalse();
			obj.Validate(&quot;Has Value&quot;).ShouldBeTrue();

			obj.If = (value) =&gt; !string.IsNullOrEmpty((value as string));
			obj.Validate(&quot;&quot;).ShouldBeTrue();
		}
	}
}</pre>

<p>In case you are wondering where all the &quot;.Should&quot; methods are coming from, they are c# extension methods that I've created that are stemmed from Assert methods found in the typical testing library such NUnit or Mb-Unit. I was using <a href="http://nbehave.org/">NBehave</a> for the extension methods, but I didn't care for the tight coupling with Rhino Mocks, especially when I'm going to be using <a href="http://code.google.com/p/moq">Moq</a> as the Mock Object Library. </p>

<p>Now in Icarus, I can sort by TestsOn, Category and Namespace, and in the Reports generated by Gallio, I get all the above, plus the Description. Sooner or later, it would be wise to add a plugin to Gallio to generate a specification type of report, that would generate specifications for anyone would wanted to use Amplify or Amptools. </p>

<p class="blog-music">currently listenting to.. <a class="artist" href="http://www.last.fm/music/D12/">D12</a> on <a class="album" href="http://www.last.fm/music/D12/Devil's+Night/">Devil's Night</a> performing <a class="track" href="http://www.last.fm/music/D12/_/Purple+Pills/">Purple Pills</a></p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BDD.aspx">BDD</a>, <a rel='tag' href="http://www.amptools.net/labels/Behavior Driven Development.aspx">Behavior Driven Development</a>, <a rel='tag' href="http://www.amptools.net/labels/Gallio.aspx">Gallio</a>, <a rel='tag' href="http://www.amptools.net/labels/Mb-Unit.aspx">Mb-Unit</a>, <a rel='tag' href="http://www.amptools.net/labels/Unit Testing.aspx">Unit Testing</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8687698153489958182"location.href=http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8687698153489958182;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=8687698153489958182" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
			<h2 class="blog-title"><a name="899658933881345685"></a>
				
				 Simplicity
				
				<span class="blog-byline">
				by: michael herndon, at: 4/04/2008 05:50:00 AM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<blockquote>   <span class="quote">Working on the complexity that is always indirectly implied by simplicity.</span>  </blockquote>  <p>Simplicity. <em>&quot;Simplicity is the property, condition, or quality of being simple or un-combined. It often denotes beauty, purity or clarity.&quot;</em> <a href="http://www.en.wikipedia.org/wiki/Simplicity">en.wikipedia.org/wiki/Simplicity</a>. It is very rare in today's world for anything to really be simple from the inside out. Often, when someone states a simple &quot;truth&quot;, we automatically understand the statement without really tracing back how much we had to learn and gain in order to obtain the complex knowledge to understand something that sounds simple when communicated out loud. </p>  <p>You probably have an idea of where I am going with this. Very few things are as simple as they seem or should be. Anyone who has worked in the software industry or any other major industry for any length of time knows how it always sounds simple when someone utters it, but that is rarely the case, because of all the implied complexity and all the details that are often not apparent in that statement.</p>  <p>I'm currently employed with <a href="http://www.opensourceconnections.com/">Opensource Connections</a>, to which one of their strongest core components is developing thought leadership. From that, stems the B.H.A.G (big, hairy, audacious goals), a project or multiple projects that develop thought leadership. Now before anyone jumps to conclusions that this site or the opensource projects that I've been working on, is just to fulfill some quota, it's not. On I've been wanting to write a .Net framework and tools that applies patterns and practices that allows&#160; underrated within the .Net community. Or the framework could be sufficient in itself. But the biggest part of this that I want to accomplish is bringing Simplicity to everything the framework touches on.</p>  <p>I'm calling the framework &quot;Amplify&quot; and the tools ... wait for it..... .....drum roll..... &quot;Amptools&quot; (ugggh naming conventions, but it beats Microsoft naming conventions). The idea in mind is that the framework and tools should amplify your project and its output. Probably the biggest way of keeping simplicity is &quot;<em>convention over configuration&quot;</em>, but that is not always plausible, so convention should offer a way to be changed to fit the developers environment. </p>  <p>Now, semi off-topic, one of the simplest ways to encourage use of other source libraries in .Net is unit testing code. However, since the concept of <a href="http://en.wikipedia.org/wiki/Behavior_Driven_Development">BDD</a> is fairly new, but seems worth exploring, I have decided to take this approach, while leveraging <a href="http://www.gallio.org/">Gallio</a>, the neutral testing platform, in its current alpha state, along with Mb-Unit 3.0. More on this in the next post. </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=899658933881345685"location.href=http://www.blogger.com/comment.g?blogID=7043853799247804655&postID=899658933881345685;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/04/test-posting.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=899658933881345685" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif"/></a></span>
				
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
				
					<li><a href="http://www.amptools.net/2008/04/thoughts-on-developing-linq-to-sql.aspx">Thoughts on Developing a Linq To SQL Layer</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx">Gallio &amp; Mb-Unit 3 With BDD style tests, I mean sp...</a></li>
				
					<li><a href="http://www.amptools.net/2008/04/test-posting.aspx">Simplicity</a></li>
				
			</ul>
			<h3 class="sidebar-title">
				Archives
			</h3>
			<ul class="archive-list">
   				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_03_30_index.aspx">03.30.2008</a></li>
				
    				<li><a href="http://www.amptools.net/blogs/michaelherndon/archives/2008_04_06_index.aspx">04.06.2008</a></li>
				
			</ul>
		</div>
	
</asp:Content>