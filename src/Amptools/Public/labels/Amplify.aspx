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
			

                  
			<h2 class="blog-title"><a name="1045031666772907229"></a>
				
				 Getting the |DataDirectory| folder in C sharp
				
				<span class="blog-byline">
				by: michael herndon, at: 8/14/2008 02:19:00 PM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>One of the cool things about sql server express's connection strings is the ability to relatively path database files for sql express databases. Often one might see something in the connection string that looks like " AttachDbFilename=|DataDirectory|\file.mdf ".  The pipes and DataDirectory is parsed to equate to a relative data directory file path that changes depending on the application type (i.e. an application deployed by click once, vs an application that is installed to a folder). </p>  

<p>However sometimes you might want to know where that data directory is, like in my case, I want to take a look at a connection string and attempt to create a database based off the connection string in order to speed up development using database migrations. This could also come in handy deploying small applications. </p>  

<p>So after some research via google, I found <a href="http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=702378&amp;SiteID=1">this gem on msdn about where the DataDirectory is</a>, though not guaranteed to be accurate. It basically follows 3 simple hierarchal rules.  If the AppDomain.SetData method has been used, then the directory is set there. Otherwise if the application is a click once application the data directory is set or its in the application root folder.  </p>  <p>So below is what the code might possibly look like in order to get the applications data directory no matter what type of application it is and it gives you ability to set the DataDirectory as well.  </p>  <p></p> 

