package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Department;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class DepartmentDAO {
    private final SessionFactory sessionFactory;

    public DepartmentDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public boolean saveDepartment(Department department) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        boolean flag=false;
        try {
            transaction = session.beginTransaction();
            session.save(department);
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

    public void updateDepartment(Department department) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.update(department);
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

    public void deleteDepartment(Department department) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.delete(department);
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

    public List<Department> getAllDepartments() {
        Session session = sessionFactory.openSession();
        try {
            Query<Department> query = session.createQuery("FROM Department", Department.class);
            return query.list();
        } finally {
            session.close();
        }
    }
    public Department getDepartmentById(String departmentId) {
        Session session = sessionFactory.openSession();
        try {
            return session.get(Department.class, departmentId);
        } finally {
            session.close();
        }
    }
    public long getDepartmentCount() {
        Session session = sessionFactory.openSession();
        try {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Department", Long.class);
            return query.uniqueResult();
        } finally {
            session.close();
        }
    }
}
