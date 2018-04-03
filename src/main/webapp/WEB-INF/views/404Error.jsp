<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html>
<html>
<head>
	<title>BTError</title>
	<meta name="description" content="plagume404">  
	<meta name="author" content="Bart">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   <link rel="stylesheet" href="<%=basePath%>/404error/css/base.css">  
   <link rel="stylesheet" href="<%=basePath%>/404error/css/main.css">
   <link rel="stylesheet" href="<%=basePath%>/404error/css/vendor.css">     
	<script src="<%=basePath%>/404error/js/modernizr.js"></script>
	<link rel="icon" type="image/png" href="<%=basePath%>/404error/faviconsecond.png">
</head>

<body>
   <main id="main-404-content" class="main-content-static">
   	<div class="content-wrap">
		  <div class="shadow-overlay"></div>
		   <div class="main-content">
		   	<div class="row">
		   		<div class="col-twelve">			  		
			  			<h1 class="kern-this">Big Error</h1>
			  			<p>
						 Holy Shit ! There is so many bug found at your system ,  please fix up !
						 YOU DAMN ASSHOLE !
			  			</p>
			  			<div class="search">
				      	<p>Exception caught ! </p>
				      	<p>cause by  :  ${hint}</p>
				      </div>
			   	</div>		   			
		   	</div> 	 		
		   </div>    

		   <footer>
		   	<div class="row">		   			
		  			<div class="col-five tab-full bottom-links">
			   		<ul class="links">				   		
				         <li><a href="mailto:joe@quatro.com">FUCK UP YOUR SYSTEM ！</a></li>			                    
				   	</ul>

				   	<div class="credits">
				   		<p>版权所有GeneralBart</p>
				   	</div>
			   	</div> 
		   	</div>   		  		
		   </footer>
		</div>    
   </main>
   <div id="preloader"> 
    	<div id="loader"></div>
   </div>

   <script src="<%=basePath%>/404error/js/jquery-2.1.3.min.js"></script>
   <script src="<%=basePath%>/404error/js/plugins.js"></script>
   <script src="<%=basePath%>/404error/js/main.js"></script>

</body>
</html>