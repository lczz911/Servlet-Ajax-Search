<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>智能搜索框</title>
	<style type="text/css">
		#mydiv{
			position: absolute;
			top:50%;
			left: 50%;
			margin-left: -250px;
			margin-top: -50px;
		}
		.mouseOver{
			background: #708090;
			color: #FFFFAFA;
		}
		.mouseOut{
			background: #FFFFAFA;
			color: #000000;
		}
	</style>
	<script type="text/javascript">
		var xmlHttp;
		//获取用户输入信息的关联信息函数
		function getMoreContents() {
			//获取用户的输入信息
			var content = document.getElementById("keyword");
			if(content.value==""){
				clearContent();
				return;
			}
			//给服务器发送用户输入的内容
			//使用XMLHTTP对象
			xmlHttp=createXMLHttp();
			//向服务器发送数据
			var url = "search?keyword="+escape(content.value);
			xmlHttp.open("GET",url,true);
			//xmlHttp绑定回调方法，这个回调方法会在xmlHttp状态改变的时候被调用
			//当 readyState 等于 4 且状态为 200 时，表示响应已就绪：
			xmlHttp.onreadystatechange = callback;
			xmlHttp.send(null);
		}
		
		//获得XmlHttp对象
		function createXMLHttp(){
			//对于大多数浏览器都适用
			var xmlHttp;
			if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest();
			}
			//考虑浏览器的兼容性
			if(window.ActiveXObject){
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				if(!xmlHttp){
					xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				}
			}
			return xmlHttp;
		}
		
		//回调函数
		function  callback() {
			if(xmlHttp.readyState==4){
				if(xmlHttp.status==200){
					//交互成功，获得响应的数据
					var result = xmlHttp.responseText;
					//解析获得的数据
					var json = eval("("+result+")");
					/* 
					将获得的数据动态的展示到输入框下面
					*/
					//alert(json);
					setContent(json);
				}
			}
		}
		
		//设置关联数据的展示，参数为服务器传递过来的关联数据
		function setContent(contents) {
			//先清空数据
			clearContent();
			//
			setLocation();
			//获取关联数据的长度
			var size = contents.length;
			//设置内容
			for(var i=0;i<size;i++){
				var nextNode = contents[i];//contents是json数据，就是代表json的第i个元素
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				td.setAttribute("border", "0");
				td.setAttribute("bgcolor","#FFFAFA");
				td.onmouseover=function(){
					this.className="mouseOver";
				};
				td.onmouseout=function(){
					this.className="mouseOut";
				};
				//点击关联数据时，关联数据会自动填充到输入框中
				td.onclick=function(){
					
				};
				var text = document.createTextNode(nextNode);
				td.appendChild(text);
				tr.appendChild(td);
				document.getElementById("content_table_body").appendChild(tr);
			}
		}
		
		//清空之前的数据
		function clearContent() {
			var contentTableBody = document.getElementById("content_table_body");
			var size = contentTableBody.childNodes.length;
			for(var i=size-1;i>=0;i--){
				contentTableBody.removeChild(contentTableBody.childNodes[i]);
			}
			document.getElementById("popDiv").style.border="none";
		}
		
		//输入框失去焦点的时候，关联信息清空
		function keywordBlur() {
			clearContent();
		}
		//用来设置显示关联信息的位置
		function setLocation() {
			//关联信息的位置要和输入框一致
			var content = document.getElementById("keyword");
			var width = content.offsetWidth;
			var left = content["offsetLeft"];
			var top = content["offsetTop"]+content.offsetHeight;//到顶部的距离
			//获得显示数据的div
			var popDiv = document.getElementById("popDiv");
			popDiv.style.border="black 1px solid";
			popDiv.style.left=left+"px";
			popDiv.style.top=top+"px";
			popDiv.style.width=width+"px";
			document.getElementById("content_table").style.width=width+"px";
		}
	</script>
</head>
<body>
	<div id="mydiv">
		<input type="text" id="keyword" size=45px onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()"/> 
		<input type="button" value="Google最好用"/>
		<div id="popDiv">
			<table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
				<tbody id="content_table_body">
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>