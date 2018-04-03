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
	<jsp:include page="common/config/top.jsp"/>
	<jsp:include page="commonLeft.jsp"/>
			<div class="col-md-7" style="text-align: left; padding-left: 0px">
				<!-- form修改数据开始 -->

				<form method="post"
					action="${pageContext.request.contextPath}/dept/updateDeptUser.shtml"
					id="formId" class="form-inline">
					<div class="well">
						<div class="form-group">
							<p>
								<input class="form-control" style="width: 300px" name="id"
									value="${user.id}" type="hidden">
							</p>
							<p>
								姓名:<input type="text" class="form-control" style="width: 300px"
									name="nickname" value="${user.nickname}" placeholder="输入姓名 ">
							</p>
							<p>
								邮箱:<input type="text" class="form-control" style="width: 300px"
									name="email" value="${user.email}" placeholder="输入邮箱">
							</p>
							<p>
								密码:<input type="text" class="form-control" style="width: 300px"
									name="pswd" placeholder="输入新密码">
							</p>
						</div>
						<p>
							<button id="btnid" type="submit" class="btn btn-primary">修改</button>
						</p>
					</div>
					<p>${hint }</p>
				</form>

			</div>
		</div>
	</div>
</body>
</html>

