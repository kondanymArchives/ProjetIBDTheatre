/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package td2gestiondynamiquedulayoutavcjavaswing;

import java.awt.Color;
import java.awt.Frame;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import static java.lang.Thread.sleep;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
/**
 *
 * @author kondanym
 */

 class Fenetre01 extends JFrame implements ActionListener 
 {   JPanel panel; 
     JMenuBar mbar; 
     JMenu m1; 
     JMenu m2;
   
 public Fenetre01() throws InterruptedException 
    
  { 
       setTitle("Test de JFrame"); 
       setSize(300,200); 
       // gestion evenementielle de la fermeture de la fenêtre 
       addWindowListener(new WindowAdapter() 
               
               
           { public void windowClosing(WindowEvent e) 
                  {System.exit(0);} 
           } ) ;
       
  
 
    panel = new JPanel();
    
    Container contentPane = getContentPane();
    panel.setBackground(Color.blue); 
    contentPane.add(panel);
    
    mbar = new JMenuBar();
    
    m1 = new JMenu("Couleur Font");
    JMenuItem m11 = new JMenuItem("jaune");
    m11.addActionListener(this); 
    JMenuItem m12 = new JMenuItem("rouge");
    m12.addActionListener(this); 
    m1.add(m11);
    m1.add(m12);
       
    m2 = new JMenu("Couleur Menu");
    JMenuItem m21 = new JMenuItem("bleu");
    m21.addActionListener(this); 
    JMenuItem m22 = new JMenuItem("vert");  
    m22.addActionListener(this);
    m2.add(m21);
    m2.add(m22); 
    
    mbar.add(m1);
    mbar.add(m2);
    setJMenuBar(mbar);
   
}
    
 
 
 
 public void actionPerformed(ActionEvent evt){
     
        { if (evt.getSource()instanceof JMenuItem){
            
            //ici getion des evenements 
            String choixOption = evt.getActionCommand();
            if (choixOption.equals("jaune"))panel.setBackground(Color.yellow);
            else if (choixOption.equals("rouge"))panel.setBackground(Color.red);
            
            else if (choixOption.equals("bleu")){
                mbar.setBackground(Color.blue);
                m1.setBackground(Color.blue);
                m2.setBackground(Color.blue);
            }
            
            else if (choixOption.equals("vert")){
                mbar.setBackground(Color.green);
                m1.setBackground(Color.green);
                m2.setBackground(Color.green);
            }    
               
    }
}
}

}
