<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Paramétrage des délais</title>
    <style>
        body {font-family: Arial, sans-serif; padding: 20px; background:#f4f4f4;}
        .container {max-width: 600px; margin: 0 auto; background:#fff; padding:20px; border-radius:8px; box-shadow:0 2px 6px rgba(0,0,0,.1);}        
        h1 {text-align: center; margin-bottom: 30px; color:#333;}
        form {margin-bottom: 25px;}
        label {display:block; font-weight:bold; margin-bottom:6px; color:#333;}
        input[type="number"] {width:100%; padding:8px; border:1px solid #ddd; border-radius:4px; margin-bottom:12px; box-sizing:border-box;}
        button {background:#FF6B35; color:#fff; padding:10px 20px; border:none; border-radius:4px; cursor:pointer; transition:background .3s;}
        button:hover {background:#e55a2b;}
        .success {background:#d4edda; color:#155724; padding:10px; border-radius:4px; margin-bottom:20px; border:1px solid #c3e6cb;}
    </style>
</head>
<body>
<div class="container">
    <h1>Paramétrage des délais</h1>

    <% if(request.getAttribute("successMessage") != null) { %>
        <div class="success">✅ <%= request.getAttribute("successMessage") %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/parametrage-update-reservation" method="post">
        <label>Délai minimum avant départ pour réserver (heures)</label>
        <input type="number" name="delai_min" min="0" required value="<%= request.getAttribute("delaiMin") %>"/>
        <button type="submit">Mettre à jour</button>
    </form>

    <form action="<%= request.getContextPath() %>/parametrage-update-annulation" method="post">
        <label>Délai maximum avant départ pour annuler (heures)</label>
        <input type="number" name="delai_max" min="1" required value="<%= request.getAttribute("delaiMax") %>"/>
        <button type="submit">Mettre à jour</button>
    </form>
</div>
</body>
</html>
