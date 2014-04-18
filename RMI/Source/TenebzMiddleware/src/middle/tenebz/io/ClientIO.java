/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package middle.tenebz.io;

import java.rmi.Remote;
import java.rmi.RemoteException;
import middle.tenebz.beans.Client;
import middle.tenebz.beans.Message;

/**
 *
 * @author TOURE
 */
public interface ClientIO extends Remote {

    public void receive(Message msg) throws RemoteException;

    public Client getClient() throws RemoteException;

}
