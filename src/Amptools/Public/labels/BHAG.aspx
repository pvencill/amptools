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
			

                  
			<h2 class="blog-title"><a name="5634712196275175580"></a>
				
				 Amplify-Fusion, JavaScript libraries compatibility layer
				
				<span class="blog-byline">
				by: michael herndon, at: 8/06/2008 03:35:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>As one might start guessing, I tend to jump around languages, projects, and clients (web/windows client not people).&#160; After writing custom code for <a href="http://www.prototypejs.org/" rel="tag">prototype</a>, <a href="http://dojotoolkit.org/" rel="tag">dojo</a>, <a href="http://developer.yahoo.com/yui/" rel="tag">yui</a>, <a href="http://jquery.com/" rel="tag">jquery</a>, <a href="http://www.asp.net/ajax/" rel="tag">atlas (microsoft ajax library)</a> , it becomes a pain to remember which library has what and to port work you've previously done into another library.&#160; Its one thing if it porting code from one language to another, but to have port code cause of the library/framework.... its a pain that isn't needed.&#160; </p>  <p>Granted the downside of writing a compatibility layer is extra code that could be duplicated else where or writing a smaller set of routines that are less in what other full blown libraries. However most people have broadband these days and the browsers have this cool thing called caching. Not to mention YUI has a great compressor and there are ways to include multiple files on the server rather than on the browser.&#160; </p>  <p>So I've begun to embark on a long journey of making JavaScript widgets build on a compatibility layer of different libraries. The layer it self will take some time, testing, and constant refinement while trying to keep the layer small.&#160; However I believe this is needed, esp as a consultant that works on various projects and everyone has their favorite library to use...&#160; </p>  <p>you can find the beginnings of the code at <a title="http://code.google.com/p/amplify-fusion/" href="http://code.google.com/p/amplify-fusion/">http://code.google.com/p/amplify-fusion/</a>.</p>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/Javascript.aspx">Javascript</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=5634712196275175580"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=5634712196275175580;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/08/ampliy-fusion-javascript-libraries.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=5634712196275175580" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
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
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=458120713693871790"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=458120713693871790;><span style="text-transform:lowercase">2 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/07/amplify-wcf-twitter-api-client-library.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=458120713693871790" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
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
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=899658933881345685"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=899658933881345685;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/04/test-posting.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=899658933881345685" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
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