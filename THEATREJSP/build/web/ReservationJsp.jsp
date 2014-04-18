<%-- 
    Document   : ReservationJsp
    Created on : 8 avr. 2014, 13:50:27
    Author     : kondanym
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
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
            
           	String numS, dateS, heureS, zone, noPlace=null, noRang=null;
		//ServletOutputStream out = res.getOutputStream();   

		//res.setContentType("text/html");

		out.println("<HEAD><TITLE> Effectuer une reservation dans une zone donnée pour une représentation donnée </TITLE></HEAD>");
		out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
		out.println("<font color=\"#FFFFFF\"><h1> Effectuer une reservation dans une zone donnée pour une représentation donnée</h1>");

		numS = null;    //req.getParameter("numS");
		dateS = null;   // req.getParameter("date");
		heureS = null;  // req.getParameter("heure");
		zone = null;    // req.getParameter("zone");
		if (numS == null || dateS == null || zone == null) {
			out.println("<font color=\"#FFFFFF\">Veuillez saisir les informations relatives &agrave; la réservation :");
			out.println("<P>");
			out.print("<form action=\"");
			out.print("ReservationJsp\" ");
			out.println("method=POST>");
			out.println("Num&eacute;ro de spectacle :");
			out.println("<input type=text size=20 name=numS>");
			out.println("<br>");
			out.println("Date de la repr&eacute;sentation (au format dd-mm-yyyy) :");
			out.println("<input type=text size=20 name=date>");
			out.println("<br>");
			out.println("Heure de la repr&eacute;sentation (au format hh:mm) :");
			out.println("<input type=text size=20 name=heure>");
			out.println("<br>");
			out.println("Zone désiré :");
			out.println("<input type=text size=20 name=zone>");
			out.println("<br>");
			out.println("<input type=submit>");
			out.println("</form>");
		} else {
			// Selection d'une place disponible.
			//connection à la BD
			String query = "SELECT noPlace, noRang, numZ FROM LesPlaces where (noPlace, noRang) not in"
					+"(select noPlace, noRang from LesTickets where numS = ? and dateRep = ?)";
			
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
					results = stmt.executeQuery();
					connexion.commit();
					connexion.close();
					noPlace=results.getString(1);
					noRang=results.getString(2);
				
				}catch(Exception e){
                                 out.println("Exception du a la requete : "+e);   
				 out.println("exception (1) du a la requete");
				}
                                
                                }catch (SQLException ex) {
                                 out.println("Connecton (1) a la bd impossible");
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
                
			
if(noPlace!=null && noRang!=null)
			{
				//ajout de la réservation
				int resultat=0;
				String queryInsert = "INSERT INTO LesTickets (noSerie, numS, dateRep, noPlace, noRang, dateEmission, noDossier)"
						+ " VALUES (?, ?, ?, ?, ?, ?, ?)";

/*Chargement du Driver:*/
try{ DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());           
        } catch (SQLException ex) {
                 out.println("Impossible de charger le Driver");
        }


/* Connexion à la base de données */
try {
connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
/* Ici, nous placons nos requêtes vers la BDD */
/* ... */

					try {
						stmt = connexion.prepareStatement(queryInsert);
						stmt.setInt(1, Integer.valueOf(numS));
						stmt.setInt(2, 0);
						stmt.setTimestamp(3, new Timestamp((new SimpleDateFormat("dd-MM-yyyy HH:mm")).parse(dateS+" "+heureS).getTime()));
						stmt.setInt(4, Integer.valueOf(noPlace));
						stmt.setInt(5, Integer.valueOf(noRang));
						
						java.util.Date utilDate = new java.util.Date();
					        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());


						DateFormat df=new SimpleDateFormat("dd-MMM-yyyy");
						String s=df.format(sqlDate.toString());
						stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
						stmt.setInt(7, 0);
//						out.println("Date : "+new Timestamp((new SimpleDateFormat("dd-MM-yyyy HH:mm")).parse(s).getTime()));
						
						resultat = stmt.executeUpdate();
						connexion.commit();
						connexion.close();
					}
					catch(Exception e){ 
                                                out.println("Exception du a la requete : "+e);
						out.println("exception du (2) a la requete");
						e.printStackTrace();
					}
				} catch (SQLException ex) {
                                  out.println("Connection (2) a la bd impossible");
                                
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

				// Puis construction dynamique d'une page web de réponse.
				
                                if(resultat==0)
				{
					out.println("<p><i><font color=\"#FFFFFF\">Echec de l'ajout de la nouvelle représentation! Contactez l'administrateur.</i></p>");
				}
				else
				{
					out.println("<p><i><font color=\"#FFFFFF\">Réservation effectué avec succés!</i></p>");
					out.println("<p><i><font color=\"#FFFFFF\">Résumé des informations:</i></p>");
					out.println("<p><i><font color=\"#FFFFFF\">Numéro de la représentation : "+numS+"</i></p>");
					out.println("<p><i><font color=\"#FFFFFF\">Date de la représentation : "+dateS+"</i></p>");
					out.println("<p><i><font color=\"#FFFFFF\">Place réservé : "+noPlace+"</i></p>");
					out.println("<p><i><font color=\"#FFFFFF\">Rang ou se situe la place : "+noRang+"</i></p>");
				}
			}
			else
			{
				out.println("<p><i><font color=\"#FFFFFF\">Il ne reste malheureusement plus de place pour la représentation choisit.</i></p>");
			}
}

		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/admin/admin.jsp\">Page d'administration</a></p>");
		out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/index.jsp\">Page d'accueil</a></p>");
		out.println("</BODY>");
		out.close();

			

           
%>

    </body>
</html>
