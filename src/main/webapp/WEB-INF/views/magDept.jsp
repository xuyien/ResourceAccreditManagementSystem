<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8" />
<base href="<%=basePath%>" />
<title>部门管理</title>
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
<script src="<%=basePath%>/js/common/layer/layer.js"></script>
<style type="text/css">
.ztree li span.button.add {
	margin-left: 2px;
	margin-right: -1px;
	background-position: -144px 0;
	vertical-align: top;
	*vertical-align: middle
}
</style>
<SCRIPT type="text/javascript">
	var treeObj;
	var setting = {
		async : {
			enable : true,
			url : "${pageContext.request.contextPath}/dept/managementuserbasic.shtml",
			autoParam : [ "id", "name=n", "level=lv" ],
			otherParam : {
				"otherParam" : "zTreeAsyncTest"
			},
			dataFilter : filter
		},
		view : {
			addHoverDom : addHoverDom,
			removeHoverDom : removeHoverDom
		/* ,
		selectedMulti: false */
		},
		edit : {
			enable : true
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			onClick : zTreeOnCilck,
			onRemove : onRemove,
			onRename : onRename
		}
	};

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}

	function zTreeOnCilck(event, treeId, treeNode) {		
		$.ajax({
					url : "${pageContext.request.contextPath}/dept/deptManagement.shtml",
					type : "POST",
					data : {
						treeId : treeNode.id
					},
					dataType : "json",
					success : function(data) {
						var newTr = "<tr>" + "<th width='10%'>编号</th>"
								+ "<th width='10%'>部门</th>"
								+ "<th width='10%'>操作</th>" + "</tr>";
						for ( var i in data) {
							newTr += "<tr>"
									+ "<th>"
									+ data[i].id
									+ "</th>"
									+ "<th>"
									+ data[i].name
									+ "</th>"
									+ "<th><a href='${pageContext.request.contextPath}/dept/deleteDept.shtml?id="
									+ data[i].id
									+ "' class='btn btn-primary'>删除</a></th>"
									+ "</tr>";

						}
						$("#deptData").html(newTr);
					},
					error : function() {
						alert("请求错误!");
					}
				});
	};
	//修改节点名称
	function onRename(e, treeId, treeNode, isCancel) {
		//layer.msg(treeNode.name);
		$.ajax({
			url : "${pageContext.request.contextPath}/dept/reNameNode.shtml",
			type : "POST",
			data : {
				treeId : treeNode.id,
				Name : treeNode.name
			}
		});
	}
	//删除节点
	function onRemove(e, treeId, treeNode) {
		//alert(treeNode.name);
		$.ajax({
			url : "${pageContext.request.contextPath}/dept/deleteDept2.shtml",
			type : "POST",
			data : {
				id : treeNode.id
			}
		});
	}

	//不悬浮时去除图标
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_" + treeNode.tId).unbind().remove();
	};

	function addHoverDom(treeId, treeNode) {
		//悬浮时显示添加图标start
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
			return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_" + treeNode.tId);
		//悬浮时显示添加图标end
		if(btn)btn.bind("click",function() {
								//点击你所显示的图标，执行你的function
								$("#getNode")
										.html(
												"<input name='pId' type='hidden' value='"+treeNode.id+"'/>");
								$("#modalForm").modal();
							});

	};

	$(document).ready(function() {
		$("#btnsub").click(function() {
			$("#boxRoleForm").submit();
		});

		/* start-----inint zTree */
		treeObj = $.fn.zTree.init($("#treeData"), setting);
		/* ------end init ztree */

	});
</SCRIPT>


</head>
<body data-target="#one" data-spy="scroll">
	<jsp:include page="commonLeft.jsp"></jsp:include>
			<div class="col-md-3">
				<div class="content_wrap">
					<div class="zTreeDemoBackground">
						<ul id="treeData" class="ztree"></ul>
					</div>
				</div>
			</div>
	
		<div class="col-md-6" style="text-align: left; padding-left: 0px">
			<table class="table table-bordered" id="deptData">
			</table>
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
					<h4 class="modal-title" id="addroleLabel">添加部门</h4>
				</div>
				<div class="modal-body">
					<form id="boxRoleForm" method="post"
						action="${pageContext.request.contextPath}/dept/addingDept.shtml">
						<p id="getNode"></p>
						<div class="form-group">
							<label for="recipient-name" class="control-label">部门名称:</label> <input
								type="text" class="form-control" name="name" id="name"
								placeholder="请输入角色名称" />
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

