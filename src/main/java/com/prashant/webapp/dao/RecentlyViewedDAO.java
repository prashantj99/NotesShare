package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Notes;
import org.hibernate.*;
import org.hibernate.query.Query;
import com.prashant.webapp.entities.RecentlyViewed;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.UserIdGenerator;
import java.sql.Timestamp;
import java.util.List;

public class RecentlyViewedDAO {

    private SessionFactory factory;

    public RecentlyViewedDAO(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean add(String userId, String noteId) {
        boolean flag = false;
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            System.out.println("userId: " + userId);
            System.out.println("noteId: " + noteId);

            User user = session.get(User.class, userId);
            Notes note = session.get(Notes.class, noteId);

            // Check if a RecentlyViewed entry with the same noteId exists
            Query<RecentlyViewed> query = session.createQuery(
                    "FROM RecentlyViewed rv WHERE rv.user = :user AND rv.note = :note",
                    RecentlyViewed.class
            );
            query.setParameter("user", user);
            query.setParameter("note", note);
            RecentlyViewed existingEntry = query.uniqueResult();

            RecentlyViewed recentlyViewed;

            if (existingEntry != null) {
                // Update the existing entry's timestamp
                recentlyViewed = existingEntry;
                recentlyViewed.setViewedTimestamp(new Timestamp(System.currentTimeMillis()));
            } else {
                // Create a new RecentlyViewed entry
                recentlyViewed = new RecentlyViewed();
                recentlyViewed.setUser(user);
                recentlyViewed.setNote(note);
                recentlyViewed.setId(UserIdGenerator.generateUserId());
                recentlyViewed.setViewedTimestamp(new Timestamp(System.currentTimeMillis()));

            }

            note.setViews(note.getViews() + 1); // Increment the view count
            session.update(note); // Update the view count in the Notes entity

            session.saveOrUpdate(recentlyViewed);
            transaction.commit();
            flag = true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
                flag = false;
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return flag;
    }

    public List<Notes> getRecentNotes(String userId) {
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();

            // Retrieve the 10 most recent items
            Query<RecentlyViewed> retrieveQuery = session.createQuery(
                    "FROM RecentlyViewed rv WHERE rv.user = :user ORDER BY rv.viewedTimestamp DESC",
                    RecentlyViewed.class
            );
            User user = session.get(User.class, userId);
            retrieveQuery.setParameter("user", user);
            retrieveQuery.setMaxResults(10);
            List<RecentlyViewed> recentlyViewedNotes = retrieveQuery.getResultList();
            
            // Delete any remaining entries
            Query deleteQuery = session.createQuery(
                    "DELETE FROM RecentlyViewed rv WHERE rv.user = :user AND rv NOT IN (:recentlyViewedNotes)"
            );
            deleteQuery.setParameter("user", user);
            deleteQuery.setParameterList("recentlyViewedNotes", recentlyViewedNotes);
            deleteQuery.executeUpdate();
            
            Query<Notes> retrieveNotesQuery = session.createQuery(
                    "SELECT note FROM RecentlyViewed rv WHERE rv.user = :user ORDER BY rv.viewedTimestamp DESC",
                    Notes.class
            );
            retrieveNotesQuery.setParameter("user", user);
            List<Notes> recentNotes = retrieveNotesQuery.getResultList();

            transaction.commit();
            return recentNotes;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

}
