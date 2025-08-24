package mg.sprint.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import mg.itu.prom16.annotations.*;
import mg.sprint.model.Vol;

public class Promotion {

    @ParamField("id_promotion")
    private int idPromotion;

    @ParamField("daty")
    @DateType
    private Date daty; // Plus obligatoire

    @ParamField("pourcentage_reduction_prix")
    @StringType
    @NotNull
    private String pourcentageReductionPrix; // Changé en String

    @ParamField("nb_siege")
    @StringType
    @NotNull
    private String nbSiege; // Changé en String

    @ParamField("id_vol")
    @IntType
    @NotNull
    private int idVol;

    @ParamField("type_siege")
    @StringType
    @NotNull
    private String typeSiege; // "eco" ou "business"

    // Propriétés d'affichage (non persistées)
    @ParamField("nom_vol")
    private String nomVol;
    @ParamField("date_depart")
    private Timestamp dateDepart;
    @ParamField("date_arrivee")
    private Timestamp dateArrivee;

    // Constructeur par défaut
    public Promotion() {
    }

    // Constructeur avec paramètres principaux
    public Promotion(Date daty, String pourcentageReductionPrix, String nbSiege, int idVol, String typeSiege) {
        this.daty = daty;
        this.pourcentageReductionPrix = pourcentageReductionPrix;
        this.nbSiege = nbSiege;
        this.idVol = idVol;
        this.typeSiege = typeSiege;
    }

    // ========== FONCTIONS DAO (CRUD) ==========

    // 1. Insérer une nouvelle promotion
    public static boolean insertPromotion(Promotion promotion) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    INSERT INTO promotion (daty, pourcentage_reduction_prix, nb_siege, id_vol)
                    VALUES (?, ?, ?, ?)
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setDate(1, promotion.getDaty());
                pstmt.setString(2, promotion.getPourcentageReductionPrix());
                pstmt.setString(3, promotion.getNbSiege());
                pstmt.setInt(4, promotion.getIdVol());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Promotion insérée avec succès! Lignes affectées: " + rowsAffected);