<pre class="code csharp">namespace Amplify
{
 using System;
 using System.Configuration;
 using System.Collections.Generic;
 using System.Collections.Specialized;
 using System.Deployment;
 using System.Deployment.Application;
 using System.IO;
 using System.Text;
 using System.Reflection;
 using System.Web;

 public class ApplicationContext {

  private static NameValueContext s_properties;


  public static bool IsWebsite { get; internal set; }

  static ApplicationContext()
  {
   IsWebsite = (System.Web.HttpContext.Current != null);
   
  }

  public static string DataDirectory
  {
   get
   {
    string dataDirectory = GetProperty("DataDirectory") as string;

    if (string.IsNullOrEmpty(dataDirectory))
    {
     dataDirectory = AppDomain
      .CurrentDomain.GetData("DataDirectory") as string;

     if (dataDirectory == null)
     {
      if (ApplicationDeployment.IsNetworkDeployed)
       dataDirectory = ApplicationDeployment
        .CurrentDeployment.DataDirectory;
      else
       dataDirectory = Path.GetDirectoryName(
        Assembly.GetExecutingAssembly()
         .GetName().CodeBase);
     }
     dataDirectory = dataDirectory.Replace(@"file:\", "");
     SetProperty("DataDirectory", dataDirectory);
    }
    return dataDirectory;
   }
   set
   {
    string dataDirectory = GetProperty("DataDirectory") as string;
    value = value.Replace(@"file:\", value);

    if (!System.IO.Directory.Exists(dataDirectory))
     System.IO.Directory.CreateDirectory(dataDirectory);

    SetProperty("DataDirectory", value);
    AppDomain.CurrentDomain.SetData("DataDirectory", value);
   }
  }


  public static object GetProperty(string propertyName)
  {
   if (IsWebsite)
    return HttpContext.Current.Application[propertyName];
   else
    return Context[propertyName];
  }

  
  public static void SetProperty(string propertyName, object value)
  {
   if (IsWebsite)
    HttpContext.Current.Application[propertyName] = value;
   else
    Context[propertyName] = value;
  }

  private static NameValueContext Context
  {
   get
   {
    if (s_properties == null)
     s_properties = new NameValueContext();
    return s_properties;
   }
  }
 }
}</pre><p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1045031666772907229"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=1045031666772907229;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/08/getting-datadirectory-folder-in-c-sharp.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=1045031666772907229" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
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
			

                  
			<h2 class="blog-title"><a name="8164722880411458481"></a>
				
				 Using WCF to access the Flickr JSON API
				
				<span class="blog-byline">
				by: michael herndon, at: 7/17/2008 06:40:00 AM
				</span>
				
			 </h2>
			 <div class="blog-content">
				<p>Even though there are quite a few opensource .Net libraries REST API out there, and a really impressive one for Flickr, they tend to never evolve or fork to use the newer framework technologies.&#160; I think its great that they support 1.0, 2.0, and mono, but why not fork and support WCF?&#160; I think part of the problem that .Net 3.5 use is not wide spread as it should be is not only information overload and bad naming for extension libraries, but also lack of opensource support to provide libraries and basis for current technology.&#160; </p>  <p>Flickr tends to be a little more tricky to use when calling it than some other REST APIs. WCF is a cool technology, but needs to be massaged when using it with Flickr due to a couple of gotchas and not so obvious things about WCF. In order to use Flickr, you need to register for an api_key and a shared secret code which is used to create an MD5 hash. You also need to create that MD5 each time you call a method, using the url parameters in a certain way. </p>  <p>There are also a few not so obvious factors about using the JSON part of Flickr. All of the .Net libraries I've seen so far, use XML. While C# is king of parsing&#160; XML, JSON tends to be more compact, which means less expense over the wire, though it might mean more time parsing once on the developers end point. So there are tradeoffs to using it. </p>  <p>When I created the classes needed to use WCF to call Flickr, I have the actual &quot;DataContract&quot; object (DTO, Data Transfer Object), A Hash (Dictionary&lt;string, object&gt;) for adding the parameters to create the MD5 signature, A base class for creating the WCF proxy, a custom &quot;WebContentTypeMapper&quot;, The &quot;ServiceContract&quot; interface, the actual &quot;Client class&quot;, and a mixins class for creating the MD5. </p>  <p>Here are some of the gotchas that I ran into while getting WCF to work with Flickr. </p>  <p></p>  <ol>   <li>Flickr makes you create a md5 hash to send with every call for ALL parameters in alphabetical order using your &quot;Shared Secret&quot; Code as part of the md5.&#160;&#160; </li>    <li>Flickr's Json response &quot;Content-Type&quot; header is sent not as &quot;application/json&quot; but as &quot;text/plain&quot; which equates to &quot;Raw&quot; in WCF lingo.&#160; </li>    <li>The response object is wrapped and not obvious when it comes to json how the DataContract object should be formed.&#160; </li>    <li>Flickr will wrap the json response in a javascript function unless you pass in the parameter &quot;nojsoncallback=1&quot; </li> </ol>  <p>To get around number one, I created an extension method that takes a Hash (Dictionary&lt;string, object&gt;) and adds method that converts the parameters into a MD5 string. </p>  <pre class="code csharp">namespace Amplify.Linq
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;

#if STANDALONE
	public class Hash : Dictionary&lt;string, object&gt;
	{

		


	}
#endif 
}
// different file
	
namespace Amplify.Linq
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Security.Cryptography;
	using System.Text;

	using Amplify.Linq;

	public static class Mixins
	{

	

		public static string ToMD5(this Hash obj, string secret)
		{
			var query = from item in obj
						orderby item.Key ascending
						select item.Key + item.Value.ToString(); 

			StringBuilder builder = new StringBuilder(secret, 2048);

			foreach (string item in query)
				builder.Append(item);

			MD5CryptoServiceProvider crypto = new MD5CryptoServiceProvider();
			byte[] bytes = Encoding.UTF8.GetBytes(builder.ToString());
			byte[] hashedBytes = crypto.ComputeHash(bytes, 0, bytes.Length);
			return BitConverter.ToString(hashedBytes).Replace(&quot;-&quot;, &quot;&quot;).ToLower();
		}

	}
}</pre>

<p>Well Gotcha number two, took a bit of research to figure it out. The error I got was that it was looking for Json or XML but could not do anything with &quot;Raw&quot;. So the solution is to create a custom binding with a custom WebContentTypeManager. </p>

<pre class="code csharp">namespace Amplify.Flickr
{
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.Runtime.Serialization;
	using System.ServiceModel.Web;

	public class JsonContentMapper : WebContentTypeMapper
	{
		public override WebContentFormat GetMessageFormatForContentType(string contentType)
		{
			return WebContentFormat.Json;
		}
	}
}

// different file

namespace Amplify.Flickr
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;
	using System.ServiceModel;
	using System.ServiceModel.Channels;
	using System.ServiceModel.Description;
	using System.ServiceModel.Web;

	using Amplify.Linq;

	public class FlickrClient&lt;T&gt; 
	{
		protected string Secret { get; set; }

		protected string Key { get; set; }

		protected string Token { get; set; }

		protected string Url { get; set; }

		protected T Proxy { get; set; }


		public FlickrClient(string key, string secret)
		{
			this.Key = key;
			this.Secret = secret;
			this.Url = &quot;http://api.flickr.com/services/rest&quot;;
			this.Proxy = this.InitializeProxy();
		}

		public FlickrClient(string key, string secret, string token)
			:this(key, secret)
		{
			this.Token = token;
		}

		protected virtual T InitializeProxy()
		{
			// using custom wrapper
			CustomBinding binding = new CustomBinding(new WebHttpBinding());
			WebMessageEncodingBindingElement property =	binding.Elements.Find&lt;WebMessageEncodingBindingElement&gt;();
			property.ContentTypeMapper = new JsonContentMapper();
			

			ChannelFactory&lt;T&gt; channel = new ChannelFactory&lt;T&gt;(
				binding, this.Url);

			channel.Endpoint.Behaviors.Add( new WebHttpBehavior());
			return channel.CreateChannel();
		}

	}
}</pre>

