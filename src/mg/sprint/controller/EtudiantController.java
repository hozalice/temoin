package mg.sprint.controller;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.Etudiant;

@Annotation_controlleur
public class EtudiantController {

    @Annotation_Post
    @Url("etudiant")
    public ModelView testValidation(@ParamObject Etudiant etudiant, HttpServletRequest request) {
        ModelView mv;

        // Le framework ne fournit pas HttpServletRequest pour les paramètres non
        // annotés.
        // On protège donc l'accès aux attributs de requête.
        Map<String, String> fieldErrors = null;
        Map<String, String> formData = null;
        if (request != null) {
            fieldErrors = (Map<String, String>) request.getAttribute("fieldErrors");
            formData = (Map<String, String>) request.getAttribute("formData");
        }

        if (fieldErrors != null && !fieldErrors.isEmpty()) {
            // Si des erreurs existent, retourner au formulaire avec les erreurs et les
            // données saisies
            mv = new ModelView("/form.jsp");
            mv.addObject("fieldErrors", fieldErrors);
            mv.addObject("formData", formData);
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
