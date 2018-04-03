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

<!-- 下面setting里面是初始化树的所有节点的，当然也可以异步加载，回调函数是写点击，或者悬浮，一些点击事件的 -->
<SCRIPT type="text/javascript">	
		var setting = {
			async: {
				enable: true,
				url:"${pageContext.request.contextPath}/dept/managementuserbasic.shtml",
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},			
			data: {				
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: zTreeOnChec
			}
		};
	
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}
		
		function zTreeOnChec(event, treeId, treeNode) {		
		    $.ajax({
		    	url:"${pageContext.request.contextPath}/dept/managementusersecond.shtml",
		    	type:"POST",
		    	data:{treeId:treeNode.id},
		    	dataType:"json",
		    	success:function(data){			    		
		    		var newTr ="<tr>"+		    		
	                              "<th width='10%' type='hidden'>编号</th>"+
									"<th width='10%'>姓名</th>"+			
									"<th width='10%'>邮箱</th>"+	
									"<th width='10%'>密码</th>"+	
									"<th width='5%'>操作</th>"+	
								"</tr>";
		    		for(var i in data){
						 newTr += "<tr>"+
						                "<th type='hidden'>"+data[i].id+"</th>"+
										"<th>"+data[i].nickname+"</th>"+
										"<th>"+data[i].email+"</th>"+	
										"<th>********</th>"+
					"<th><a href='${pageContext.request.contextPath}/dept/usrUpdate.shtml?id="+data[i].id+"'>修改</a>&nbsp;&nbsp;&nbsp;<a href='${pageContext.request.contextPath}/dept/deleteUsr.shtml?id="+data[i].id+"'>删除</a>&nbsp;&nbsp;&nbsp;<a onclick='loadS("+data[i].id+")' class='btn btn-info' >更改部门</a></th>"+
								  "</tr>";
		    		}
		    		var btnStr="<button id='adbtn' onClick='addFun()' class='btn btn-primary'>添加人员信息</a>";
				$("#appData").html(newTr);		
				$("#btnData").html(btnStr);
		    	},
		    	error:function(){
		    		alert("请求错误!");
		    	}
		    });
		};	
		
		function loadS(id){		
			var inputid="<input name='uid' type='hidden' value='"+id+"'/>"
			  $.ajax({
			    	url:"${pageContext.request.contextPath}/dept/loadselecter.shtml",
			    	type:"POST",
			    	dataType:"json",
			    	success:function(data){			    		
			    		var newTr ="<option value='0'>请选择</option>";
			    		for(var i in data){
					 newTr += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";							
			    		}
					$("#deptSelecter").html(newTr);	//把动态列表加进去	
					$("#inputBox").html(inputid);//隐藏id加进去
					$("#modalForm").modal();//最后加载完毕把模态框显示出来
			    	},
			    	error:function(){
			    		alert("请求错误!");
			    	}
			    });	 		
		}
		
		function addFun(){
			$("#modalFormadd").modal();
		}
		
	
		
		$(document).ready(function(){			
		$.fn.zTree.init($("#tree1"),setting);		
			$("#btnid").click(function(){
				window.location.href="${pageContext.request.contextPath}/dept/goaddDeptUser.shtml";				
			});						
			$("#btnsub").click(function(){
				$("#boxRoleForm").submit();
			});			
		});
	</SCRIPT>


</head>
<body data-target="#one" data-spy="scroll">
	<jsp:include page="commonLeft.jsp"></jsp:include>	
			<div class="col-md-2">
				<div class="content_wrap">
					<div class="zTreeDemoBackground">
						<ul id="tree1" class="ztree"></ul>
					</div>
				</div>
			</div>
			<div class="col-md-6" style="text-align: left; padding-left: 0px">
				<table class="table table-bordered" id="appData">

				</table>
				<p>${hint}</p>
			</div>
			<div class="col-md-2">
				<p class="table table-bordered" id="btnData"></p>
			</div>
			
			<!--缺省拼接jsp差两个div标签  -->
		</div>
	</div>
	<!--修改弹框  -->
	<div id="modalForm" class="modal fade" id="addrole" tabindex="-1"
		role="dialog" aria-labelledby="addroleLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="addroleLabel">更改部门</h4>
				</div>
				<div class="modal-body">
					<form id="boxRoleForm" method="post"
						action="${pageContext.request.contextPath}/dept/changingDeptOnUser.shtml">
						<p id="getNode"></p>
						<div class="form-group">
							<label for="recipient-name" class="control-label">部门名称:</label>
							<p id="inputBox">
								<!-- JS动态加载id值 -->
							</p>
							<select id="deptSelecter" class="form-control"
								name="deptSelecter">
								<!-- JS动态加载下拉框 -->
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button id="btnsub" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!--添加弹框  -->
	<div id="modalFormadd" class="modal fade" id="addrole" tabindex="-1"
		role="dialog" aria-labelledby="addroleLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="addroleLabel">添加部门人员</h4>
				</div>
				<div class="modal-body">
					<form method="post"
						action="${pageContext.request.contextPath}/dept/addDeptUser.shtml"
						id="formId" class="form-inline">
						<div class="well">
							<div class="form-group">
								<p>
									姓名:<input type="text" class="form-control" style="width: 300px"
										name="nickname" placeholder="输入姓名 ">
								</p>
								<p>
									邮箱:<input type="text" class="form-control" style="width: 300px"
										name="email" placeholder="输入邮箱">
								</p>
								<p>
									密码:<input type="text" class="form-control" style="width: 300px"
										name="pswd" placeholder="输入密码">
								</p>
							</div>
							<button type="submit" class="btn btn-primary">保存</button>
							<a
								href="${pageContext.request.contextPath}/dept/managementuser.shtml"
								class="btn btn-primary">取消</a>
						</div>
					</form>
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

