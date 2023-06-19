package com.prashant.webapp.dao;

import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class UserDAO {
    private SessionFactory factory;

    public UserDAO(SessionFactory factory) {
        this.factory = factory;
    }
    
    public boolean addUser(User user) {
        Transaction transaction = null;
        boolean flag=false;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();
            session.close();
            flag=true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return flag;
    }

    public User getUserByEmail(String userEmail) {
        try{
            User user=null;
            String hql = "from User where userEmail =: email";
            Session session=factory.openSession();
            Query query = session.createQuery(hql);
            query.setParameter("email", userEmail);
            user=(User)query.uniqueResult();
            session.close();
            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByUserId(String userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "FROM User WHERE userId = :userId";
            return session.createQuery(hql, User.class)
                    .setParameter("userId", userId)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        Transaction transaction = null;
        boolean flag=false;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(user);
            transaction.commit();
            flag=true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
                flag=false;
            }
            e.printStackTrace();
        }
        return flag;
    }

    public void deleteUser(User user) {
        Transaction transaction = null;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public List<User> getAllUsers() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "FROM User";
            return session.createQuery(hql, User.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
