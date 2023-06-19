package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.util.FactoryProvider;
import java.util.ArrayList;
import java.util.HashSet;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class NotesDAO {

    private final SessionFactory sessionFactory;

    public NotesDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public boolean saveNotes(Notes notes) {
        boolean flag = false;
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.save(notes);
            transaction.commit();
            flag = true;
            return flag;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
                return flag;
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return flag;
    }

    public boolean updateNotes(Notes notes) {
        boolean flag=false;
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.update(notes);
            transaction.commit();
            flag=true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            flag=false;
            e.printStackTrace();
        } finally {
            session.close();
        }
        return flag;
    }

    public void deleteNotes(Notes notes) {
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.delete(notes);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
//            session.close();
        }
    }

    public List<Notes> getAllNotes() {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes", Notes.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Notes> getAllNotVerifiedNotes() {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes WHERE status = 0", Notes.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Notes getNotesById(String noteId) {
        Session session = sessionFactory.openSession();
        try {
            return session.get(Notes.class, noteId);
        } finally {
            session.close();
        }
    }

    public List<Notes> getNotesByDepartmentId(String departmentId) {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes WHERE department.departmentId = :departmentId", Notes.class);
            query.setParameter("departmentId", departmentId);
            return query.list();
        } finally {
            session.close();
        }
    }

    public List<Notes> getNotesByUserId(String userId) {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes WHERE user_userId = :userId", Notes.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Notes> getNotesByCategoryId(String categoryId) {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes WHERE category.categoryId = :categoryId", Notes.class);
            query.setParameter("categoryId", categoryId);
            return query.list();
        } finally {
            session.close();
        }
    }

    public List<Notes> getNotesByTagName(String tagName) {
        Session session = sessionFactory.openSession();
        try {
            Query<Notes> query = session.createQuery("FROM Notes WHERE noteTags LIKE :tagName", Notes.class);
            query.setParameter("tagName", "%" + tagName + "%");
            return query.list();
        } finally {
            session.close();
        }
    }

    public boolean updateNotesStatus(String noteId, int status) {
        boolean flag = false;
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Query query = session.createQuery("update Notes set status = :status where noteId = :noteId");
            query.setParameter("status", status);
            query.setParameter("noteId", noteId);
            query.executeUpdate();
            transaction.commit();
            flag = true;
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

    public HashSet<Notes> search(String searchString, int offset) {
        HashSet<Notes> results = new HashSet<>();
        Session session = sessionFactory.openSession();
        try {
            searchString = searchString.trim().toLowerCase();
            String hql = "SELECT DISTINCT n FROM Notes n "
                    + "JOIN FETCH n.category c "
                    + "JOIN FETCH n.department d "
                    + "JOIN FETCH n.course cr "
                    + "WHERE lower(c.categoryName) LIKE :keyword "
                    + "OR lower(d.departmentName) LIKE :keyword "
                    + "OR lower(n.noteUniversity) LIKE :keyword "
                    + "OR lower(cr.courseName) LIKE :keyword "
                    + "OR lower(n.noteDescription) LIKE :keyword "
                    + "OR lower(n.noteTags) LIKE :keyword";
            Query query = session.createQuery(hql);
            query.setParameter("keyword", "%" + searchString + "%");
            // Apply pagination
            query.setFirstResult(offset);
            query.setMaxResults(10); // Retrieve 10 notes per page

            List<Notes> notes = query.getResultList();
            results.addAll(notes);

            return results;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return results;
    }
    public long getNotesCount(int status) {
        Session session = sessionFactory.openSession();
        try {
            Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Notes WHERE status = :status", Long.class);
            query.setParameter("status", status);
            return query.uniqueResult();
        } finally {
            session.close();
        }
    }
}
