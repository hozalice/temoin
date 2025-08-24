package mg.sprint.controller;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.Promotion;
import mg.sprint.model.Vol;

@Annotation_controlleur
public class PromotionController {

    // Afficher la liste des promotions
    @Annotation_Get
    @Url("promotions")
    public ModelView listPromotions() {
        ModelView mv = new ModelView("/promotion-list.jsp");

        // Récupérer toutes les promotions
        List<Promotion> promotions = Promotion.getAllPromotions();
        mv.addObject("promotions", promotions);

        return mv;
    }

    // Afficher le formulaire d'ajout de promotion
    @Annotation_Get
    @Url("promotion-form")
    public ModelView showPromotionForm() {
        ModelView mv = new ModelView("/promotion-form.jsp");

        // Récupérer la liste des vols pour la liste déroulante
        List<Vol> vols = Vol.getAllVols();
        mv.addObject("vols", vols);

        return mv;
    }

    // Insérer une nouvelle promotion
    @Annotation_Post
    @Url("promotion-insert")
    public ModelView insertPromotion(@ParamObject Promotion promotion, HttpServletRequest request) {
        ModelView mv;

        // Récupérer les erreurs de validation ajoutées par le framework
        Map<String, String> fieldErrors = null;
        Map<String, String> formData = null;
        if (request != null) {
            fieldErrors = (Map<String, String>) request.getAttribute("fieldErrors");
            formData = (Map<String, String>) request.getAttribute("formData");
        }

        if (fieldErrors != null && !fieldErrors.isEmpty()) {
            // Si des erreurs existent, retourner au formulaire avec erreurs et données
            mv = new ModelView("/promotion-form.jsp");
            mv.addObject("fieldErrors", fieldErrors);
            mv.addObject("formData", formData);
        } else {
            try {
                // Validation métier
                try {
                    double pourcentage = Double.parseDouble(promotion.getPourcentageReductionPrix());
                    if (pourcentage <= 0 || pourcentage > 100) {
                        mv = new ModelView("/promotion-form.jsp");
                        mv.addObject("errorMessage", "Le pourcentage de réduction doit être entre 1 et 100%");
                        return mv;
                    }
                } catch (NumberFormatException e) {
                    mv = new ModelView("/promotion-form.jsp");
                    mv.addObject("errorMessage", "Le pourcentage de réduction doit être un nombre valide");
                    return mv;
                }

                try {
                    int nbSiege = Integer.parseInt(promotion.getNbSiege());
                    if (nbSiege <= 0) {
                        mv = new ModelView("/promotion-form.jsp");
                        mv.addObject("errorMessage", "Le nombre de sièges doit être supérieur à 0");
                        return mv;
                    }
                } catch (NumberFormatException e) {
                    mv = new ModelView("/promotion-form.jsp");
                    mv.addObject("errorMessage", "Le nombre de sièges doit être un nombre valide");
                    return mv;
                }

                // Insertion
                boolean success = Promotion.insertPromotion(promotion);

                mv = new ModelView("/promotions");
                if (success) {
                    mv.addObject("successMessage", "Promotion créée avec succès !");
                } else {
                    mv.addObject("errorMessage", "Erreur lors de la création de la promotion");
                }

            } catch (Exception e) {
                mv = new ModelView("/promotion-form.jsp");
                mv.addObject("errorMessage", "Erreur: " + e.getMessage());
            }
        }

        // Ajouter la liste des vols pour le formulaire
        List<Vol> vols = Vol.getAllVols();
        mv.addObject("vols", vols);

        return mv;
    }

    // Afficher le formulaire de modification
    @Annotation_Get
    @Url("promotion-edit")
    public ModelView editPromotion(@Param("id") int idPromotion) {
        ModelView mv = new ModelView("/promotion-edit.jsp");

        // Récupérer la promotion à modifier
        Promotion promotion = Promotion.getPromotionById(idPromotion);
        if (promotion == null) {
            mv = new ModelView("/promotions");
            mv.addObject("errorMessage", "Promotion non trouvée");
            return mv;
        }

        // Récupérer la liste des vols pour la liste déroulante
        List<Vol> vols = Vol.getAllVols();

        mv.addObject("promotion", promotion);
        mv.addObject("vols", vols);

        return mv;
    }

    // Mettre à jour une promotion
    @Annotation_Post
    @Url("promotion-update")
    public ModelView updatePromotion(@ParamObject Promotion promotion) {
        ModelView mv = new ModelView("/promotions");

        try {
            // Validation basique
            try {
                double pourcentage = Double.parseDouble(promotion.getPourcentageReductionPrix());
                if (pourcentage <= 0 || pourcentage > 100) {
                    mv.addObject("errorMessage", "Le pourcentage de réduction doit être entre 1 et 100%");
                    return mv;
                }
            } catch (NumberFormatException e) {
                mv.addObject("errorMessage", "Le pourcentage de réduction doit être un nombre valide");
                return mv;
            }

            try {
                int nbSiege = Integer.parseInt(promotion.getNbSiege());
                if (nbSiege <= 0) {
                    mv.addObject("errorMessage", "Le nombre de sièges doit être supérieur à 0");
                    return mv;
                }
            } catch (NumberFormatException e) {
                mv.addObject("errorMessage", "Le nombre de sièges doit être un nombre valide");
                return mv;
            }

            // Mettre à jour la promotion
            boolean success = Promotion.updatePromotion(promotion);

            if (success) {
                mv.addObject("successMessage", "Promotion modifiée avec succès !");
            } else {
                mv.addObject("errorMessage", "Erreur lors de la modification de la promotion");
            }

        } catch (Exception e) {
            mv.addObject("errorMessage", "Erreur: " + e.getMessage());
        }

        // Récupérer la liste mise à jour
        List<Promotion> promotions = Promotion.getAllPromotions();
        mv.addObject("promotions", promotions);

        return mv;
    }

    // Supprimer une promotion
    @Annotation_Get
    @Url("promotion-delete")
    public ModelView deletePromotion(@Param("id") int idPromotion) {
        ModelView mv = new ModelView("/promotions");

        try {
            // Supprimer la promotion
            boolean success = Promotion.deletePromotion(idPromotion);

            if (success) {
                mv.addObject("successMessage", "Promotion supprimée avec succès !");
            } else {
                mv.addObject("errorMessage", "Erreur lors de la suppression de la promotion");
            }

        } catch (Exception e) {
            mv.addObject("errorMessage", "Erreur: " + e.getMessage());
        }

        // Récupérer la liste mise à jour
        List<Promotion> promotions = Promotion.getAllPromotions();
        mv.addObject("promotions", promotions);

        return mv;
    }
}
