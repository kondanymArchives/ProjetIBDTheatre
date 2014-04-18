/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package middle.tenebz.beans;

import java.io.Serializable;
import java.util.*;

/**
 *
 * @author loic
 */
public class Message implements Serializable {

    private Client client;
    private String contenu;
    private Date date;

    public Message(Client client, String contenu, Date date) {
        this.client = client;
        this.contenu = contenu;
        this.date = date;
    }

    public Date getDate() {
        return this.date;
    }

    public Client getClient() {
        return this.client;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }
}