<p>The 3rd issue, to know that all objects are wrapped in a &quot;Response&quot; object. To create a DataContract for the getFrob method on flickr, it took looking at the json to see what it was returning. The object below is the basic form of the Json object that is returned, it also includes the properties in case an error object is returned. </p>

<pre class="code csharp">	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;
	using System.Runtime.Serialization;

	[DataContract]
	public class FrobResponse 
	{
		[DataMember(Name = &quot;frob&quot;)]
		public JsonObject Frob { get; set; }

		[DataContract(Name = &quot;frob&quot;)]
		public class JsonObject
		{
			[DataMember(Name = &quot;_content&quot;)]
			public string Content { get; set; }

		}

		[DataMember(Name = &quot;stat&quot;)]
		public string Status { get; set; }

		[DataMember(Name = &quot;code&quot;)]
		public int Code { get; set; }

		[DataMember(Name = &quot;message&quot;)]
		public string Message { get; set; }
	}

	// different file


	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;
	using System.ServiceModel;
	using System.ServiceModel.Web;

	[ServiceContract]
	public interface IAuthClient
	{
		[OperationContract,
			WebInvoke(
				UriTemplate = &quot;/?method=flickr.auth.getFrob&amp;format=json&amp;nojsoncallback=1&amp;api_key={key}&amp;api_sig={signature}&quot;,
				ResponseFormat = WebMessageFormat.Json,
				BodyStyle = WebMessageBodyStyle.Bare)]
		FrobResponse GetFrob(string signature, string key);

		[OperationContract,
			WebInvoke(
				UriTemplate = &quot;/?method=flickr.auth.getToken&amp;format=json&amp;nojsoncallback=1&amp;api_key={key}&amp;frob={frob}&amp;api_sig={signature}&quot;,
				ResponseFormat = WebMessageFormat.Json,
				BodyStyle = WebMessageBodyStyle.WrappedResponse)]
		Auth GetToken(string signature, string key, string frob);
	}


	// the actual client class.  

	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;

	using Amplify.Linq;


	public class AuthClient : FlickrClient&lt;IAuthClient&gt;
	{

		public AuthClient(string key, string secret)
			:base(key, secret)
		{ }

		public AuthClient(string key, string secret, string token)
			:base(key, secret, token)
		{ }

		public string GetFrob()
		{
			string md5 = new Hash() {
				{&quot;api_key&quot;, this.Key},
				{&quot;format&quot;, &quot;json&quot;},
				{&quot;method&quot;, &quot;flickr.auth.getFrob&quot;},
				{&quot;nojsoncallback&quot;, 1}
			}.ToMD5(this.Secret);

			FrobResponse response = this.Proxy.GetFrob(md5, this.Key);
			if (response.Code &gt; 0)
				throw new Exception(response.Message);

			return response.Frob.Content;
		}
	}</pre>  <p class="blogger-labels">Labels: <a rel='tag' href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, <a rel='tag' href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel='tag' href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel='tag' href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel='tag' href="http://www.amptools.net/labels/Flickr.aspx">Flickr</a>, <a rel='tag' href="http://www.amptools.net/labels/JSON.aspx">JSON</a>, <a rel='tag' href="http://www.amptools.net/labels/REST.aspx">REST</a>, <a rel='tag' href="http://www.amptools.net/labels/WCF.aspx">WCF</a></p>
			 </div>
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8164722880411458481"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=8164722880411458481;><span style="text-transform:lowercase">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/07/using-wcf-to-access-flickr-json-api.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=8164722880411458481" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script>
			</div>
			

                  
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
			 <div class="blog-footer">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=3907268195622759157"location.href=https://www.blogger.com/comment.g?blogID=7043853799247804655&postID=3907268195622759157;><span style="text-transform:lowercase">3 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/07/amplify-twittern-yet-another-c-twitter.aspx#links"><span style="text-transform:lowercase">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&postID=3907268195622759157" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" height="13" width="18"/></a></span>
				
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