package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CategoryDAO {
    private final SessionFactory sessionFactory;

    public CategoryDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public boolean saveCategory(Category category) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        boolean flag=false;
        try {
            transaction = session.beginTransaction();
            session.save(category);
            transaction.commit();
            flag=true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return flag;
    }

    public void updateCategory(Category category) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.update(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public void deleteCategory(Category category) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.delete(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public List<Category> getAllCategories() {
        Session session = sessionFactory.openSession();
        try {
            Query<Category> query = session.createQuery("FROM Category", Category.class);
            return query.list();
        } finally {
            session.close();
        }
    }

    public Category getCategoryById(String categoryId) {
        Session session = sessionFactory.openSession();
        try {
            return session.get(Category.class, categoryId);
        } finally {
            session.close();
        }
    }
    public long getCategoryCount() {
        Session session = sessionFactory.openSession();
        try {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Category", Long.class);
            return query.uniqueResult();
        } finally {
            session.close();
        }
    }
}
