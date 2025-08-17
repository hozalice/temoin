<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulaire d'inscription</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="text"]:focus, input[type="date"]:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
        }
        .error {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }
        .error-field {
            border-color: #e74c3c !important;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .general-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <form action="etudiant" method="post">
        <h1>Formulaire d'inscription</h1>
        
        <%
            Map<String, String> fieldErrors = (Map<String, String>) request.getAttribute("fieldErrors");
            Map<String, String> formData = (Map<String, String>) request.getAttribute("formData");
            
            // Afficher l'erreur générale si elle existe
            if (fieldErrors != null && fieldErrors.containsKey("general")) {
        %>
            <div class="general-error">
                <%= fieldErrors.get("general") %>
            </div>
        <%
            }
        %>
        
        <div class="form-group">
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" 
                   value="<%= formData != null && formData.get("nom") != null ? formData.get("nom") : "" %>"
                   class="<%= fieldErrors != null && fieldErrors.containsKey("nom") ? "error-field" : "" %>">
            <%
                if (fieldErrors != null && fieldErrors.containsKey("nom")) {
            %>
                <span class="error"><%= fieldErrors.get("nom") %></span>
            <%
                }
            %>
        </div>
        
        <div class="form-group">
            <label for="etu">Numéro d'étudiant :</label>
            <input type="text" id="etu" name="etu" 
                   value="<%= formData != null && formData.get("etu") != null ? formData.get("etu") : "" %>"
                   class="<%= fieldErrors != null && fieldErrors.containsKey("etu") ? "error-field" : "" %>">
            <%
                if (fieldErrors != null && fieldErrors.containsKey("etu")) {
            %>
                <span class="error"><%= fieldErrors.get("etu") %></span>
            <%
                }
            %>
        </div>
        
        <div class="form-group">
            <label for="date_de_naissance">Date de naissance :</label>
            <input type="date" id="date_de_naissance" name="date_de_naissance" 
                   value="<%= formData != null && formData.get("date_de_naissance") != null ? formData.get("date_de_naissance") : "" %>"
                   class="<%= fieldErrors != null && fieldErrors.containsKey("date_de_naissance") ? "error-field" : "" %>">
            <%
                if (fieldErrors != null && fieldErrors.containsKey("date_de_naissance")) {
            %>
                <span class="error"><%= fieldErrors.get("date_de_naissance") %></span>
            <%
                }
            %>
        </div>
        
        <input type="submit" value="Envoyer">
    </form>
</body>
</html>
