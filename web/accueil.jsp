<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Accueil</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #4CAF50;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .welcome-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
            text-align: center;
            border: 1px solid #c3e6cb;
        }
        .user-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
            border-left: 4px solid #4CAF50;
        }
        .user-info h3 {
            color: #333;
            margin-top: 0;
        }
        .info-item {
            margin-bottom: 10px;
        }
        .info-label {
            font-weight: bold;
            color: #555;
        }
        .info-value {
            color: #333;
            margin-left: 10px;
        }
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .logout-section {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏠 Page d'Accueil</h1>
            <p>Bienvenue dans votre espace personnel</p>
        </div>

        <%
            String message = (String) request.getAttribute("message");
            String login = (String) request.getAttribute("login");
            if (message != null) {
        %>
            <div class="welcome-message">
                <strong>✅ <%= message %></strong>
            </div>
        <%
            }
        %>

        <div class="user-info">
            <h3>👤 Informations de l'utilisateur</h3>
            <div class="info-item">
                <span class="info-label">Login :</span>
                <span class="info-value"><%= login != null ? login : "Non spécifié" %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Date de connexion :</span>
                <span class="info-value"><%= new java.util.Date() %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Statut :</span>
                <span class="info-value" style="color: #28a745;">✅ Connecté</span>
            </div>
        </div>

        <div class="actions">
            <a href="form" class="btn btn-primary">📝 Nouveau formulaire</a>
            <a href="etudiant" class="btn btn-secondary">👥 Gestion étudiants</a>
            <a href="#" class="btn btn-secondary">⚙️ Paramètres</a>
        </div>

        <div class="logout-section">
            <a href="login" class="btn btn-danger">🚪 Se déconnecter</a>
        </div>
    </div>
</body>
</html>
