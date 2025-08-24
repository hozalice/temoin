<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="mg.sprint.model.Vol" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Créer une Promotion</title>
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
            border-bottom: 2px solid #FF6B35;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-col {
            flex: 1;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="date"], input[type="number"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="date"]:focus, input[type="number"]:focus, select:focus {
            outline: none;
            border-color: #FF6B35;
            box-shadow: 0 0 5px rgba(255, 107, 53, 0.3);
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #FF6B35;
            color: white;
        }
        .btn-primary:hover {
            background-color: #e55a2b;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .required {
            color: #e74c3c;
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
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎯 Créer une Nouvelle Promotion</h1>
            <p>Configurez les paramètres de la promotion</p>
        </div>

        <%
            // Afficher les messages d'erreur ou de succès
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            
            if (errorMessage != null) {
        %>
            <div class="error-message">
                ❌ <%= errorMessage %>
            </div>
        <%
            }
            
            if (successMessage != null) {
        %>
            <div class="success-message">
                ✅ <%= successMessage %>
            </div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/promotion-insert" method="post">
            <div class="form-row">
                <div class="form-col">
                    <label for="daty">Date de la promotion <span class="required">*</span></label>
                    <input type="date" id="daty" name="daty" required
                           value="<%= request.getAttribute("formData") != null && ((Map<String, String>) request.getAttribute("formData")).get("daty") != null ? ((Map<String, String>) request.getAttribute("formData")).get("daty") : "" %>"
                           class="<%= request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("daty") ? "error-field" : "" %>">
                    <% 
                        if (request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("daty")) {
                    %>
                        <span class="error"><%= ((Map<String, String>) request.getAttribute("fieldErrors")).get("daty") %></span>
                    <%
                        }
                    %>
                </div>
                <div class="form-col">
                    <label for="id_vol">Vol <span class="required">*</span></label>
                    <select id="id_vol" name="id_vol" required
                            class="<%= request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("id_vol") ? "error-field" : "" %>">
                        <option value="">Sélectionnez un vol</option>
                        <%
                            List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                            if (vols != null) {
                                for (Vol vol : vols) {
                                    String selected = "";
                                    if (request.getAttribute("formData") != null && 
                                        ((Map<String, String>) request.getAttribute("formData")).get("id_vol") != null &&
                                        ((Map<String, String>) request.getAttribute("formData")).get("id_vol").equals(String.valueOf(vol.getIdVol()))) {
                                        selected = "selected";
                                    }
                        %>
                            <option value="<%= vol.getIdVol() %>" <%= selected %>>
                                <%= vol.getNomVilleDepart() != null ? vol.getNomVilleDepart() : "Vol " + vol.getIdVol() %> → 
                                <%= vol.getNomVilleArrivee() != null ? vol.getNomVilleArrivee() : "Destination" %>
                                (<%= vol.getDateHeureDepart() != null ? vol.getDateHeureDepart() : "Date non définie" %>)
                            </option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <%
                        if (request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("id_vol")) {
                    %>
                        <span class="error"><%= ((Map<String, String>) request.getAttribute("fieldErrors")).get("id_vol") %></span>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="nb_siege">Nombre de sièges <span class="required">*</span></label>
                    <input type="text" id="nb_siege" name="nb_siege" required
                           value="<%= request.getAttribute("formData") != null && ((Map<String, String>) request.getAttribute("formData")).get("nb_siege") != null ? ((Map<String, String>) request.getAttribute("formData")).get("nb_siege") : "1" %>"
                           class="<%= request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("nb_siege") ? "error-field" : "" %>">
                    <%
                        if (request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("nb_siege")) {
                    %>
                        <span class="error"><%= ((Map<String, String>) request.getAttribute("fieldErrors")).get("nb_siege") %></span>
                    <%
                        }
                    %>
                </div>
                <div class="form-col">
                    <label for="type_siege">Type de siège <span class="required">*</span></label>
                    <select id="type_siege" name="type_siege" required
                            class="<%= request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("type_siege") ? "error-field" : "" %>">
                        <option value="">Sélectionnez le type</option>
                        <%
                            String selectedEco = "";
                            String selectedBusiness = "";
                            if (request.getAttribute("formData") != null && ((Map<String, String>) request.getAttribute("formData")).get("type_siege") != null) {
                                String typeSiege = ((Map<String, String>) request.getAttribute("formData")).get("type_siege");
                                if ("eco".equals(typeSiege)) selectedEco = "selected";
                                else if ("business".equals(typeSiege)) selectedBusiness = "selected";
                            }
                        %>
                        <option value="eco" <%= selectedEco %>>Économique</option>
                        <option value="business" <%= selectedBusiness %>>Business</option>
                    </select>
                    <%
                        if (request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("type_siege")) {
                    %>
                        <span class="error"><%= ((Map<String, String>) request.getAttribute("fieldErrors")).get("type_siege") %></span>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="form-group">
                <label for="pourcentage_reduction_prix">Pourcentage de réduction (%) <span class="required">*</span></label>
                <input type="text" id="pourcentage_reduction_prix" name="pourcentage_reduction_prix" 
                       required
                       value="<%= request.getAttribute("formData") != null && ((Map<String, String>) request.getAttribute("formData")).get("pourcentage_reduction_prix") != null ? ((Map<String, String>) request.getAttribute("formData")).get("pourcentage_reduction_prix") : "10" %>"
                       class="<%= request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("pourcentage_reduction_prix") ? "error-field" : "" %>">
                <%
                    if (request.getAttribute("fieldErrors") != null && ((Map<String, String>) request.getAttribute("fieldErrors")).containsKey("pourcentage_reduction_prix")) {
                %>
                    <span class="error"><%= ((Map<String, String>) request.getAttribute("fieldErrors")).get("pourcentage_reduction_prix") %></span>
                <%
                    }
                %>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary">🎯 Créer la Promotion</button>
                <a href="promotions" class="btn btn-secondary">🔙 Retour à la liste</a>
            </div>
        </form>
    </div>

    <script>
        // Validation côté client
        document.querySelector('form').addEventListener('submit', function(e) {
            const pourcentage = parseFloat(document.getElementById('pourcentage_reduction_prix').value);
            const nbSiege = parseInt(document.getElementById('nb_siege').value);
            
            if (isNaN(pourcentage) || pourcentage <= 0 || pourcentage > 100) {
                alert('Le pourcentage de réduction doit être un nombre entre 1 et 100%');
                e.preventDefault();
                return;
            }
            
            if (isNaN(nbSiege) || nbSiege <= 0) {
                alert('Le nombre de sièges doit être un nombre supérieur à 0');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
