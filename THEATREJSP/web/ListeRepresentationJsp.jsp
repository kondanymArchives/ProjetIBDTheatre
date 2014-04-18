<%-- 
    Document   : ListeRepresentationJsp
    Created on : 8 avr. 2014, 13:14:25
    Author     : kondanym
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
        
                String numS = null;
		//ServletOutputStream out = res.getOutputStream();   

		//res.setContentType("text/html");

		out.println("<HEAD><TITLE> Lister les représentations d'un spectacle </TITLE></HEAD>");
		out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
		out.println("<font color=\"#FFFFFF\"><h1> Lister les représentations d'un spectacle identifié par un numéro </h1>");

		numS = null; //req.getParameter("numS");
		if (numS == null) {
			out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives au spectacle dont on souhaite lister les représentations :");
			out.println("<P>");
			out.print("<form action=\"");
			out.print("ListeRepresentationJsp.jsp\" ");
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
                        out.print("PlaceDisponibleJsp\" ");
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
    
    if ( results != null ){
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
                        
                    
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/admin/admin.jsp\">Page d'administration</a></p>");
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/index.jsp\">Page d'accueil</a></p>");
		out.println("</BODY>");
		out.close();
	
         
%> 
    </body>
</html>
