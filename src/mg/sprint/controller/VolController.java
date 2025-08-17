package mg.sprint.controller;

import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import jakarta.servlet.http.HttpServletRequest;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.Vol;
import mg.sprint.model.Ville;
import mg.sprint.model.Avion;

@Annotation_controlleur
public class VolController {

    // Afficher la liste des vols dans l'accueil
    @Annotation_Get
    @Url("vols")
    public ModelView listVols() {
        ModelView mv = new ModelView("/accueil.jsp");
        
        // Récupérer tous les vols avec les informations des villes et avions
        List<Vol> vols = Vol.getAllVols();
        mv.addObject("vols", vols);
        
        // Récupérer les listes pour les formulaires
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }

    // Afficher le formulaire d'ajout de vol
    @Annotation_Get
    @Url("vol-form")
    public ModelView showVolForm() {
        ModelView mv = new ModelView("/vol-form.jsp");
        
        // Récupérer les listes pour les listes déroulantes
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }

    // Insérer un nouveau vol
    @Annotation_Post
    @Url("vol-insert")
    public ModelView insertVol(@ParamObject Vol vol) {
        ModelView mv = new ModelView("/accueil.jsp");
        
        try {
            // Validation basique
            if (vol.getIdVilleDepart() == vol.getIdVilleArrivee()) {
                mv.addObject("errorMessage", "La ville de départ et d'arrivée ne peuvent pas être identiques");
                return mv;
            }
            
            if (vol.getDateHeureDepart().after(vol.getDateHeureArrivee())) {
                mv.addObject("errorMessage", "La date de départ doit être antérieure à la date d'arrivée");
                return mv;
            }
            
            // Insérer le vol
            boolean success = Vol.insertVol(vol);
            
            if (success) {
                mv.addObject("successMessage", "Vol créé avec succès !");
            } else {
                mv.addObject("errorMessage", "Erreur lors de la création du vol");
            }
            
        } catch (Exception e) {
            mv.addObject("errorMessage", "Erreur: " + e.getMessage());
        }
        
        // Récupérer la liste mise à jour
        List<Vol> vols = Vol.getAllVols();
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }

    // Afficher le formulaire de modification
    @Annotation_Get
    @Url("vol-edit")
    public ModelView editVol(@Param("id") int idVol) {
        ModelView mv = new ModelView("/vol-edit.jsp");
        
        // Récupérer le vol à modifier
        Vol vol = Vol.getVolById(idVol);
        if (vol == null) {
            mv = new ModelView("/accueil.jsp");
            mv.addObject("errorMessage", "Vol non trouvé");
            return mv;
        }
        
        // Récupérer les listes pour les listes déroulantes
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("vol", vol);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }

    // Mettre à jour un vol
    @Annotation_Post
    @Url("vol-update")
    public ModelView updateVol(@ParamObject Vol vol) {
        ModelView mv = new ModelView("/accueil.jsp");
        
        try {
            // Validation basique
            if (vol.getIdVilleDepart() == vol.getIdVilleArrivee()) {
                mv.addObject("errorMessage", "La ville de départ et d'arrivée ne peuvent pas être identiques");
                return mv;
            }
            
            if (vol.getDateHeureDepart().after(vol.getDateHeureArrivee())) {
                mv.addObject("errorMessage", "La date de départ doit être antérieure à la date d'arrivée");
                return mv;
            }
            
            // Mettre à jour le vol
            boolean success = Vol.updateVol(vol);
            
            if (success) {
                mv.addObject("successMessage", "Vol modifié avec succès !");
            } else {
                mv.addObject("errorMessage", "Erreur lors de la modification du vol");
            }
            
        } catch (Exception e) {
            mv.addObject("errorMessage", "Erreur: " + e.getMessage());
        }
        
        // Récupérer la liste mise à jour
        List<Vol> vols = Vol.getAllVols();
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }

    // Supprimer/Annuler un vol
    @Annotation_Get
    @Url("vol-delete")
    public ModelView deleteVol(@Param("id") int idVol) {
        ModelView mv = new ModelView("/accueil.jsp");
        
        try {
            // Supprimer le vol
            boolean success = Vol.deleteVol(idVol);
            
            if (success) {
                mv.addObject("successMessage", "Vol annulé avec succès !");
            } else {
                mv.addObject("errorMessage", "Erreur lors de l'annulation du vol");
            }
            
        } catch (Exception e) {
            mv.addObject("errorMessage", "Erreur: " + e.getMessage());
        }
        
        // Récupérer la liste mise à jour
        List<Vol> vols = Vol.getAllVols();
        List<Ville> villes = Vol.getAllVilles();
        List<Avion> avions = Vol.getAllAvions();
        
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        
        return mv;
    }
}
