package com.app.services;

import redis.clients.jedis.Jedis;

public class Cache {
    private static Jedis jedis = new Jedis("redis://localhost:6379");

    public static String get(String key) {
        String value = jedis.get(key);
        if (value.isEmpty()) {
            Logger.warning("Cache miss for : " + key);
        }
        return value;
    }

    public static String set(String key, String value) {
        return jedis.set(key, value);
    }

    public static Long del(String key) {
        return jedis.del(key);
    }

    public static Boolean exists(String key) {
        return jedis.exists(key);
    }

    public static Long expire(String key, int seconds) {
        return jedis.expire(key, seconds);
    }

    public static void close() {
        if (jedis != null) {
            jedis.close();
        }
    }
}
