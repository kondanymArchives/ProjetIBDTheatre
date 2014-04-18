<%-- 
    Document   : ProgrammeJsp
    Created on : 4 avr. 2014, 03:54:50
    Author     : kondanym
--%>

<%--
<jsp:include page="index.jsp" />
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.lang.System.*"%>
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
            
          //ServletOutputStream out = res.getOutputStream();   

	  //res.setContentType("text/html");

	  out.println("<HEAD><TITLE> Programme de la saison </TITLE></HEAD>");
	  out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
	  out.println("<font color=\"#FFFFFF\"><h1> Programme de la saison : </h1>");

            
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

out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/THEATREJSP/index.jsp\">Accueil</a></p>");
out.println("</BODY>");
out.close();

  
%>        
    </body>
</html>
