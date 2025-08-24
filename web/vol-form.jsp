<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="mg.sprint.model.Ville" %>
<%@ page import="mg.sprint.model.Avion" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Vol</title>
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
        .form-help {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
            display: block;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✈️ Ajouter un Nouveau Vol</h1>
            <p>Remplissez les informations du vol</p>
        </div>

        <form action="vol-insert" method="post">
            <div class="form-row">
                <div class="form-col">
                    <label for="id_ville_depart">Ville de départ <span class="required">*</span></label>
                    <select id="id_ville_depart" name="id_ville_depart" required>
                        <option value="">Sélectionnez une ville</option>
                        <%
                            List<Ville> villes = (List<Ville>) request.getAttribute("villes");
                            if (villes != null) {
                                for (Ville ville : villes) {
                        %>
                            <option value="<%= ville.getIdVille() %>"><%= ville.getNom() %></option>
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
                        %>
                            <option value="<%= ville.getIdVille() %>"><%= ville.getNom() %></option>
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
                    <input type="datetime-local" id="date_heure_depart" name="date_heure_depart" required>
                </div>
                <div class="form-col">
                    <label for="date_heure_arrivee">Date et heure d'arrivée <span class="required">*</span></label>
                    <input type="datetime-local" id="date_heure_arrivee" name="date_heure_arrivee" required>
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
                        %>
                            <option value="<%= avion.getIdAvion() %>"><%= avion.getNumero() %> - <%= avion.getModele() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-col">
                    <label for="statut">Statut</label>
                    <select id="statut" name="statut">
                        <option value="prévu">Prévu</option>
                        <option value="en cours">En cours</option>
                        <option value="terminé">Terminé</option>
                        <option value="annulé">Annulé</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label for="prix_eco">Prix Économique (€) <span class="required">*</span></label>
                    <input type="number" id="prix_eco" name="prix_eco" step="0.01" min="0" required>
                </div>
                <div class="form-col">
                    <label for="prix_business">Prix Business (€) <span class="required">*</span></label>
                    <input type="number" id="prix_business" name="prix_business" step="0.01" min="0" required>
                </div>
            </div>

            <div class="form-group">
                <label for="fin_reservation">Date limite de réservation</label>
                <input type="datetime-local" id="fin_reservation" name="fin_reservation">
                <small class="form-help">Laissé vide pour calcul automatique (2h avant le départ)</small>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-primary">✈️ Créer le Vol</button>
                <a href="vols" class="btn btn-secondary">🔙 Retour à la liste</a>
            </div>
        </form>
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
