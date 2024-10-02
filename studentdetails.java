package servlets;

import database.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/studentDetails")
public class StudentDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String regNo = request.getParameter("reg_no");

        if (regNo != null && !regNo.isEmpty()) {
            try {
                Connection con = DatabaseConnection.initializeDatabase();
                String query = "SELECT * FROM students WHERE reg_no = ?";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, regNo);
                ResultSet rs = pst.executeQuery();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html");

                if (rs.next()) {
                    out.println("<h3>Student Details:</h3>");
                    out.println("<p>Registration Number: " + rs.getString("reg_no") + "</p>");
                    out.println("<p>Name: " + rs.getString("name") + "</p>");
                    out.println("<p>Department: " + rs.getString("department") + "</p>");
                    out.println("<p>Year: " + rs.getInt("year") + "</p>");
                } else {
                    out.println("<p>No details found for the selected registration number.</p>");
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("Error retrieving student details!");
            }
        }
    }
}
