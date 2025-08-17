<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="mg.sprint.model.Ville" %>
<%@ page import="mg.sprint.model.Avion" %>
<%@ page import="mg.sprint.model.Vol" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un Vol</title>
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
        input[type="text"], input[type="datetime-local"], input[type="number"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="text"]:focus, input[type="datetime-local"]:focus, input[type="number"]:focus, select:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
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
        .actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .required {
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Modifier le Vol</h1>
            <p>Modifiez les informations du vol</p>
        </div>

        <%
            Vol vol = (Vol) request.getAttribute("vol");
            if (vol != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        %>
        <form action="vol-update" method="post">
            <input type="hidden" name="id_vol" value="<%= vol.getIdVol() %>">
            
            <div class="form-row">
                <div class="form-col">
                    <label for="id_ville_depart">Ville de départ <span class="required">*</span></label>
                    <select id="id_ville_depart" name="id_ville_depart" required>
                        <option value="">Sélectionnez une ville</option>
                        <%
                            List<Ville> villes = (List<Ville>) request.getAttribute("villes");
                            if (villes != null) {
                                for (Ville ville : villes) {
                                    String selected = (ville.getIdVille() == vol.getIdVilleDepart()) ? "selected" : "";
                        %>
                            <option value="<%= ville.getIdVille() %>" <%= selected %>><%= ville.getNom() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-col">
                    <label for="id_ville_arrivee">Ville d'arrivée <span class="required">*</span></label>
                    <select id="id_ville_arrivee" name="id_ville_arrivee" required>
                        <option value="">Sélectionnez une ville</option>
                        <%
                            if (villes != null) {
                                for (Ville ville : villes) {
                                    String selected = (ville.getIdVille() == vol.getIdVilleArrivee()) ? "selected" : "";
                        %>
                            <option value="<%= ville.getIdVille() %>" <%= selected %>><%= ville.getNom() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="date_heure_depart">Date et heure de départ <span class="required">*</span></label>
                    <input type="datetime-local" id="date_heure_depart" name="date_heure_depart" 
                           value="<%= vol.getDateHeureDepart() != null ? sdf.format(vol.getDateHeureDepart()) : "" %>" required>
                </div>
                <div class="form-col">
                    <label for="date_heure_arrivee">Date et heure d'arrivée <span class="required">*</span></label>
                    <input type="datetime-local" id="date_heure_arrivee" name="date_heure_arrivee" 
                           value="<%= vol.getDateHeureArrivee() != null ? sdf.format(vol.getDateHeureArrivee()) : "" %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="id_avion">Avion <span class="required">*</span></label>
                    <select id="id_avion" name="id_avion" required>
                        <option value="">Sélectionnez un avion</option>
                        <%
                            List<Avion> avions = (List<Avion>) request.getAttribute("avions");
                            if (avions != null) {
                                for (Avion avion : avions) {
                                    String selected = (avion.getIdAvion() == vol.getIdAvion()) ? "selected" : "";
                        %>
                            <option value="<%= avion.getIdAvion() %>" <%= selected %>><%= avion.getNumero() %> - <%= avion.getModele() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-col">
                    <label for="statut">Statut</label>
                    <select id="statut" name="statut">
                        <option value="prévu" <%= "prévu".equals(vol.getStatut()) ? "selected" : "" %>>Prévu</option>
                        <option value="en cours" <%= "en cours".equals(vol.getStatut()) ? "selected" : "" %>>En cours</option>
                        <option value="terminé" <%= "terminé".equals(vol.getStatut()) ? "selected" : "" %>>Terminé</option>
                        <option value="annulé" <%= "annulé".equals(vol.getStatut()) ? "selected" : "" %>>Annulé</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="prix_eco">Prix Économique (€) <span class="required">*</span></label>
                    <input type="number" id="prix_eco" name="prix_eco" step="0.01" min="0" 
                           value="<%= vol.getPrixEco() != null ? vol.getPrixEco() : "" %>" required>
                </div>
                <div class="form-col">
                    <label for="prix_business">Prix Business (€) <span class="required">*</span></label>
                    <input type="number" id="prix_business" name="prix_business" step="0.01" min="0" 
                           value="<%= vol.getPrixBusiness() != null ? vol.getPrixBusiness() : "" %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="nb_siege_promo_eco">Sièges promo Éco</label>
                    <input type="number" id="nb_siege_promo_eco" name="nb_siege_promo_eco" min="0" 
                           value="<%= vol.getNbSiegePromoEco() %>">
                </div>
                <div class="form-col">
                    <label for="nb_siege_promo_business">Sièges promo Business</label>
                    <input type="number" id="nb_siege_promo_business" name="nb_siege_promo_business" min="0" 
                           value="<%= vol.getNbSiegePromoBusiness() %>">
                </div>
            </div>

            <div class="form-group">
                <label for="reduction_promo">Réduction promotionnelle (%)</label>
                <input type="number" id="reduction_promo" name="reduction_promo" step="0.01" min="0" max="100" 
                       value="<%= vol.getReductionPromo() != null ? vol.getReductionPromo() : "0" %>">
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary">💾 Sauvegarder les modifications</button>
                <a href="vols" class="btn btn-secondary">🔙 Retour à la liste</a>
            </div>
        </form>
        <%
            } else {
        %>
            <div style="text-align: center; padding: 40px;">
                <h2>❌ Vol non trouvé</h2>
                <p>Le vol que vous essayez de modifier n'existe pas.</p>
                <a href="vols" class="btn btn-secondary">🔙 Retour à la liste</a>
            </div>
        <%
            }
        %>
    </div>

    <script>
        // Validation côté client
        document.querySelector('form').addEventListener('submit', function(e) {
            const depart = document.getElementById('id_ville_depart').value;
            const arrivee = document.getElementById('id_ville_arrivee').value;
            const dateDepart = document.getElementById('date_heure_depart').value;
            const dateArrivee = document.getElementById('date_heure_arrivee').value;
            
            if (depart === arrivee) {
                alert('La ville de départ et d\'arrivée ne peuvent pas être identiques');
                e.preventDefault();
                return;
            }
            
            if (dateDepart && dateArrivee && dateDepart >= dateArrivee) {
                alert('La date de départ doit être antérieure à la date d\'arrivée');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
