<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Données saisies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h1 {
            color: #4CAF50;
            text-align: center;
            margin-bottom: 30px;
        }

        .data-item {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
        }

        .label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        .value {
            color: #666;
            font-size: 16px;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .back-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✅ Données enregistrées avec succès</h1>
        
        <div class="success-message">
            Les informations ont été validées et enregistrées correctement !
        </div>

        <div class="data-item">
            <span class="label">Nom :</span>
            <span class="value">${nom}</span>
        </div>

        <div class="data-item">
            <span class="label">Numéro d'étudiant :</span>
            <span class="value">${numero_etudiant}</span>
        </div>

        <div class="data-item">
            <span class="label">Date de naissance :</span>
            <span class="value">${date_de_naissance}</span>
        </div>

        <a href="form" class="back-button">Retour au formulaire</a>
    </div>
</body>
</html>
