package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Course;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CourseDAO {
    private final SessionFactory sessionFactory;

    public CourseDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public boolean saveCourse(Course course) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        boolean flag=false;
        try {
            transaction = session.beginTransaction();
            session.save(course);
            transaction.commit();
            flag=true;
            return flag;
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

    public void updateCourse(Course course) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.update(course);
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

    public void deleteCourse(Course course) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.delete(course);
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

    public List<Course> getAllCourses() {
        Session session = sessionFactory.openSession();
        try {
            Query<Course> query = session.createQuery("FROM Course", Course.class);
            return query.list();
        }catch(Exception e){
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

    public Course getCourseById(String courseId) {
        Session session = sessionFactory.openSession();
        try {
            return session.get(Course.class, courseId);
        } finally {
            session.close();
        }
    }
    public List<Course> getPaginatedCourses(int pageNumber, int itemsPerPage) {
        Session session = sessionFactory.openSession();
        try {
            Query query = session.createQuery("FROM Course");
            query.setFirstResult((pageNumber - 1) * itemsPerPage);
            query.setMaxResults(itemsPerPage);
            System.out.println("ok for now");
            return query.list();
        }catch(Exception e){
            e.printStackTrace();
        } finally {
//            session.close();
        }
        return null;
    }
    public long getCourseCount() {
        Session session = sessionFactory.openSession();
        try {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Course", Long.class);
            return query.uniqueResult();
        } finally {
            session.close();
        }
    }
}
