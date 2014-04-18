/*
 * @(#)ProgrammeServlet.java	1.0 2007/10/31
 * 
 * Copyright (c) 2007 Sara Bouchenak.
 */
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import accesBD.*;
import exceptions.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import modele.*;
import utils.*;
/**
 * Proramme Servlet.
 *
 * This servlet dynamically returns the theater program.
 *
 * @author <a href="mailto:Sara.Bouchenak@imag.fr">Sara Bouchenak</a>
 * @version 1.0, 31/10/2007
 */

public class ProgrammeServlet extends HttpServlet {

   /**
    * HTTP GET request entry point.
    *
    * @param req	an HttpServletRequest object that contains the request 
    *			the client has made of the servlet
    * @param res	an HttpServletResponse object that contains the response 
    *			the servlet sends to the client
    *
    * @throws ServletException   if the request for the GET could not be handled
    * @throws IOException	   if an input or output error is detected 
    *					   when the servlet handles the GET request
    */
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
    {
        ServletOutputStream out = res.getOutputStream();   

	  res.setContentType("text/html");

	  out.println("<HEAD><TITLE> Programme de la saison </TITLE></HEAD>");
	  out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
	  out.println("<font color=\"#FFFFFF\"><h1> Programme de la saison : </h1>");
      
            // TO DO
            // Récupération de la liste de tous les spectacles de la saison.
            // Puis construction dynamique d'une page web décrivant ces spectacles.
            
            /*
            //connection à la BD
            String query = "SELECT nomS FROM LesSpectacles;";
            
            try{
            BDConnexion bdcon = new BDConnexion();
            
            Connection con = BDConnexion.getConnexion("kondanym","bd2012");
            //System.out.println("HELLO WORLD!");
            
            ResultSet results;
            try {
            Statement stmt = con.createStatement();
            
            results = stmt.executeQuery(query);
            
            String s = new String();
            while( results.next() ){
            s=results.getString(1);
            out.println("<p><i><font color=\"#FFFFFF\">"+s+"</i></p>");
            }
            }
            catch(SQLException e){
            System.out.println("exception du a la requete");
            } catch (IOException e) {
            System.out.println("exception du a la requete");
            }
            }catch(ExceptionConnexion e){
            
            System.out.println("Création de l'objet BDConnexion impossible : "+e);
            }
            
            */
            
/*Chargement du Driver:*/
try{ DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());           
        } catch (SQLException ex) {
            Logger.getLogger(ProgrammeServlet.class.getName()).log(Level.SEVERE, null, ex);
            out.println("Impossible de charger le Driver");
        }


/* Connexion à la base de données */
String url = "jdbc:oracle:thin:@195.220.82.190:1521:ufrima";
String utilisateur = "demarcje";
String motDePasse = "bd2012";
Connection connexion = null;
ResultSet results = null;   
Statement stmt = null;

try {
connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
/* Ici, nous placons nos requêtes vers la BDD */
/* ... */

//Execution de la Requete SQL;
try {    
stmt = connexion.createStatement();	

         results = stmt.executeQuery("SELECT nomS FROM LesSpectacles");
				
	       String s = new String();
		      while( results.next() ){
                              s = results.getString(1);
			          out.println("<p><i><font color=\"#FFFFFF\">"+s+"</i></p>");
				}
			}
catch(SQLException e){   e.printStackTrace();
     out.println("Exception du a la requete : "+e);  
     out.println("Requete Echouee");
}

}        
catch (SQLException ex) {
     Logger.getLogger(ProgrammeServlet.class.getName()).log(Level.SEVERE, null, ex);
     out.println("impossible de se connecter a la bd");
} 

/*Liberation des ressources (variables)*/
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
/* Fermeture de la connexion */
       connexion.close(); } catch ( SQLException ignore ) {
/* Si une erreur survient lors de la fermeture, il
suffit de l'ignorer. */
}
}
}

out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/index.jsp\">Accueil</a></p>");
out.println("</BODY>");
out.close();

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
    @Override
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

    @Override
    public String getServletInfo() {
        return "Retourne le programme du théatre";
    }

}
