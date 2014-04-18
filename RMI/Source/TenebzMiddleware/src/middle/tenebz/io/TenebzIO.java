/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package middle.tenebz.io;

import java.rmi.*;
import java.util.List;
import middle.tenebz.beans.Client;
import middle.tenebz.beans.Message;

/**
 *
 * @author loic
 */
public interface TenebzIO extends Remote {
    
    public boolean register(Client client) throws RemoteException;

    public boolean join(ClientIO client) throws RemoteException;

    public void leave(ClientIO client) throws RemoteException;

    public void push(Message message) throws RemoteException;

    public void broadcast(Message message) throws RemoteException;
    
    public List<Message> history() throws RemoteException;

}
