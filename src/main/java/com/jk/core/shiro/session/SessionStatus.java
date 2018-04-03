package com.jk.core.shiro.session;

import java.io.Serializable;

/**
 * @author Mr.KangJonney
 * @date   2017年10月10日
 * @remark Session 状态 VO
 */
public class SessionStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	//是否踢出 true:有效，false：踢出。
	private Boolean onlineStatus = Boolean.TRUE;

	
	public Boolean isOnlineStatus(){
		return onlineStatus;
	}

	public Boolean getOnlineStatus() {
		return onlineStatus;
	}
	public void setOnlineStatus(Boolean onlineStatus) {
		this.onlineStatus = onlineStatus;
	}
	
	
}
