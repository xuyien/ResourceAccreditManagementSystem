package com.jk.core.shiro.cache.impl;

import org.apache.shiro.cache.Cache;

import com.jk.core.shiro.cache.JedisManager;
import com.jk.core.shiro.cache.JedisShiroCache;
import com.jk.core.shiro.cache.ShiroCacheManager;

/**
 * @author Mr.KangJonney
 * @date   2017年10月10日
 * @remark JRedis管理
 */
public class JedisShiroCacheManager implements ShiroCacheManager {

    private JedisManager jedisManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) {
        return new JedisShiroCache<K, V>(name, getJedisManager());
    }

    @Override
    public void destroy() {
    	//如果和其他系统，或者应用在一起就不能关闭
    	//getJedisManager().getJedis().shutdown();
    }

    public JedisManager getJedisManager() {
        return jedisManager;
    }

    public void setJedisManager(JedisManager jedisManager) {
        this.jedisManager = jedisManager;
    }
}
