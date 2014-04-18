
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * A simple Servlet that requests parameters.
 *
 */
public class DateServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String date;

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Hello To</title>");
        out.println("</head>");
        out.println("<body>");
        date = request.getParameter("date");
        Date dt = new Date();
        if (date  != null) {
            out.println("<h1>Date is: "+formatter(dt)+"</h1>");
            out.println("<a href='/TP3/index.html'>Retour à l'accueil</a>");
        } else {
            out.println("Date is not specified.");
            out.println("<P>");
            out.print("<form>");
            out.println("Enter the date:");
            out.println("<input type=date size=20 name=date>");
            out.println("<br>");
            out.println("<input type=submit>");
            out.println("</form>");
        }
        out.println("</body>");
        out.println("</html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }
    
    public static String formatter(Date dt) {
        SimpleDateFormat df = new SimpleDateFormat("EEEE, d MMMM yyyy");
        return df.format(dt);
    }
    
    public static int[] getDate(String dt) {
        int res[] = {0, 0, 0};
        res[0] = Integer.parseInt(dt.split("-")[0]) -1900;
        res[1] = Integer.parseInt(dt.split("-")[1]) - 1;
        res[2] = Integer.parseInt(dt.split("-")[2]);
        return res;
    }
}
