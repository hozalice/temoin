package mg.sprint.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.User;
import mg.sprint.model.Vol;
import mg.sprint.model.Ville;
import mg.sprint.model.Avion;

@Annotation_controlleur
public class LoginController {

    @Annotation_Get
    @Url("login")
    public ModelView showLoginForm() {
        ModelView mv = new ModelView("/login.jsp");
        return mv;
    }

    @Annotation_Post
    @Url("login")
    public ModelView authenticate(@Param("login") String login, @Param("password") String password) {
        ModelView mv;

        // Vérifier si les champs sont vides
        if (login == null || login.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            mv = new ModelView("/login.jsp");
            mv.addObject("errorMessage", "Login et mot de passe sont obligatoires");
            return mv;
        }

        // Vérifier la connexion avec la base de données
        if (User.checkLogin(login, password)) {
            // Connexion réussie
            mv = new ModelView("/accueil.jsp");
            mv.addObject("message", "Connexion réussie !");
            mv.addObject("login", login);

            // Récupérer les vols pour l'affichage
            List<Vol> vols = Vol.getAllVols();
            List<Ville> villes = Vol.getAllVilles();
            List<Avion> avions = Vol.getAllAvions();

            mv.addObject("vols", vols);
            mv.addObject("villes", villes);
            mv.addObject("avions", avions);
        } else {
            // Connexion échouée
            mv = new ModelView("/login.jsp");
            mv.addObject("errorMessage", "Login ou mot de passe incorrect");
        }

        return mv;
    }
}