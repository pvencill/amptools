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
		

                  
			<h2 class="blog-title"><a name="1099928894407582088"></a>
				
				 Simple Log in Amplify 
				
				<span class="blog-byline">
				by: michael herndon, at: 11/02/2008 11:54:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>As many people know rails has a simple logger inside the framework which really only outputs to the console. This comes in handy to see SQL output of your models, benchmarks and other cool little things inside the rails framework.&#160; </p>  <p>Of course people in the .Net realm tend to want things that scale and yet simplified for them.&#160; So output only to the console won't fly in larger projects.&#160; There is log4net, but you don't want to have it tightly coupled to the system, this caused an issue to one project that I worked on while still working for <a href="http://www.vivussoftware.com">Vivus Software</a> before I came <a href="http://www.opensourceconnections.com">OSC</a>. Where the framework and project both expected a certain version of Log4Net and there was no wrapper to put something else in place if need be.&#160; </p>   <span id="more-0"></span>    <p>So the solution was to Build small static Log class, that takes a list of an interface ILog (different than log4net's) and then use that interface to build a wrapper around using the root Logger for log4net. This way people can still build their own loggers for amplify or build their own Appenders for Log4Net and amplify will still be able to leverage this. Of course there is also conditional symbol LOG4NET in amplify if you wish to build the amplify framework without any dependency on the log4net library.&#160;&#160; </p>  <p>To me this is more like the Console.WriteLine that is needed for a class library vs what log4net is typically used for in an application where it also spits out the type information of a class. To help with the testing using mock object is the <a href="http://code.google.com/p/moq/" rel="tag">Moq (Mock You)</a> which uses the Lambda expression and gets rid of all that crazy record/playback junk to which I loathe.&#160; </p>   <pre class="code csharp">		public void Test()
		{
			var id = 0;
			Log.Sql(&quot;SELECT * FROM test&quot;);
			Log.Debug(&quot;The id is  {0} &quot;, id);
		}		


		[It(Order = 2), Should(&quot;have a debug method that logs debug statements&quot;)]
		public void Debug()
		{
			var calls = new List&lt;string&gt;();
			var log = CreateMockLog();

			log.Expect(o =&gt; o.Debug(Moq.It.IsAny&lt;string&gt;(), null))
				.Callback((string s, object[] args) =&gt; { calls.Add(s); });

			calls.Count.ShouldBe(0);

			// simple and easily called from anywhere... and lets you 
			// format messages like 
			// Log.Debug(&quot;item id: {0} could not be saved&quot;, id);
			Log.Debug(&quot;debug&quot;, null);
			calls.Count.ShouldBe(1);
			calls.Contains(&quot;debug&quot;).ShouldBeTrue();

			Log.IsDebug = false;

			// its turned off so it won't output anything
			Log.Debug(&quot;debug&quot;, null);
			calls.Count.ShouldBe(1);

			Log.IsDebug = true;
		}

		private static Mock&lt;ILog&gt; CreateMockLog()
		{
			var log = new Mock&lt;ILog&gt;();
			Log.Loggers.Clear();
			Log.Loggers.Add(log.Object);
			return log;
		}
</pre>

