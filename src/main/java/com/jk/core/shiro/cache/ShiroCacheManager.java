package com.jk.core.shiro.cache;

import org.apache.shiro.cache.Cache;

/**
 * @author Mr.KangJonney
 * @date   2017年10月10日
 * @remark shiro cache manager 接口
 */
public interface ShiroCacheManager {

    <K, V> Cache<K, V> getCache(String name);

    void destroy();

}
