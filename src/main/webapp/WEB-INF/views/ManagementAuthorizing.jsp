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
<title>部门权限管理</title>
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
<script type="text/javascript">
	var paths = "<%=basePath%>";
</script>	
<script src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
<script
	src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/userJs/treeCommon.js"></script> 


<!-- 加载添加node的小图标按钮 -->
<style type="text/css">
.ztree li span.button.add {
	margin-left: 2px;
	margin-right: -1px;
	background-position: -144px 0;
	vertical-align: top;
	*vertical-align: middle
}
</style>
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
							<li class="active dropdown"><a  href="${pageContext.request.contextPath}/dept/managementuser.shtml"> <i
									class="glyphicon glyphicon-chevron-right"></i>人员管理
							</a></li>
							<li class="active dropdown"><a href="${pageContext.request.contextPath}/dept/gosetDept.shtml"> <i
									class="glyphicon glyphicon-chevron-right"></i>部门管理
							</a></li>
							<li><a><i class="glyphicon glyphicon-chevron-right"></i>权限管理</a>
								<ul class="dropdown-menu" aria-labelledby="dLabel"
									style="margin-left: 160px; margin-top: -40px;">
									<ul class="nav nav-tabs">
											 <li><a href="#dept" onClick="initLoadDept()" data-toggle="tab" >部门授权</a></li>
											  <li><a href="#user"  onClick="initDeptUser()" data-toggle="tab" >人员授权</a></li>
								     </ul>								  
								</ul></li>
						</shiro:hasPermission>
					</ul>
				</div>
				</shiro:hasAnyRoles>
			<div class="tab-content">
						<div id="dept" class="tab-pane">
						<!-- 部门面板 -->
							<div class="col-md-3" style="text-align: left; padding-left: 0px">
								<!--加载一棵树，在树上进行权限的增删改查 tree_start  这里是给部门授权-->
								<div class="zTreeDemoBackground">
								 <ul id="deptTree" class="ztree"></ul> 
								 </div>								
								<!-- tree end -->
							</div>
							
								<div id="deptPerList"></div>
								<!-- 根据部门信息查询出当前所拥有权限 -->						
							
						</div>
						<div id="user" class="tab-pane">
						<!--人员面板  -->
							<div class="col-md-7" style="text-align: left; padding-left: 0px">
								<!--加载一棵树，在树上进行权限的增删改查 tree_start  这里是给人权授权 
								初始化加载一棵部门树，点击部门查询该部门下面所有人员
								-->
								<div class="zTreeDemoBackground">
								 <ul id="deptUserTree" class="ztree"></ul>
								 </div>	
								<!-- tree end -->
								
								<div id="deptUserList"></div><!-- 查询出当前部门下的人 -->
								<div id="UserPermissionList"></div><!-- 查询该人所有权限-->
							</div>
						</div>
	        </div>	
	</div>
	</div>
	
	
	<!--弹框  -->
	<div id="modalForm" class="modal fade" id="addrole" tabindex="-1"
		role="dialog" aria-labelledby="addroleLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="addroleLabel">权限选择</h4>
				</div>
				<div class="modal-body">
					<p id="hiddenDeptId"></p>
					<p id="usermage"></p>
					<div id="allPermission"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button id="btnsub" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	
</body>

</html>

