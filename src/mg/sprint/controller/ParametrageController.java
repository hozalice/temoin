package mg.sprint.controller;

import jakarta.servlet.http.HttpServletRequest;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.map.ModelView;
import mg.sprint.model.ParametrageHeureReservation;
import mg.sprint.model.ParametrageAnnulationReservation;

@Annotation_controlleur
public class ParametrageController {

    // Affichage de la page de paramétrage
    @Annotation_Get
    @Url("parametrages")
    public ModelView showParametrages() {
        ModelView mv = new ModelView("/parametrage.jsp");
        mv.addObject("delaiMin", ParametrageHeureReservation.getDelaiMinHeures1());
        mv.addObject("delaiMax", ParametrageAnnulationReservation.getDelaiMaxHeures1());
        return mv;
    }

    // Mise à jour du délai minimum de réservation
    @Annotation_Post
    @Url("parametrage-update-reservation")
    public ModelView updateDelaiReservation(@Param("delai_min") int delaiMin, HttpServletRequest req) {
        System.out.println("Delai min: " + delaiMin);
        ParametrageHeureReservation.updateDelaiMinHeures(delaiMin);
        req.setAttribute("successMessage", "Délai minimum mis à jour");
        return showParametrages();
    }

    // Mise à jour du délai maximum d'annulation
    @Annotation_Post
    @Url("parametrage-update-annulation")
    public ModelView updateDelaiAnnulation(@Param("delai_max") int delaiMax, HttpServletRequest req) {
        System.out.println("Delai max: " + delaiMax);
        ParametrageAnnulationReservation.updateDelaiMaxHeures(delaiMax);
        req.setAttribute("successMessage", "Délai maximum mis à jour");
        return showParametrages();
    }
}
