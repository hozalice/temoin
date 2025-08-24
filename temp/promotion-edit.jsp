<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="mg.sprint.model.Vol" %>
<%@ page import="mg.sprint.model.Promotion" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier une Promotion</title>
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
        input[type="date"], input[type="text"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="date"]:focus, input[type="text"]:focus, select:focus {
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
            <h1>✏️ Modifier la Promotion</h1>
            <p>Modifiez les paramètres de la promotion</p>
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

        <%
            Promotion promotion = (Promotion) request.getAttribute("promotion");
            if (promotion != null) {
        %>
            <form action="promotion-update" method="post">
                <input type="hidden" name="id_promotion" value="<%= promotion.getIdPromotion() %>">
                
                <div class="form-row">
                    <div class="form-col">
                        <label for="daty">Date de la promotion</label>
                        <input type="date" id="daty" name="daty" 
                               value="<%= promotion.getDaty() != null ? promotion.getDaty().toString() : "" %>">
                    </div>
                    <div class="form-col">
                        <label for="id_vol">Vol <span class="required">*</span></label>
                        <select id="id_vol" name="id_vol" required>
                            <option value="">Sélectionnez un vol</option>
                            <%
                                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                                if (vols != null) {
                                    for (Vol vol : vols) {
                                        String selected = "";
                                        if (vol.getIdVol() == promotion.getIdVol()) {
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
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <label for="nb_siege">Nombre de sièges <span class="required">*</span></label>
                        <input type="text" id="nb_siege" name="nb_siege" required
                               value="<%= promotion.getNbSiege() != null ? promotion.getNbSiege() : "1" %>">
                    </div>
                    <div class="form-col">
                        <label for="type_siege">Type de siège <span class="required">*</span></label>
                        <select id="type_siege" name="type_siege" required>
                            <option value="">Sélectionnez le type</option>
                            <%
                                String selectedEco = "";
                                String selectedBusiness = "";
                                if (promotion.getTypeSiege() != null) {
                                    if ("eco".equals(promotion.getTypeSiege())) selectedEco = "selected";
                                    else if ("business".equals(promotion.getTypeSiege())) selectedBusiness = "selected";
                                }
                            %>
                            <option value="eco" <%= selectedEco %>>Économique</option>
                            <option value="business" <%= selectedBusiness %>>Business</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="pourcentage_reduction_prix">Pourcentage de réduction (%) <span class="required">*</span></label>
                    <input type="text" id="pourcentage_reduction_prix" name="pourcentage_reduction_prix" 
                           required
                           value="<%= promotion.getPourcentageReductionPrix() != null ? promotion.getPourcentageReductionPrix() : "10" %>">
                </div>

                <div class="actions">
                    <button type="submit" class="btn btn-primary">💾 Sauvegarder les modifications</button>
                    <a href="promotions" class="btn btn-secondary">🔙 Retour à la liste</a>
                </div>
            </form>
        <%
            } else {
        %>
            <div class="error-message">
                ❌ Promotion non trouvée
            </div>
            <div class="actions">
                <a href="promotions" class="btn btn-secondary">🔙 Retour à la liste</a>
            </div>
        <%
            }
        %>
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
