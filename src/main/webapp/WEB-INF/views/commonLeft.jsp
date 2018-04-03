<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8" />
<base href="<%=basePath%>" />
<title>用户角色分配 - 权限管理</title>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />

<link rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
<link
	href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>/css/common/base.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=basePath%>/css/ztree/zTreeStyle.css"
	type="text/css">
<script src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
<script
	src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>


<SCRIPT type="text/javascript">			
		$(document).ready(function(){
			$("#subDept").click(function(){
				window.location.href="${pageContext.request.contextPath}/dept/managementuser.shtml";							
			});		
			
			$("#setDept").click(function(){
				window.location.href="${pageContext.request.contextPath}/dept/gosetDept.shtml";				
			});	
		});
	</SCRIPT>


</head>
<body data-target="#one" data-spy="scroll">
	<jsp:include page="common/config/top.jsp"></jsp:include>
	<div class="container"
		style="padding-bottom: 15px; min-height: 300px; margin-top: 40px;">
		<div class="row">
		<shiro:hasAnyRoles name='888888,100003'>
				<div id="one" class="col-md-2">
					<ul data-spy="affix"
						class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix"
						style="top: 100px; z-index: 100;">
						
						<shiro:hasPermission name="/role/allocation.shtml">
							<li class="active dropdown"><a id="subDept"> <i
									class="glyphicon glyphicon-chevron-right"></i>人员管理
							</a></li>
							<li class="active dropdown"><a id="setDept"> <i
									class="glyphicon glyphicon-chevron-right"></i>部门管理
							</a></li>
							<li><a href="<%=basePath%>/per/gorolDept.shtml"><i class="glyphicon glyphicon-chevron-right"></i>权限管理</a>
								</li>
						</shiro:hasPermission>
					</ul>
				</div>
			</shiro:hasAnyRoles>
			


