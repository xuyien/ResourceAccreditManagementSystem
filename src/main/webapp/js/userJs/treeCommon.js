//这里人员权限树，根据人查出所在部门
var treeuserObj;    
var settingUsertree={
		async: {
			enable: true,
			url: paths + "/dept/managementuserbasic.shtml",
			autoParam:["id", "name=n", "level=lv"],
			otherParam:{"otherParam":"zTreeAsyncTest"} ,
			dataFilter: filter 
		},
		data: {				
			simpleData: {
				enable: true
			}
		},
		callback:{
			onClick:asyClick
		}
}; 
function asyClick(event, treeId, treeNode){
	 $.ajax({
	 		    	url:paths+"/dept/managementusersecond.shtml",
	 		    	type:"POST",
	 		    	data:{treeId:treeNode.id},
	 		    	dataType:"json",
	 		    	success:function(data){	
	 		    		  var newTr= "<tr>" 
	 		    			  + "<th width='1%'>编号</th>"
	 		 			+ "<th width='1%'>姓名</th>"
	 		 			+ "<th width='1%'>操作</th>" + "</tr>";					
	 		 			for ( var i in data) {
	 		 				newTr += "<tr>"
	 		 						+ "<th>"
	 		 						+ data[i].id
	 		 						+ "</th>"
	 		 						+ "<th>"
	 		 						+ data[i].nickname
	 		 						+ "</th>"	 		 						
	 		 						+"<th>"
	 		 						+"<a onclick='checkUserPerission("+data[i].id+")' class='btn btn-info'>查看</a><a onclick='addUserPerission("+data[i].id+")' class='btn btn-info'>添加权限</a>"	
	 		 						+"</th>"								
	 		 						+ "</tr>";

	 		 			}		    		
	 		 		$("#deptUserList").html(newTr);
	 		    	},
	 		    	error:function(){
	 		    		alert("请求错误!");
	 		    	}
	 		    });	
}
function checkUserPerission(id){	
	//alert(id);
	 $.ajax({
	    	url:paths+"/per/getuserpermission.shtml",
	    	type:"POST",
	    	data:{id:id},
	    	dataType:"json",
	    	success:function(data){	
	    var newTr= "<tr><th width='1%'>url</th><th width='1%'>权限</th></tr>";	 						
	 			for ( var i in data) {
	 				newTr += "<tr>"
	 						+ "<th>"
	 						+ data[i].url
	 						+ "</th>"
	 						+ "<th>"
	 						+ data[i].name
	 						+ "</th>"	 														
	 						+ "</tr>";

	 			}		    		
	 		$("#UserPermissionList").html(newTr);
	    	},
	    	error:function(){
	    		alert("请求错误!");
	    	}
	    });	
}
//ztree自带的filter
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
	}
	return childNodes;
}

function initDeptUser(){    		
	treeuserObj = $.fn.zTree.init($("#deptUserTree"), settingUsertree);	 
}

function addUserPerission(id){
	//alert(id);
	
	  $.ajax({
	    	url:paths+"/per/selectAllPermission.shtml",
	    	type:"POST",
	    	dataType:"json",
	    	success:function(data){	
	    		var userId="<input id='userid' type='hidden' value='"+id+"'/>";
	    		var usermage="<input id='mage' type='hidden' value='usr'/>";
	    		//标识，当前是人员授权还是部门授权，空为人员，usr为人员
	    		var newTr="";
	    		for(var i in data){
					 newTr += "<p><input type='checkbox' name='ckPermission' value="+data[i].id+" >&nbsp;&nbsp;"+data[i].name+"<p>";
	    		}
	    		
			$("#allPermission").html(newTr);
			$("#usermage").html(usermage);//标识，当前是人员授权还是部门授权，空为人员，usr为人员
			$("#hiddenDeptId").html(userId);											
			$("#modalForm").modal();
	    	},
	    	error:function(){
	    		alert("请求错误!");
	    	}
	    });		
	
}

//下面开始加载部门权限树
var treeObj;
var setting={
		async: {
			enable: true,
			url: paths+"/dept/managementuserbasic.shtml",
			autoParam:["id", "name=n", "level=lv"],
			otherParam:{"otherParam":"zTreeAsyncTest"} ,
			dataFilter: filter 
		} ,	
		view : {
			addHoverDom : addHoverDom,
			removeHoverDom : removeHoverDom    			
		},
		data: {				
			simpleData: {
				enable: true
			}
		},
		callback:{
			onClick:showInfoClick
		}
};     	
function showInfoClick(event, treeId, treeNode){
	selectDeptPermission(treeNode.id);
}

