package mg.sprint.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Modèle Java correspondant à la table parametrage_heure_reservation.
 * Permet de récupérer et de mettre à jour le délai minimum (en heures)
 * avant le départ pour pouvoir effectuer une réservation.
 */
public class ParametrageHeureReservation {

    private int delaiMinHeures;

    public ParametrageHeureReservation() {
    }

    public ParametrageHeureReservation(int delaiMinHeures) {
        this.delaiMinHeures = delaiMinHeures;
    }

    /* ================= DAO helpers ================= */

    /**
     * Retourne le délai actuellement paramétré. Si aucun enregistrement
     * n'existe, 2 est renvoyé (valeur par défaut du schéma SQL).
     */
    public static int getDelaiMinHeures1() {
        String sql = "SELECT delai_min_heures FROM parametrage_heure_reservation LIMIT 1";
        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lecture delai_min_heures: " + e.getMessage());
        }
        return 2;
    }

    /**
     * Met à jour le délai. S'il n'existe pas encore de ligne, on l'insère.
     */
    public static boolean updateDelaiMinHeures(int newDelay) {
        String sqlUpdate = "UPDATE parametrage_heure_reservation SET delai_min_heures = ?";
        String sqlInsert = "INSERT INTO parametrage_heure_reservation(delai_min_heures) VALUES (?)";
        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection()) {
                int affected;
                try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
                    ps.setInt(1, newDelay);
                    affected = ps.executeUpdate();
                }
                if (affected == 0) {
                    try (PreparedStatement ps = conn.prepareStatement(sqlInsert)) {
                        ps.setInt(1, newDelay);
                        ps.executeUpdate();
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Erreur MAJ delai_min_heures: " + e.getMessage());
            return false;
        }
    }

    /* ============ getters / setters ============ */
    public int getDelaiMinHeures() {
        return delaiMinHeures;
    }

    public void setDelaiMinHeures(int delaiMinHeures) {
        this.delaiMinHeures = delaiMinHeures;
    }
}
