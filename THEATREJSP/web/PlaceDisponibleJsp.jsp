<%-- 
    Document   : PlaceDisponibleJsp
    Created on : 8 avr. 2014, 13:41:35
    Author     : kondanym
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  
        
                String numS, dateS, heureS;
		//ServletOutputStream out = res.getOutputStream();   

		//res.setContentType("text/html");

		out.println("<HEAD><TITLE> Lister les places disponibles</TITLE></HEAD>");
		out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
		out.println("<font color=\"#FFFFFF\"><h1> Obtenir la liste des places disponibles d'une représentation </h1>");

		numS = null;     //req.getParameter("numS");
		dateS = null;    //req.getParameter("date");
		heureS	= null;  // req.getParameter("heure");
		
                if (numS == null || dateS == null || heureS==null) {
			out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives &agrave; la repr&eacute;sentation dont on souhaite afficher les places disponibles:");
			out.println("<P>");
			out.print("<form action=\"");
			out.print("PlaceDisponibleServlet\" ");
			out.println("method=POST>");
			out.println("Num&eacute;ro de spectacle :");
			out.println("<input type=text size=20 name=numS>");
			out.println("<br>");
			out.println("Date de la repr&eacute;sentation (au format dd-mm-yyyy):");
			out.println("<input type=text size=20 name=date>");
			out.println("<br>");
			out.println("Heure de la repr&eacute;sentation (au format HH:mm):");
			out.println("<input type=text size=20 name=heure>");
			out.println("<br>");
			out.println("<input type=submit>");
			out.println("</form>");
		} else {
			// Ajout de la nouvelle représentation.
			//connection à la BD
			String query = "SELECT noRang, noPlace, numZ, count(numZ) FROM LesPlaces where (noRang, noPlace) NOT IN "
					+"(SELECT noRang, noPlace FROM LesTickets WHERE numS=? AND dateRep=?) "
					+ "GROUP BY (noRang, noPlace, numZ)";
			
			
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
PreparedStatement stmt = null;

try {
connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
/* Ici, nous placons nos requêtes vers la BDD */
/* ... */


				try {
					stmt = connexion.prepareStatement(query);
					
					stmt.setInt(1, Integer.valueOf(numS));
					stmt.setTimestamp(2, new Timestamp((new SimpleDateFormat("dd-MM-yyyy HH:mm")).parse(dateS+" "+heureS).getTime()));
					
					ResultSet result=stmt.executeQuery();
					String sRang = new String();
					String sPlace = new String();
					String sZone = new String();
					String tmp = new String();
					
					//on affiche les places disponibles
					out.println("<p><i><font color=\"#FFFFFF\"><h2>Liste des place disponibles:</h2></i></p>");
					while( result.next() ){
						sRang=result.getString(1);
						sPlace=result.getString(2);
						sZone=result.getString(3);
						/*if(sRang.equals(tmp)) out.println("<p><i><font color=\"#FFFFFF\">Rang : "+sRang+"; Place : "+sPlace+"; Zone : "+sZone+"</i></p>");
						else*/ out.println("<p><i><font color=\"#FFFFFF\">Rang : "+sRang+"; Place : "+sPlace+"; Zone : "+sZone+"</i></p>");
						tmp = result.getString(1);
					}
					//on cré un formulaire pour effectuer une réservation
					out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives &agrave; la réservation :");
					out.println("<P>");
					out.print("<form action=\"");
					out.print("ReservationServlet\" ");
					out.println("method=POST>");
					out.println("Num&eacute;ro de spectacle :");
					out.println("<input type=hidden value="+numS+" size=20 name=numS>");
					out.println("<br>");
					out.println("Date de la repr&eacute;sentation (au format dd-mm-yyyy) :");
					out.println("<input type=hidden value="+dateS+" size=20 name=date>");
					out.println("<br>");
					out.println("Heure de la repr&eacute;sentation (au format hh:mm) :");
					out.println("<input type=hidden value="+heureS+" size=20 name=heure>");
					out.println("<br>");
					out.println("Zone désiré :");
					out.println("<input type=text size=20 name=zone>");
					out.println("<br>");
					out.println("<input type=submit>");
					out.println("</form>");

				}
				catch(Exception e){
					System.out.println("Exception du a la requete : "+e);
				}
			} catch (SQLException ex) {
                                
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

		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/admin/admin.jsp\">Page d'administration</a></p>");
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/index.jsp\">Page d'accueil</a></p>");
		out.println("</BODY>");
		out.close();

			

            
%>
    </body>
</html>
