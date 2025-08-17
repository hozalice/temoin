package mg.sprint.controller;

import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.Etudiant;

@Annotation_controlleur
public class EtudiantController {

    @Annotation_Post
    @Url("etudiant")
    public ModelView testValidation(@ParamObject Etudiant etudiant, HttpServletRequest request) {
        ModelView mv;

        // Récupérer les erreurs de validation ajoutées par le framework
        Map<String, String> fieldErrors = (Map<String, String>) request.getAttribute("fieldErrors");
        Map<String, String> formData = (Map<String, String>) request.getAttribute("formData");

        if (fieldErrors != null && !fieldErrors.isEmpty()) {
            // Si des erreurs existent, retourner au formulaire avec les erreurs et les
            // données saisies
            mv = new ModelView("/form.jsp");
            mv.addObject("fieldErrors", fieldErrors); // Ajouter les erreurs au modèle
            mv.addObject("formData", formData); // Ajouter les données saisies au modèle
        } else {
            // Si pas d'erreurs, continuer avec la logique normale
            mv = new ModelView("/affichage.jsp");
            mv.addObject("nom", etudiant.getNom());
            mv.addObject("numero_etudiant", etudiant.getEtu());
            mv.addObject("date_de_naissance", etudiant.getDate_de_naissance());
        }

        return mv;
    }

    @Annotation_Get
    @Url("etudiant")
    public ModelView getEtudiants() {
        ModelView mv = new ModelView("/etudiant.jsp");
        return mv;
    }

    @Annotation_Get
    @Url("form")
    public ModelView testForm() {
        ModelView mv = new ModelView("/form.jsp");
        return mv;
    }
}
