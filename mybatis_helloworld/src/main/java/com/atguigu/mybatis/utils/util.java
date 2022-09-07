package com.atguigu.mybatis.utils;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class util {
    private static SqlSession getSession() {
        SqlSession sqlSession =null;
        try {
            InputStream is = Resources.getResourceAsStream("xml");
            SqlSessionFactoryBuilder sqlSessionFactoryBuilder = new SqlSessionFactoryBuilder();
            SqlSessionFactory sqlSessionFactory = sqlSessionFactoryBuilder.build(is);
             sqlSession = sqlSessionFactory.openSession(true);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return sqlSession;
    }
}