                // Insérer le type de siège
                if (rowsAffected > 0) {
                    return insertTypeSiege(promotion);
                }
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'insertion de la promotion: " + e.getMessage());
            return false;
        }
    }

    // 2. Insérer le type de siège
    private static boolean insertTypeSiege(Promotion promotion) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    INSERT INTO typesiege (type, id_promotion)
                    SELECT ?, id_promotion FROM promotion
                    WHERE daty = ? AND pourcentage_reduction_prix = ? AND nb_siege = ? AND id_vol = ?
                    ORDER BY id_promotion DESC LIMIT 1
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, promotion.getTypeSiege());
                pstmt.setDate(2, promotion.getDaty());
                pstmt.setString(3, promotion.getPourcentageReductionPrix());
                pstmt.setString(4, promotion.getNbSiege());
                pstmt.setInt(5, promotion.getIdVol());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Type de siège inséré avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'insertion du type de siège: " + e.getMessage());
            return false;
        }
    }

    // 3. Récupérer toutes les promotions avec les informations des vols
    public static List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = """
                SELECT p.*, v.date_heure_depart, v.date_heure_arrivee,
                       vd.nom as nom_ville_depart, va.nom as nom_ville_arrivee,
                       ts.type as type_siege
                FROM promotion p
                JOIN vols v ON p.id_vol = v.id_vol
                JOIN villes vd ON v.id_ville_depart = vd.id_ville
                JOIN villes va ON v.id_ville_arrivee = va.id_ville
                JOIN typesiege ts ON p.id_promotion = ts.id_promotion
                ORDER BY p.daty DESC, p.id_promotion DESC
                """;

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Promotion promotion = new Promotion();
                    promotion.setIdPromotion(rs.getInt("id_promotion"));
                    promotion.setDaty(rs.getDate("daty"));
                    promotion.setPourcentageReductionPrix(rs.getString("pourcentage_reduction_prix"));
                    promotion.setNbSiege(rs.getString("nb_siege"));
                    promotion.setIdVol(rs.getInt("id_vol"));
                    promotion.setTypeSiege(rs.getString("type_siege"));

                    // Propriétés d'affichage
                    promotion.setDateDepart(rs.getTimestamp("date_heure_depart"));
                    promotion.setDateArrivee(rs.getTimestamp("date_heure_arrivee"));
                    promotion.setNomVol(rs.getString("nom_ville_depart") + " → " + rs.getString("nom_ville_arrivee"));

                    promotions.add(promotion);
                }

                System.out.println("Nombre de promotions récupérées: " + promotions.size());
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des promotions: " + e.getMessage());
        }

        return promotions;
    }

    // 4. Récupérer une promotion par son ID
    public static Promotion getPromotionById(int idPromotion) {
        String sql = """
                SELECT p.*, v.date_heure_depart, v.date_heure_arrivee,
                       vd.nom as nom_ville_depart, va.nom as nom_ville_arrivee,
                       ts.type as type_siege
                FROM promotion p
                JOIN vols v ON p.id_vol = v.id_vol
                JOIN villes vd ON v.id_ville_depart = vd.id_ville
                JOIN villes va ON v.id_ville_arrivee = va.id_ville
                JOIN typesiege ts ON p.id_promotion = ts.id_promotion
                WHERE p.id_promotion = ?
                """;

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, idPromotion);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    Promotion promotion = new Promotion();
                    promotion.setIdPromotion(rs.getInt("id_promotion"));
                    promotion.setDaty(rs.getDate("daty"));
                    promotion.setPourcentageReductionPrix(rs.getString("pourcentage_reduction_prix"));
                    promotion.setNbSiege(rs.getString("nb_siege"));
                    promotion.setIdVol(rs.getInt("id_vol"));
                    promotion.setTypeSiege(rs.getString("type_siege"));

                    // Propriétés d'affichage
                    promotion.setDateDepart(rs.getTimestamp("date_heure_depart"));
                    promotion.setDateArrivee(rs.getTimestamp("date_heure_arrivee"));
                    promotion.setNomVol(rs.getString("nom_ville_depart") + " → " + rs.getString("nom_ville_arrivee"));

                    return promotion;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération de la promotion: " + e.getMessage());
        }

        return null;
    }

    // 5. Mettre à jour une promotion
    public static boolean updatePromotion(Promotion promotion) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    UPDATE promotion SET
                    daty = ?, pourcentage_reduction_prix = ?, nb_siege = ?, id_vol = ?
                    WHERE id_promotion = ?
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setDate(1, promotion.getDaty());
                pstmt.setString(2, promotion.getPourcentageReductionPrix());
                pstmt.setString(3, promotion.getNbSiege());
                pstmt.setInt(4, promotion.getIdVol());
                pstmt.setInt(5, promotion.getIdPromotion());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Promotion mise à jour avec succès! Lignes affectées: " + rowsAffected);

                if (rowsAffected > 0) {
                    // Mettre à jour le type de siège
                    return updateTypeSiege(promotion);
                }
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de la promotion: " + e.getMessage());
            return false;
        }
    }

    // 6. Mettre à jour le type de siège
    private static boolean updateTypeSiege(Promotion promotion) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    UPDATE typesiege SET type = ?
                    WHERE id_promotion = ?
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, promotion.getTypeSiege());
                pstmt.setInt(2, promotion.getIdPromotion());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Type de siège mis à jour avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du type de siège: " + e.getMessage());
            return false;
        }
    }

    // 7. Supprimer une promotion
    public static boolean deletePromotion(int idPromotion) {
        try {
            Connexion connexion = Connexion.getInstance();

            // Supprimer d'abord le type de siège (contrainte de clé étrangère)
            String sqlDeleteTypeSiege = "DELETE FROM typesiege WHERE id_promotion = ?";
            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sqlDeleteTypeSiege)) {

                pstmt.setInt(1, idPromotion);
                pstmt.executeUpdate();
            }

            // Puis supprimer la promotion
            String sqlDeletePromotion = "DELETE FROM promotion WHERE id_promotion = ?";
            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sqlDeletePromotion)) {

                pstmt.setInt(1, idPromotion);
                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Promotion supprimée avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de la promotion: " + e.getMessage());
            return false;
        }
    }

    // Getters et Setters
    public int getIdPromotion() {
        return idPromotion;
    }

    public void setIdPromotion(int idPromotion) {
        this.idPromotion = idPromotion;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getPourcentageReductionPrix() {
        return pourcentageReductionPrix;
    }

    public void setPourcentageReductionPrix(String pourcentageReductionPrix) {
        this.pourcentageReductionPrix = pourcentageReductionPrix;
    }

    public String getNbSiege() {
        return nbSiege;
    }

    public void setNbSiege(String nbSiege) {
        this.nbSiege = nbSiege;
    }

    public int getIdVol() {
        return idVol;
    }

    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }

    public String getTypeSiege() {
        return typeSiege;
    }

    public void setTypeSiege(String typeSiege) {
        this.typeSiege = typeSiege;
    }

    // Getters et Setters pour les propriétés d'affichage
    public String getNomVol() {
        return nomVol;
    }

    public void setNomVol(String nomVol) {
        this.nomVol = nomVol;
    }

    public Timestamp getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Timestamp dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Timestamp getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Timestamp dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    @Override
    public String toString() {
        return "Promotion " + idPromotion + " : " + pourcentageReductionPrix + "% sur " + nbSiege + " sièges "
                + typeSiege;
    }
}
