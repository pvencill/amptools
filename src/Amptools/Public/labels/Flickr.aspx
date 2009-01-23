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