<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Récupération sécurisée des attributs
    String nom = "";
    String numero_etudiant = "";
    String date_de_naissance = "";
    
    if (request.getAttribute("nom") != null) {
        nom = request.getAttribute("nom").toString();
    }
    if (request.getAttribute("numero_etudiant") != null) {
        numero_etudiant = request.getAttribute("numero_etudiant").toString();
    }
    if (request.getAttribute("date_de_naissance") != null) {
        date_de_naissance = request.getAttribute("date_de_naissance").toString();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f9;
        }
        .result-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h2>Form Submission Result</h2>
        <p>Nom: <%= nom %></p>
        <p>Numéro d'étudiant: <%= numero_etudiant %></p>
        <p>Date de naissance: <%= date_de_naissance %></p>
    </div>
</body>
</html>
