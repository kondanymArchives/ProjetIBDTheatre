<%--
    Document   : NouvelleRepresentationJsp
    Created on : 4 avr. 2014, 07:06:37
    Author     : kondanym
--%>


<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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

	  out.println("<HEAD><TITLE> Ajouter une nouvelle representation </TITLE></HEAD>");
	  out.println("<BODY bgproperties=\"fixed\" background=\"/images/rideau.JPG\">");
	  out.println("<font color=\"#FFFFFF\"><h1> Ajouter une nouvelle representation </h1>");

	  numS	= null;  //req.getParameter("numS");
	  dateS	= null;  //req.getParameter("date");
	  heureS = null; //req.getParameter("heure");
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
	  } else 
                {
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
              
}                        
              	  out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/admin/admin.html\">Page d'administration</a></p>");
	          out.println("<hr><p><font color=\"#FFFFFF\"><a href=\"/index.html\">Page d'accueil</a></p>");
	          out.println("</BODY>");
	          out.close();
 
                  
%>
    </body>
</html>
