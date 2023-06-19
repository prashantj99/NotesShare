package com.prashant.webapp.util;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {
    private static SessionFactory factory;
    //
    public static SessionFactory getSessionFactory() {
        try{
            if(factory == null){
                factory=new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            }
        }catch(HibernateException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }
        return factory;
    } 
}
