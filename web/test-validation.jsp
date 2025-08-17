<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test de Validation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .error {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form action="validation" method="post">
        <div class="form-group">
            <label for="nom">Nom (String, NotNull):</label>
            <input type="text" id="nom" name="nom">
            <% if (request.getAttribute("nomError") != null) { %>
                <div class="error"><%= request.getAttribute("nomError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="age">Age (Integer, NotNull):</label>
            <input type="text" id="age" name="age">
            <% if (request.getAttribute("ageError") != null) { %>
                <div class="error"><%= request.getAttribute("ageError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="moyenne">Moyenne (Double, NotNull):</label>
            <input type="text" id="moyenne" name="moyenne">
            <% if (request.getAttribute("moyenneError") != null) { %>
                <div class="error"><%= request.getAttribute("moyenneError") %></div>
            <% } %>
        </div>

        <button type="submit">Tester la validation</button>
    </form>
</body>
</html>
