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
    public ModelView testValidation(@ParamObject Etudiant etudiant) {
        ModelView mv;

        // Si pas d'erreurs, continuer avec la logique normale
        mv = new ModelView("/affichage.jsp");
        mv.addObject("nom", etudiant.getNom());
        mv.addObject("numero_etudiant", etudiant.getEtu());
        mv.addObject("date_de_naissance", etudiant.getDate_de_naissance());

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