<p>Though keep in mind, one of the more trickier things to mock is the use of a method with the &quot;params&quot; keyword. I had to used a callback that you pass in an object array (object[] args) and I passed in null, otherwise the callback would not fire, and Lambdas don't allow the &quot;params&quot; keyword. Once that was figured out, I was able to use moq successfully to test the Log class successfully. </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Mock Objects.aspx">Mock Objects</a>, <a rel='tag' href="http://www.amptools.net/labels/Moq.aspx">Moq</a>, <a rel='tag' href="http://www.amptools.net/labels/Unit Testing.aspx">Unit Testing</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1099928894407582088"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1099928894407582088;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/11/simple-log-in-amplify.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=1099928894407582088" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
			<h2 class="blog-title"><a name="3448672103322818552"></a>
				
				 Gallio and Mb-Unit release v3.0.4
				
				<span class="blog-byline">
				by: michael herndon, at: 10/29/2008 02:11:00 AM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>You can find many of the new <a href="http://blog.bits-in-motion.com/2008/10/announcing-gallio-and-mbunit-v304.html ">features over at Jeff Brown's blog</a>.&#160; Some of the cooler features of note is the integration with the visual studio testing system, wrapping testing for exceptions into a delegate, and data store called Ambient, in which you can store state for your tests.&#160; I've integrated this into amplify which is again, now on <a href="http://github.com/michaelherndon/amplify/tree/master">GitHub</a>. I did run into a few lil issues when setting this up though....</p> <span id="more-1"></span>    <p>The biggest issue was finding out how to turn a project into a test project in order to get the visual studio integration working for Gallio. Basically you need to make modifications to the .csproj file and add an XML element of &lt;ProjectTypeGuids&gt; into the first &lt;PropertyGroup&gt; of the file.&#160; </p>  <pre class="code xml">&lt;ProjectTypeGuids&gt;{3AC096D0-A1C2-E12C-1390-A8335801FDAB};
{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC} 
&lt;/ProjectTypeGuids&gt;</pre>

<p>After this, I could get the Gallio tests showing up in visual studio. </p>

<p><a href="http://lh3.ggpht.com/amptools/SQf-bZnOv5I/AAAAAAAAABM/xPj4ncLlA3g/s1600-h/Gallio-Test-View%5B2%5D.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="212" alt="Gallio-Test-View" src="http://lh3.ggpht.com/amptools/SQf-b1n8cMI/AAAAAAAAABU/f0_tzJSs_Lg/Gallio-Test-View_thumb.png?imgmax=800" width="244" border="0" /></a> </p>

<p>Now this coupled with <a href="http://testdriven.net/" rel="tag">Test Driven .Net</a> really helps with the testing process especially since with certain versions of Visual Studio, Test Driven .Net will let you run visual studio's code coverage with Gallio. </p>

<p><a href="http://lh6.ggpht.com/amptools/SQf-cYepypI/AAAAAAAAABY/2DfBfKGZbZY/s1600-h/CodeCoverage%5B2%5D.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="207" alt="CodeCoverage" src="http://lh5.ggpht.com/amptools/SQf-cwXSDSI/AAAAAAAAABc/i2MQj8jhAQU/CodeCoverage_thumb.png?imgmax=800" width="244" border="0" /></a> </p>

<p>Again, one of the cooler features was the improvements to Mb-Unit's Asserts (which did change the API, but its all good, cause I wrap the Asserts that I use in BDD style mixin Methods, so I just need to change them in one place). The one really change of note would be adding Assert.Throw and Assert.Throw&lt;T&gt;, to which you can wrap throwing an exception into a delegate.</p>

<p><a href="http://lh6.ggpht.com/amptools/SQf-di2keqI/AAAAAAAAABg/KCLE5wy_nU4/s1600-h/WrappingExceptions%5B2%5D.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="178" alt="WrappingExceptions" src="http://lh3.ggpht.com/amptools/SQf-eB-bggI/AAAAAAAAABk/Tl816nR7vkw/WrappingExceptions_thumb.png?imgmax=800" width="244" border="0" /></a> </p>

<p>All in all nice improvements to both Gallio and Mb-Unit, which are now incorporated into amplify. </p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BDD.aspx">BDD</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Gallio.aspx">Gallio</a>, <a rel='tag' href="http://www.amptools.net/labels/Mb-Unit.aspx">Mb-Unit</a>, <a rel='tag' href="http://www.amptools.net/labels/Mixins.aspx">Mixins</a>, <a rel='tag' href="http://www.amptools.net/labels/Unit Testing.aspx">Unit Testing</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=3448672103322818552"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=3448672103322818552;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/10/gallio-and-mb-unit-release-v304.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=3448672103322818552" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
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
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8687698153489958182"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8687698153489958182;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/04/gallio-mb-unit-3-with-bdd-style-tests-i_05.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=8687698153489958182" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
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