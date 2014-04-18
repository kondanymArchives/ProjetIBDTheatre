import javax.servlet.*;
import javax.servlet.http.*;
import exceptions.ExceptionConnexion;
import accesBD.BDConnexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * ListeRepresentation Servlet.
 *
 * Cette servlet donne la liste des représentation d'un spectacle donné.
 *
 * @author <a href="mailto:jeremie.demarchez@e.ujf-grenoble.fr">Jérémie Démarchez</a>
 * @version 1.0, 26/03/2014
 */

public class ListeRepresentationServlet extends HttpServlet {

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
		
                String numS = null;
		ServletOutputStream out = res.getOutputStream();   

		res.setContentType("text/html");

		out.println("<HEAD><TITLE> Lister les représentations d'un spectacle </TITLE></HEAD>");
		out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
		out.println("<font color=\"#FFFFFF\"><h1> Lister les représentations d'un spectacle identifié par un numéro </h1>");

		numS		= req.getParameter("numS");
		if (numS == null) {
			out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives au spectacle dont on souhaite lister les représentations :");
			out.println("<P>");
			out.print("<form action=\"");
			out.print("ListeRepresentationServlet\" ");
			out.println("method=POST>");
			out.println("Num&eacute;ro du spectacle :");
			out.println("<input type=text size=20 name=numS>");
			out.println("<br>");
			out.println("<input type=submit>");
			out.println("</form>");
		} else {
			// TO DO
			// Transformation des paramètres vers les types adéquats.
			int bd_numS = Integer.parseInt(numS);
			// Selection des dates des représentations du spectacle numS.
			//connection à la BD
			String query = "SELECT dateRep FROM LesRepresentations WHERE numS="+bd_numS;


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
                    
                    try {
                        stmt = connexion.createStatement();
                        
                        ResultSet result=stmt.executeQuery(query);
                        String s = new String();
                        
                        while( result.next() ){
                            s=result.getString(1);
                            out.println("<p><i><font color=\"#FFFFFF\">"+s+"</i></p>");
                        }
                        
                        //on cré un formulaire pour lister les places disponibles d'une représentation
                        out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives &agrave; la repr&eacute;sentation dont on souhaite afficher les places disponibles:");
                        out.println("<P>");
                        out.print("<form action=\"");
                        out.print("PlaceDisponibleServlet\" ");
                        out.println("method=POST>");
                        out.println("<input type=hidden value="+numS+" name=numS>");
                        out.println("Date de la repr&eacute;sentation (au format dd-mm-yyyy):");
                        out.println("<input type=text size=20 name=date>");
                        out.println("<br>");
                        out.println("Heure de la repr&eacute;sentation (au format HH:mm):");
                        out.println("<input type=text size=20 name=heure>");
                        out.println("<br>");
                        out.println("<input type=submit>");
                        out.println("</form>");
                        
                    }
                    catch(Exception e){
                        out.println("Exception du a la requete : "+e);
                        
                    }
		    } 
                    catch (SQLException ex) {  out.println("Connection a la bd impossible");
                    
                    }
    
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
                    }
                        
                    
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/admin/admin.html\">Page d'administration</a></p>");
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/index.html\">Page d'accueil</a></p>");
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
		return "Liste les représentations d'un spectacle identifié par son numéro.";
	}

}