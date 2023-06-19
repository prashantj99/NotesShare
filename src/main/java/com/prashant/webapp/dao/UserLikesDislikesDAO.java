package com.prashant.webapp.dao;

import com.prashant.webapp.entities.UserLikesDislikes;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.util.UserIdGenerator;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserLikesDislikesDAO {

    private SessionFactory sessionFactory;

    public UserLikesDislikesDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public boolean addOrUpdateLikeOrDislike(String userId, String noteId, String action) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        boolean flag = false;
        try {
            tx = session.beginTransaction();

            // Check if the user has already liked or disliked the note
            UserLikesDislikes existingLikesDislikes = getUserLikesDislikes(userId, noteId, session);

            if (existingLikesDislikes != null) {
                // User has already liked or disliked the note, update the action
                String previousAction = existingLikesDislikes.getAction();

                if (previousAction.equalsIgnoreCase(action)) {
                    // If the user is tapping the same action again
                    updateNotesLikesDislikes(noteId, userId, null, session);
                    session.delete(existingLikesDislikes);
                    tx.commit();
                    return true;
                } else {
                    // Decrement the counters based on the previous action
                    updateNotesLikesDislikes(noteId, userId, action, session);
                }

                existingLikesDislikes.setAction(action);
                session.update(existingLikesDislikes);
            } else {
                // Insert a new row in the UserLikesDislikes table
                UserLikesDislikes userLikesDislikes = new UserLikesDislikes();
                User user = session.get(User.class, userId);
                Notes note = session.get(Notes.class, noteId);
                userLikesDislikes.setId(UserIdGenerator.generateUserId());
                userLikesDislikes.setUser(user);
                userLikesDislikes.setNote(note);
                userLikesDislikes.setAction(action);
                // Update the notesLikes and notesDislikes in the Notes entity
                updateNotesLikesDislikes(noteId, userId, action, session);
                session.save(userLikesDislikes);
            }

            tx.commit();
            flag = true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return flag;
    }

    private UserLikesDislikes getUserLikesDislikes(String userId, String noteId, Session session) {
        Query<UserLikesDislikes> query = session.createQuery(
                "FROM UserLikesDislikes uld WHERE uld.user = :user AND uld.note = :note",
                UserLikesDislikes.class
        );
        query.setParameter("user", session.get(User.class, userId));
        query.setParameter("note", session.get(Notes.class, noteId));
        return query.uniqueResult();
    }

    private void updateNotesLikesDislikes(String noteId, String userId, String action, Session session) {
        Notes note = session.get(Notes.class, noteId);
        if (note != null) {
            // Get the previous action of the user for the given note
            UserLikesDislikes previousAction = getUserLikesDislikes(userId, noteId, session);
            System.out.println("previous action : " + previousAction);
            if (previousAction != null) {
                String previousActionType = previousAction.getAction();

                if (previousActionType.equalsIgnoreCase("like")) {
                    note.setLikes(note.getLikes() - 1);
                } else if (previousActionType.equalsIgnoreCase("dislike")) {
                    note.setDislikes(note.getDislikes() - 1);
                }
            }

            if (action != null) {
                if (action.equalsIgnoreCase("like")) {
                    note.setLikes(note.getLikes() + 1);
                } else if (action.equalsIgnoreCase("dislike")) {
                    note.setDislikes(note.getDislikes() + 1);
                }
            }

            session.update(note);
        }
    }
}
