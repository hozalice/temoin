<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="mg.sprint.model.Promotion" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Promotions</title>
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
            border-bottom: 2px solid #FF6B35;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .actions-top {
            text-align: right;
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-left: 10px;
            display: inline-block;
        }
        .btn-primary {
            background-color: #FF6B35;
            color: white;
        }
        .btn-primary:hover {
            background-color: #e55a2b;
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
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #FF6B35;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .status {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status-eco {
            background-color: #28a745;
            color: white;
        }
        .status-business {
            background-color: #007bff;
            color: white;
        }
        .message {
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        .actions-cell {
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎯 Gestion des Promotions</h1>
            <p>Liste des promotions actives</p>
        </div>

        <%
            // Afficher les messages d'erreur ou de succès
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            
            if (errorMessage != null) {
        %>
            <div class="message error-message">
                ❌ <%= errorMessage %>
            </div>
        <%
            }
            
            if (successMessage != null) {
        %>
            <div class="message success-message">
                ✅ <%= successMessage %>
            </div>
        <%
            }
        %>

        <div class="actions-top">
            <a href="promotion-form" class="btn btn-primary">🎯 Nouvelle Promotion</a>
            <a href="vols" class="btn btn-secondary">✈️ Retour aux Vols</a>
        </div>

        <%
            List<Promotion> promotions = (List<Promotion>) request.getAttribute("promotions");
            if (promotions != null && !promotions.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>Vol</th>
                        <th>Type Siège</th>
                        <th>Nombre Sièges</th>
                        <th>Réduction</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        for (Promotion promotion : promotions) {
                    %>
                        <tr>
                            <td><%= promotion.getIdPromotion() %></td>
                            <td><%= promotion.getDaty() != null ? sdf.format(promotion.getDaty()) : "N/A" %></td>
                            <td>
                                <strong><%= promotion.getNomVol() != null ? promotion.getNomVol() : "Vol " + promotion.getIdVol() %></strong><br>
                                <small>
                                    <%= promotion.getDateDepart() != null ? promotion.getDateDepart().toString() : "Date non définie" %>
                                </small>
                            </td>
                            <td>
                                <span class="status status-<%= promotion.getTypeSiege() != null ? promotion.getTypeSiege() : "eco" %>">
                                    <%= promotion.getTypeSiege() != null ? promotion.getTypeSiege().toUpperCase() : "ECO" %>
                                </span>
                            </td>
                            <td><%= promotion.getNbSiege() %></td>
                            <td><strong><%= promotion.getPourcentageReductionPrix() != null ? promotion.getPourcentageReductionPrix() + "%" : "N/A" %></strong></td>
                            <td class="actions-cell">
                                <a href="promotion-edit?id=<%= promotion.getIdPromotion() %>" class="btn btn-warning">✏️ Modifier</a>
                                <a href="promotion-delete?id=<%= promotion.getIdPromotion() %>" 
                                   class="btn btn-danger" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette promotion ?')">🗑️ Supprimer</a>
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
            <div class="no-data">
                <h3>📭 Aucune promotion trouvée</h3>
                <p>Il n'y a pas encore de promotions configurées.</p>
                <a href="promotion-form" class="btn btn-primary">🎯 Créer la première promotion</a>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
