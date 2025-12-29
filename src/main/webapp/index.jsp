<html>
<body>
<h2>Hello World!</h2>

<%
    String username = (String) session.getAttribute("username");
    if (username != null) {
%>
<p>Welcome!!!!, <b><%= username %></b></p>
<%
    }
%>

</body>
</html>
