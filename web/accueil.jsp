<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="mg.sprint.model.Vol" %>
<%@ page import="mg.sprint.model.Ville" %>
<%@ page import="mg.sprint.model.Avion" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Accueil - Gestion des Vols</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
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
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
            text-align: center;
            border: 1px solid #f5c6cb;
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
            margin-bottom: 30px;
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
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }
        .vols-section {
            margin-top: 40px;
        }
        .vols-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .vols-title {
            color: #333;
            margin: 0;
        }
        .vols-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .vols-table th, .vols-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .vols-table th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        .vols-table tr:hover {
            background-color: #f5f5f5;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status-prevu {
            background-color: #17a2b8;
            color: white;
        }
        .status-en-cours {
            background-color: #28a745;
            color: white;
        }
        .status-termine {
            background-color: #6c757d;
            color: white;
        }
        .status-annule {
            background-color: #dc3545;
            color: white;
        }
        .vol-actions {
            display: flex;
            gap: 5px;
        }
        .no-vols {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
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
            <h1>✈️ Gestion des Vols</h1>
            <p>Bienvenue dans votre espace de gestion aérienne</p>
        </div>

        <%
            String message = (String) request.getAttribute("message");
            String login = (String) request.getAttribute("login");
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            
            if (message != null) {
        %>
            <div class="welcome-message">
                <strong>✅ <%= message %></strong>
            </div>
        <%
            }
            
            if (successMessage != null) {
        %>
            <div class="welcome-message">
                <strong>✅ <%= successMessage %></strong>
            </div>
        <%
            }
            
            if (errorMessage != null) {
        %>
            <div class="error-message">
                <strong>❌ <%= errorMessage %></strong>
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
            <a href="vol-form" class="btn btn-primary">✈️ Nouveau Vol</a>
            <a href="promotions" class="btn btn-primary" style="background-color: #FF6B35;">🎯 Gérer les Promotions</a>
            <a href="parametrages" class="btn btn-primary" style="background-color:rgb(104, 67, 239);">🎯 Gérer les Paramètres</a>
            <a href="form" class="btn btn-secondary">📝 Formulaire étudiant</a>
            <a href="etudiant" class="btn btn-secondary">👥 Gestion étudiants</a>
            <a href="#" class="btn btn-secondary">⚙️ Paramètres</a>
        </div>

        <!-- Section des vols -->
        <div class="vols-section">
            <div class="vols-header">
                <h2 class="vols-title">📋 Liste des Vols</h2>
                <a href="vol-form" class="btn btn-primary btn-sm">+ Ajouter un vol</a>
            </div>

            <%
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                if (vols != null && !vols.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            %>
                <table class="vols-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Trajet</th>
                            <th>Départ</th>
                            <th>Arrivée</th>
                            <th>Avion</th>
                            <th>Prix Éco</th>
                            <th>Prix Business</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Vol vol : vols) {
                                String statusClass = "status-prevu";
                                if ("en cours".equals(vol.getStatut())) statusClass = "status-en-cours";
                                else if ("terminé".equals(vol.getStatut())) statusClass = "status-termine";
                                else if ("annulé".equals(vol.getStatut())) statusClass = "status-annule";
                        %>
                            <tr>
                                <td><strong>#<%= vol.getIdVol() %></strong></td>
                                <td>
                                    <strong><%= vol.getNomVilleDepart() != null ? vol.getNomVilleDepart() : "N/A" %></strong>
                                    <br>→ <strong><%= vol.getNomVilleArrivee() != null ? vol.getNomVilleArrivee() : "N/A" %></strong>
                                </td>
                                <td><%= vol.getDateHeureDepart() != null ? sdf.format(vol.getDateHeureDepart()) : "N/A" %></td>
                                <td><%= vol.getDateHeureArrivee() != null ? sdf.format(vol.getDateHeureArrivee()) : "N/A" %></td>
                                <td><%= vol.getNumeroAvion() != null ? vol.getNumeroAvion() : "N/A" %></td>
                                <td><%= vol.getPrixEco() != null ? vol.getPrixEco() + "€" : "N/A" %></td>
                                <td><%= vol.getPrixBusiness() != null ? vol.getPrixBusiness() + "€" : "N/A" %></td>
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= vol.getStatut() != null ? vol.getStatut() : "N/A" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="vol-actions">
                                        <a href="vol-edit?id=<%= vol.getIdVol() %>" class="btn btn-warning btn-sm">✏️</a>
                                        <a href="vol-delete?id=<%= vol.getIdVol() %>" class="btn btn-danger btn-sm" 
                                           onclick="return confirm('Êtes-vous sûr de vouloir annuler ce vol ?')">❌</a>
                                    </div>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                } else {
            %>
                <div class="no-vols">
                    <h3>📭 Aucun vol trouvé</h3>
                    <p>Il n'y a actuellement aucun vol dans la base de données.</p>
                    <a href="vol-form" class="btn btn-primary">✈️ Créer le premier vol</a>
                </div>
            <%
                }
            %>
        </div>

        <div class="logout-section">
            <a href="login" class="btn btn-danger">🚪 Se déconnecter</a>
        </div>
    </div>
</body>
</html>
