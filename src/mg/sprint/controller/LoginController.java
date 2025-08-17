package mg.sprint.controller;

import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.User;

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
        } else {
            // Connexion échouée
            mv = new ModelView("/login.jsp");
            mv.addObject("errorMessage", "Login ou mot de passe incorrect");
        }

        return mv;
    }
}