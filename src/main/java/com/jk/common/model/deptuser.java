package com.jk.common.model;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import net.sf.json.JSONObject;

public class deptuser implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	private String pId;
	private String name;
	private List<UPermission> permissions = new LinkedList<UPermission>();
    private String url;
	
	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getpId() {
		return pId;
	}


	public void setpId(String pId) {
		this.pId = pId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public List<UPermission> getPermissions() {
		return permissions;
	}


	public void setPermissions(List<UPermission> permissions) {
		this.permissions = permissions;
	}


	public String toString() {
		return JSONObject.fromObject(this).toString();
	}
}
