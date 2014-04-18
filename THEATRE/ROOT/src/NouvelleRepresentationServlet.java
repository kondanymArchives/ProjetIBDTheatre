/*
 * @(#)NouvelleRepresentationServlet.java	1.0 2007/10/31
 * 
 * Copyright (c) 2007 Sara Bouchenak.
 */
import accesBD.*;
import exceptions.ExceptionConnexion;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * NouvelleRepresentation Servlet.
 *
 * This servlet dynamically adds a new date a show.
 *
 * @author <a href="mailto:Sara.Bouchenak@imag.fr">Sara Bouchenak</a>
 * @version 1.0, 31/10/2007
 */

public class NouvelleRepresentationServlet extends HttpServlet {

   /**
    * HTTP GET request entry point.
    *
    * @param req	an HttpServletRequest object that contains the request 
    *			the client has made of the servlet
    * @param res	an HttpServletResponse object that contains the response 
    *			the servlet sends to the client
    *
    * @throws ServletException   if the request for the GET could not be handled
    * @throws IOException	 if an input or output error is detected 
    *				 when the servlet handles the GET request
    */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
    {
	  String numS, dateS, heureS;
          ServletOutputStream out = res.getOutputStream();   

	  res.setContentType("text/html");

	  out.println("<HEAD><TITLE> Ajouter une nouvelle representation </TITLE></HEAD>");
	  out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
	  out.println("<font color=\"#FFFFFF\"><h1> Ajouter une nouvelle representation </h1>");

	  numS		= req.getParameter("numS");
	  dateS		= req.getParameter("date");
	  heureS	= req.getParameter("heure");
	  if (numS == null || dateS == null || heureS == null) {
              
            	out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives a la nouvelle representation :");
            	out.println("<P>");
                
            	out.print("<form action=\"");
                out.print("NouvelleRepresentationServlet\" ");
            	out.println("method=POST>");
            	out.println("Numero de spectacle :");
            	out.println("<input type=text size=20 name=numS>");
            	out.println("<br>");
            	out.println("Date de la representation :");
            	out.println("<input type=text size=20 name=date>");
            	out.println("<br>");
            	out.println("Heure de debut de la representation :");
            	out.println("<input type=text size=20 name=heure>");
            	out.println("<br>");
            	out.println("<input type=submit>");
            	out.println("</form>");
	  } else {
	  	// TO DO
		// Transformation des parametres vers les types adequats.
	  	// Ajout de la nouvelle representation.
	  	// Puis construction dynamique d'une page web de reponse.

          			// Ajout de la nouvelle repr�sentation.
			//connection � la BD
//			String insertRep = "INSERT INTO LesRepresentations (numS , dateRep) VALUES (1, '23/11/2014');";
	        String requete = "INSERT INTO LesRepresentations (numS , dateRep) VALUES (?, ?)"; 
			
		int resultat=0;
		try{
	    
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());           
          }     catch (SQLException ex) {
                out.println("Impossible de charger le Driver");
          }  
          

/* Connexion à la base de données */
String url = "jdbc:oracle:thin:@195.220.82.190:1521:ufrima";
String utilisateur = "demarcje";
String motDePasse = "bd2012";
Connection connexion = null;
ResultSet results = null;   
PreparedStatement stmt = null;          
              
              try {
                  connexion = DriverManager.getConnection( url, utilisateur, motDePasse );            
              
              try {
                  stmt = connexion.prepareStatement(requete);
                  stmt.setInt(1, Integer.valueOf(numS));
                  stmt.setTimestamp(2, new Timestamp((new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(dateS+" "+heureS).getTime()));
                  resultat = stmt.executeUpdate();
                  connexion.commit();
                  connexion.close();
              }
              catch(Exception e){
                  e.printStackTrace();
                  out.println("Exception du a la requete : "+e);  } 
              
              }catch (SQLException ex) {
                  out.println("Connection a la bd impossible");
              } 
    
    /* Fermeture de la connexion */          
    /* Si une erreur survient lors de la fermeture, il
     suffit de l'ignorer. */
    
    finally {
    
    if (results != null){
        try{ results.close(); } catch (SQLException ignore) {
            
        }
    }
    if ( stmt != null){
        try{ stmt.close(); } catch (SQLException ignore) {
            
        }
}
    if ( connexion != null ){
        
        try{

         connexion.close(); } catch ( SQLException ignore ) {
             
}
}
}
              
			// Puis construction dynamique d'une page web de r�ponse.
			if(resultat==0)
			{
				out.println("<p><i><font color=\"#FFFFFF\">Echec de l'ajout de la nouvelle representation! Contactez l'admin.</i></p>");
			}
			else
			{
				out.println("<p><i><font color=\"#FFFFFF\">Ajout de la representation effectue avec succes!</i></p>");
				out.println("<p><i><font color=\"#FFFFFF\">Numero de la nouvelle representation : "+numS+"</i></p>");
				out.println("<p><i><font color=\"#FFFFFF\">Date de la nouvelle representation : "+dateS+"</i></p>");
			}    
              	  out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/admin/admin.html\">Page d'administration</a></p>");
	          out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/index.html\">Page d'accueil</a></p>");
	          out.println("</BODY>");
	          out.close();
              
//mes bidouilles
//--------------------------------------------------------------------------------------------------
/*             
              //Chargement du Driver:
        try{ DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());           
        } catch (SQLException ex) {
            Logger.getLogger(ProgrammeServlet.class.getName()).log(Level.SEVERE, null, ex);
            out.println("Impossible de charger le Driver");
        }


              // Connexion à la base de données 
String url = "jdbc:oracle:thin:@195.220.82.190:1521:ufrima";
String utilisateur = "demarcje";
String motDePasse = "bd2012";
Connection connexion = null;
ResultSet results = null;   
Statement stmt = null;

try {
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());   
         connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
//Ici, nous placons nos requêtes vers la BDD 
//...

//Execution de la transaction SQL;
try {             
         stmt = connexion.createStatement();	
         stmt.executeUpdate("INSERT INTO LesRepresentations VALUES (111, '01-JAN-08')");
}catch (SQLException e) { out.println("Enregistrement sur la bd echouee"); }

}catch (SQLException e) { out.println("Connection (1) impossible a la bd");
}
finally {
    if (stmt != null) {
 try{   stmt.close();}
 catch (SQLException ignore){ }
    }
    if( connexion != null) {
 try{   connexion.close();}
 catch (SQLException ignore){ }
    }
}             

try {      
         DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());   
         connexion = DriverManager.getConnection( url, utilisateur, motDePasse );

         try {
         stmt = connexion.createStatement();	
         results = stmt.executeQuery("SELECT * FROM LesRepresentations");
         String s = new String();
		      while( results.next() ){
                              s = results.getString(1);
              
               	out.println("<p><i><font color=\"#FFFFFF\">"+s+"</i></p>");
	  	out.println("<p><i><font color=\"#FFFFFF\">...</i></p>");
                      }                
         }catch (SQLException e) { out.println("Requete (2) impossible"); }

}catch (SQLException e) { out.println("Connection (2) a la bd refusee"); }         
finally {      
        
    if( results != null ){
        try{ results.close(); }
        catch (SQLException ignor) {  }
        }
    if( stmt != null ){
        try{ stmt.close(); }
        catch (SQLException ignor) {  } 
        }   
    if( connexion != null ){
        try{ connexion.close(); }
        catch (SQLException ignor) {  }        
        }
}
*/
//----------------------------------------------------------------------------------------------------------              
          
}
}
                
   /**
    * HTTP POST request entry point.
    *
    * @param req	an HttpServletRequest object that contains the request 
    *			the client has made of the servlet
    * @param res	an HttpServletResponse object that contains the response 
    *			the servlet sends to the client
    *
    * @throws ServletException   if the request for the POST could not be handled
    * @throws IOException	   if an input or output error is detected 
    *					   when the servlet handles the POST request
    */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
    {
	  doGet(req, res);
    }

   /**
    * Returns information about this servlet.
    *
    * @return String information about this servlet
    */

    public String getServletInfo() {
        return "Ajoute une representation a une date donnee pour un spectacle existant";
    }

}
