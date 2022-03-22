package dataaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import models.User;

/**
 *
 * @author Administrator
 */
public class UserDB 
{
    public List<User> getAll() throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        
        try {
            Query query = em.createNamedQuery("User.findAll");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public User get(String email) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        
        try {
            User user = em.find(User.class, email);
            return user;
        } finally {
            em.close();
        }
    }

    public void insert(User user) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();//begin a DML operation to database
        
        //If the transaction is successful, commit the changes to the database. 
        //If the transaction isn’t successful, roll back any changes.
        try {
            trans.begin();
            em.persist(user);//Inserts an entity into the database
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public void update(User user) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();//begin a DML operation to database
        
        //If the transaction is successful, commit the changes to the database. 
        //If the transaction isn’t successful, roll back any changes.
        try {
            trans.begin();
            em.merge(user);//Inserts an entity into the database
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public void delete(User user) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            trans.begin();
            em.remove(em.merge(user));//need to attach entity before deleting it.
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
        } finally {
            em.close();
        }
    }
}
