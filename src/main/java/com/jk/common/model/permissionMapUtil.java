package com.jk.common.model;

import java.util.List;

public class permissionMapUtil {
  private List<String> permissionList;
  private int mainid;//前端进行标识，这里的mainId指的是userid，deptid
  private int number;//权限

public List<String> getPermissionList() {
	return permissionList;
}
public void setPermissionList(List<String> permissionList) {
	this.permissionList = permissionList;
}

public int getMainid() {
	return mainid;
}
public void setMainid(int mainid) {
	this.mainid = mainid;
}
public int getNumber() {
	return number;
}
public void setNumber(int number) {
	this.number = number;
}

}
