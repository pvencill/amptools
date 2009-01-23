<%@ Page Language="C#" MasterPageFile="~/App/Views/Layouts/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="main" runat="server">
    
    <div class="section behavior-curved">
		<h2>Welcome To Asp.Net MVC</h2>
		<p>
			To learn more about ASP.NET MVC visit <a href="http://asp.net/mvc" title="ASP.NET MVC Website">http://asp.net/mvc</a>.
		</p>
    </div>
    <div class="article behavior-curved">
		<h1><a name="1099928894407582088"></a>
				 Simple Log in Amplify 
		</h1>
		<h2>
			<span class="posted-by">
				by: <span class="author">michael herndon</span>
			</span>, 
			<span class="posted-at">
				at: <span class="date">11/02/2008</span> <span class="time">11:54:00 PM</span>
			</span>
		 </h2>
			

		<p>
			As many people know rails has a simple logger inside the framework
			which really only outputs to the console. This comes in handy 
			to see SQL output of your models, benchmarks and other cool 
			little things inside the rails framework.&nbsp; 
		</p>  
		<p>
			Of course people in the .Net realm tend to want things that scale
			and yet simplified for them.&nbsp; So output only to the console 
			won't fly in larger projects.&nbsp; There is log4net, but you 
			don't want to have it tightly coupled to the system, this 
			caused an issue to one project that I worked on while 
			still working for <a href="http://www.vivussoftware.com">Vivus 
			Software</a> before I 
			came <a href="http://www.opensourceconnections.com">OSC</a>. Where 
			the framework and project both expected a certain version of 
			Log4Net and there was no wrapper to put something else 
			in place if need be.&nbsp; 
		</p>   <span id="more-0"></span>    
		<p>
			So the solution was to Build small static Log class, that 
			takes a list of an interface ILog (different than log4net's) 
			and then use that interface to build a wrapper 
			around using the root Logger for log4net. 
			This way people can still build their own loggers for 
			amplify or build their own Appenders for Log4Net and 
			amplify will still be able to leverage this. Of course 
			there is also conditional symbol LOG4NET in amplify if 
			you wish to build the amplify framework without any 
			dependency on the log4net library.&nbsp;&nbsp; 
		</p>  
		<p>
			To me this is more like the Console.WriteLine that is 
			needed for a class library vs what log4net is typically 
			used for in an application where it also spits out the 
			type information of a class. To help with the testing 
			using mock object is the 
			<a href="http://code.google.com/p/moq/" rel="tag">Moq (Mock You)</a> which
			 uses the Lambda expression and gets rid of all that crazy 
			 record/playback junk to which I loathe.&nbsp; 
		</p>   
<pre class="code csharp">		public void Test()
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

		<p>
			Though keep in mind, one of the more trickier things 
			to mock is the use of a method with the "params" 
			keyword. I had to used a callback that you pass 
			in an object array (object[] args) and I passed in '
			null, otherwise the callback would not fire, and 
			Lambdas don't allow the "params" keyword. Once 
			that was figured out, I was able to use moq 
			successfully to test the Log class successfully. 
		</p>  
		
		<div class="aside tags">
				Labels: <a rel="tag" href="http://www.amptools.net/labels/Amplify.aspx">Amplify</a>, 
				<a rel="tag" href="http://www.amptools.net/labels/BHAG.aspx">BHAG</a>, <a rel="tag" href="http://www.amptools.net/labels/C#.aspx">C#</a>, <a rel="tag" href="http://www.amptools.net/labels/Code.aspx">Code</a>, <a rel="tag" href="http://www.amptools.net/labels/CSharp.aspx">CSharp</a>, <a rel="tag" href="http://www.amptools.net/labels/Mock%20Objects.aspx">Mock Objects</a>, <a rel="tag" href="http://www.amptools.net/labels/Moq.aspx">Moq</a>, <a rel="tag" href="http://www.amptools.net/labels/Unit%20Testing.aspx">Unit Testing</a></p>
		</div>
		<div class="aside comments">
				<a class="comment-link" href="https://www.blogger.com/comment.g?blogID=7043853799247804655&amp;postID=1099928894407582088" location.href="https://www.blogger.com/comment.g?blogID=7043853799247804655&amp;postID=1099928894407582088;"><span style="text-transform: lowercase;">0 Comments</span></a>
				
				<a class="comment-link" href="http://www.amptools.net/2008/11/simple-log-in-amplify.aspx#links"><span style="text-transform: lowercase;">Links to this post</span></a>
				  <span class="item-action"><a href="http://www.blogger.com/email-post.g?blogID=7043853799247804655&amp;postID=1099928894407582088" title="Email Post"><img class="icon-action" alt="" src="http://www.blogger.com:80/img/icon18_email.gif" width="18" height="13"></a></span>
				
				<script type="text/javascript" src="http://w.sharethis.com/widget/?tabs=web%2Cemail&amp;charset=utf-8&amp;services=reddit%2Cdigg%2Cfacebook%2Cmyspace%2Cdelicious%2Cstumbleupon%2Ctechnorati%2Cpropeller%2Cblinklist%2Cmixx%2Cnewsvine%2Cgoogle_bmarks%2Cyahoo_myweb%2Cwindows_live%2Cfurl&amp;style=rotate&amp;publisher=baa2824f-9291-46c0-87b4-6d5a72508a05&amp;headerbg=%23dddddd&amp;inactivebg=%231bb601&amp;inactivefg=%2370eb00%09&amp;linkfg=%231bb601"></script><span id="sharethis_0"><a href="javascript:void(0)" title="ShareThis via email, AIM, social bookmarking and networking sites, etc." class="stbutton stico_rotate"><span class="stbuttontext">ShareThis</span></a></span>
		</div>
    </div>
</asp:Content>
<asp:Content ID="sidebar" ContentPlaceHolderID="sidebar" runat="server">
	<% this.Html.RenderPartial("~/App/Views/Home/sidebar.ascx"); %>
	
</asp:Content>