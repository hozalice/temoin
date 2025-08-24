package mg.sprint.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Modèle Java correspondant à la table parametrage_annulation_reservation.
 * Permet de gérer le délai maximum (en heures) avant le départ pour
 * annuler une réservation.
 */
public class ParametrageAnnulationReservation {

    private int delaiMaxHeures;

    public ParametrageAnnulationReservation() {
    }

    public ParametrageAnnulationReservation(int delaiMaxHeures) {
        this.delaiMaxHeures = delaiMaxHeures;
    }

    /* ============ DAO helpers ============ */

    /**
     * Renvoie la valeur actuelle du délai maximum. 2 si aucune config.
     */
    public static int getDelaiMaxHeures1() {
        String sql = "SELECT delai_max_heures FROM parametrage_annulation_reservation LIMIT 1";
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
            System.err.println("Erreur lecture delai_max_heures: " + e.getMessage());
        }
        return 2;
    }

    /**
     * Met à jour ou crée la config.
     */
    public static boolean updateDelaiMaxHeures(int newDelay) {
        String sqlUpdate = "UPDATE parametrage_annulation_reservation SET delai_max_heures = ?";
        String sqlInsert = "INSERT INTO parametrage_annulation_reservation(delai_max_heures) VALUES (?)";
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
            System.err.println("Erreur MAJ delai_max_heures: " + e.getMessage());
            return false;
        }
    }

    /* getters/setters */
    public int getDelaiMaxHeures() {
        return delaiMaxHeures;
    }

    public void setDelaiMaxHeures(int delaiMaxHeures) {
        this.delaiMaxHeures = delaiMaxHeures;
    }
}
