<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="database.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Details Fetcher</title>
    <script>
        function getStudentDetails() {
            // Get the selected registration number from the dropdown
            var regNo = document.getElementById("regNoSelect").value;

            if (regNo !== "") {
                // Create an XMLHttpRequest object
                var xhr = new XMLHttpRequest();

                // Specify what should happen when the response is ready
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        document.getElementById("studentDetails").innerHTML = xhr.responseText;
                    }
                };

                // Open a GET request to the server script
                xhr.open("GET", "studentDetails?reg_no=" + regNo, true);
                // Send the request
                xhr.send();
            }
        }
    </script>
</head>
<body>
    <h1>Select Student Registration Number</h1>

    <select id="regNoSelect" onchange="getStudentDetails()">
        <option value="">Select Registration Number</option>
        <% 
            try {
                Connection con = DatabaseConnection.initializeDatabase();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT reg_no FROM students");

                while (rs.next()) {
        %>
                    <option value="<%= rs.getString("reg_no") %>"><%= rs.getString("reg_no") %></option>
        <% 
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </select>

    <div id="studentDetails" style="margin-top: 20px;">
        <!-- Student details will be displayed here -->
    </div>
</body>
</html>