function selectDeptPermission(i){	
	var preDeptId=i;
	 $.ajax({
	    	url:paths+"/per/selectPermissionByDept.shtml",
	    	type:"POST",
	    	data:{id:i},
	    	dataType:"json",
	    	success:function(data){	
	    	  var newTr= "<tr>" + "<th width='10%'>编号</th>"
				+ "<th width='10%'>地址</th>"
				+ "<th width='10%'>权限</th>" 
				+ "<th width='10%'>操作</th>" + "</tr>";					
				for ( var i in data) {
					newTr += "<tr>"
							+ "<th>"
							+ data[i].id
							+ "</th>"
							+ "<th>"
							+ data[i].url
							+ "</th>"
							+ "<th>"
							+ data[i].name
							+ "</th>"
							+"<th>"
							+"<button onClick='deletePer("+data[i].id+","+preDeptId+")'class='btn btn-info'>删除</button>"	
							+"</th>"								
							+ "</tr>";

				}		    		
			$("#deptPerList").html(newTr);
	    	},
	    	error:function(){
	    		alert("请求错误!");
	    	}
	    });	
}
function deletePer(id,ptId){
	 $.ajax({
	    	url:paths+"/per/delPermissionDept.shtml",
	    	type:"POST",
	    	dataType:"html",
	    	data:{did:id,deptid:ptId},
	    	success:function(data){	
	    		if("succ"==data){
	    			layer.msg("删除成功!");
	    			selectDeptPermission(ptId);
	    		}else{
	    			layer.msg("删除失败,请先检查您的个人权限!");
	    		}
	    	},
	    	error:function(){
	    		alert("请求错误!");
	    	}
	    });	
}

//ztree自带的filter
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
	}
	return childNodes;
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
	if (btn)btn.bind("click",
						function() {
		              //点击你所显示的图标，执行你的function
			    			  $.ajax({
							    	url:paths+"/per/selectAllPermission.shtml",
							    	type:"POST",
							    	dataType:"json",
							    	success:function(data){	
							    		var deptId="<input id='deptid' type='hidden' value='"+treeNode.id+"'/>";
							    		var usermage="<input id='mage' type='hidden' value='dept'/>";
							    		var newTr="";
							    		for(var i in data){
											 newTr += "<p><input type='checkbox' name='ckPermission' value="+data[i].id+" >&nbsp;&nbsp;"+data[i].name+"<p>";
							    		}
							    		
									$("#allPermission").html(newTr);
									$("#hiddenDeptId").html(deptId);	
									$("#usermage").html(usermage);//标识，当前是人员授权还是部门授权，空为人员，usr为人员
									$("#modalForm").modal();
							    	},
							    	error:function(){
							    		alert("请求错误!");
							    	}
							    });		
						});
}; 

 function initLoadDept(){
		treeObj = $.fn.zTree.init($("#deptTree"), setting);	 
}
 //下面是document.ready！-------简写而已 
$(function(){		
$("#btnsub").click(function(){
	//Jquery↓方式
	var v=$("input[name='ckPermission']");
	//JS↓方式
	//var v=document.getElementsByName('ckPermission'); 		
			var s='';
			var split = '';
			if(v!=null&v!=""){
				for(var i=0; i<v.length; i++){
					if(v[i].checked){
						s+= split + v[i].value; //如果选中，将value添加到变量s中
						split = ','
					} 					
				}
					if(s==""){
					 alert("请选择权限");
					}else{										
						if('usr'==$("#mage").val()){
							//alert("进入usr");
							var uid=$("#userid").val();
							 $.ajax({
							    	url:paths+"/per/authorizingPermissionUser.shtml",
							    	type:"POST",
							    	dataType:"html",
							    	data:{permissionList:s,uid:uid},
							    	success:function(data){	
							    		if("succ"==data){
							    			layer.msg("授权成功!");
							    			$("#modalForm").modal('hide');
							    			checkUserPerission(uid);
							    		}else{
							    			layer.msg("授权失败,请先检查您的个人权限");
							    		}
							    	},
							    	error:function(){
							    		alert("请求错误!");
							    	}
							    });	
						}else{
							//alert("进入dept");
							var deptid=$("#deptid").val();
							 $.ajax({
							    	url:paths+"/per/authorizingPermissionDept.shtml",
							    	type:"POST",
							    	dataType:"html",
							    	data:{permissionList:s,deptid:deptid},
							    	success:function(data){	
							    		if("succ"==data){
							    			layer.msg("授权成功!");
							    			$("#modalForm").modal('hide');
							    			selectDeptPermission(deptid);
							    		}else{
							    			layer.msg("授权失败,请先检查您的个人权限");
							    		}
							    	},
							    	error:function(){
							    		alert("请求错误!");
							    	}
							    });								 							
						}
					}						
			}			
});		
});
 