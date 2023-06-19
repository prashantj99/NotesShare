package com.prashant.webapp.dao;

import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.entities.SavedNotes;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.UserIdGenerator;
import java.sql.Timestamp;
import java.util.List;
import org.hibernate.*;
import org.hibernate.query.Query;

public class SavedNotesDao {

    private SessionFactory factory;

    public SavedNotesDao(SessionFactory factory) {
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

            // Check if the note is already saved for the user
            Query<SavedNotes> query = session.createQuery(
                    "FROM SavedNotes sn WHERE sn.user = :user AND sn.note = :note",
                    SavedNotes.class
            );
            query.setParameter("user", user);
            query.setParameter("note", note);
            SavedNotes existingEntry = query.uniqueResult();
            if (existingEntry != null) {
                // Update the timestamp of the existing SavedNotes entry
                existingEntry.setTimestamp(new Timestamp(System.currentTimeMillis()));
                session.update(existingEntry);
            } else {
                // Create a new SavedNotes entry
                SavedNotes savedNotes = new SavedNotes();
                savedNotes.setUser(user);
                savedNotes.setNote(note);
                savedNotes.setId(UserIdGenerator.generateUserId());
                savedNotes.setTimestamp(new Timestamp(System.currentTimeMillis()));
                session.save(savedNotes);
            }
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

    public boolean isAlreadySaved(String noteId, String userId) {
        Session session = factory.openSession();
        try {
            User user = session.get(User.class, userId);
            Notes note = session.get(Notes.class, noteId);

            // Check if the note is already saved for the user
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(*) FROM SavedNotes sn WHERE sn.user = :user AND sn.note = :note",
                    Long.class
            );
            query.setParameter("user", user);
            query.setParameter("note", note);
            Long count = query.uniqueResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    public List<Notes> getAllNotesFromSavedNotesByUser(String userId) {
        Session session = factory.openSession();
        try {
            User user = session.get(User.class, userId);
            Query<Notes> query = session.createQuery(
                    "SELECT sn.note FROM SavedNotes sn WHERE sn.user = :user",
                    Notes.class
            );
            query.setParameter("user", user);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
    public boolean removeNote(String userId, String noteId) {
        boolean flag = false;
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();

            User user = session.get(User.class, userId);
            Notes note = session.get(Notes.class, noteId);

            // Check if the note is saved for the user
            Query<SavedNotes> query = session.createQuery(
                    "FROM SavedNotes sn WHERE sn.user = :user AND sn.note = :note",
                    SavedNotes.class
            );
            query.setParameter("user", user);
            query.setParameter("note", note);
            SavedNotes savedNote = query.uniqueResult();

            if (savedNote != null) {
                session.delete(savedNote);
                flag = true;
            }

            transaction.commit();
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

}
