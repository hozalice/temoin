package mg.sprint.model;

import java.sql.Timestamp;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import mg.itu.prom16.annotations.*;
import mg.itu.prom16.annotations.ParamField;
import mg.itu.prom16.annotations.TimestampType;

public class Vol {
    @ParamField("id_vol")
    private int idVol;

    @ParamField("id_ville_depart")
    @IntType
    @NotNull
    private int idVilleDepart;

    @ParamField("id_ville_arrivee")
    @IntType
    @NotNull
    private int idVilleArrivee;

    @ParamField("date_heure_depart")
    @TimestampType
    @NotNull
    private Timestamp dateHeureDepart;

    @ParamField("date_heure_arrivee")
    @TimestampType
    @NotNull
    private Timestamp dateHeureArrivee;

    @ParamField("statut")
    @StringType
    private String statut;

    @ParamField("id_avion")
    @IntType
    @NotNull
    private int idAvion;

    @ParamField("prix_eco")
    @NotNull
    private Double prixEco;

    @ParamField("prix_business")
    @NotNull
    private Double prixBusiness;

    @ParamField("fin_reservation")
    @TimestampType
    private Timestamp finReservation;

    // Propriétés pour l'affichage (non persistées)
    @ParamField("nom_ville_depart")
    private String nomVilleDepart;
    @ParamField("nom_ville_arrivee")
    private String nomVilleArrivee;
    @ParamField("numero_avion")
    private String numeroAvion;

    // Constructeur par défaut
    public Vol() {
        this.statut = "prevu";
    }

    // Constructeur avec paramètres principaux
    public Vol(int idVilleDepart, int idVilleArrivee, Timestamp dateHeureDepart,
            Timestamp dateHeureArrivee, int idAvion, Double prixEco, Double prixBusiness) {
        this.idVilleDepart = idVilleDepart;
        this.idVilleArrivee = idVilleArrivee;
        this.dateHeureDepart = dateHeureDepart;
        this.dateHeureArrivee = dateHeureArrivee;
        this.idAvion = idAvion;
        this.prixEco = prixEco;
        this.prixBusiness = prixBusiness;
        this.statut = "prévu";
    }

    // ========== FONCTIONS DAO (CRUD) ==========

    // 1. Insérer un nouveau vol
    public static boolean insertVol(Vol vol) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    INSERT INTO vols (id_ville_depart, id_ville_arrivee, date_heure_depart,
                    date_heure_arrivee, statut, id_avion, prix_eco, prix_business)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, vol.getIdVilleDepart());
                pstmt.setInt(2, vol.getIdVilleArrivee());
                pstmt.setTimestamp(3, vol.getDateHeureDepart());
                pstmt.setTimestamp(4, vol.getDateHeureArrivee());
                pstmt.setString(5, vol.getStatut());
                pstmt.setInt(6, vol.getIdAvion());
                pstmt.setDouble(7, vol.getPrixEco());
                pstmt.setDouble(8, vol.getPrixBusiness());
                System.out.println("---------------------insertion---------------------");
                System.out.println(vol.getIdVilleDepart());
                System.out.println(vol.getIdVilleArrivee());
                System.out.println(vol.getDateHeureDepart());
                System.out.println(vol.getDateHeureArrivee());
                System.out.println(vol.getStatut());
                System.out.println(vol.getIdAvion());
                System.out.println(vol.getPrixEco());
                System.out.println(vol.getPrixBusiness());
                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Vol inséré avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'insertion du vol: " + e.getMessage());
            return false;
        }
    }

    // 2. Récupérer tous les vols avec les noms des villes et avions
    public static List<Vol> getAllVols() {
        List<Vol> vols = new ArrayList<>();
        String sql = """
                SELECT v.*, vd.nom as nom_ville_depart, va.nom as nom_ville_arrivee, a.numero as numero_avion
                FROM vols v
                JOIN villes vd ON v.id_ville_depart = vd.id_ville
                JOIN villes va ON v.id_ville_arrivee = va.id_ville
                JOIN avions a ON v.id_avion = a.id_avion
                ORDER BY v.date_heure_depart DESC
                """;

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Vol vol = new Vol();
                    vol.setIdVol(rs.getInt("id_vol"));
                    vol.setIdVilleDepart(rs.getInt("id_ville_depart"));
                    vol.setIdVilleArrivee(rs.getInt("id_ville_arrivee"));
                    vol.setDateHeureDepart(rs.getTimestamp("date_heure_depart"));
                    vol.setDateHeureArrivee(rs.getTimestamp("date_heure_arrivee"));
                    vol.setStatut(rs.getString("statut"));
                    vol.setIdAvion(rs.getInt("id_avion"));
                    vol.setPrixEco(rs.getDouble("prix_eco"));
                    vol.setPrixBusiness(rs.getDouble("prix_business"));
                    vol.setFinReservation(rs.getTimestamp("fin_reservation"));

                    // Propriétés d'affichage
                    vol.setNomVilleDepart(rs.getString("nom_ville_depart"));
                    vol.setNomVilleArrivee(rs.getString("nom_ville_arrivee"));
                    vol.setNumeroAvion(rs.getString("numero_avion"));

                    vols.add(vol);
                }

                System.out.println("Nombre de vols récupérés: " + vols.size());
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des vols: " + e.getMessage());
        }

        return vols;
    }

    // 3. Récupérer un vol par son ID
    public static Vol getVolById(int idVol) {
        String sql = """
                SELECT v.*, vd.nom as nom_ville_depart, va.nom as nom_ville_arrivee, a.numero as numero_avion
                FROM vols v
                JOIN villes vd ON v.id_ville_depart = vd.id_ville
                JOIN villes va ON v.id_ville_arrivee = va.id_ville
                JOIN avions a ON v.id_avion = a.id_avion
                WHERE v.id_vol = ?
                """;

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, idVol);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    Vol vol = new Vol();
                    vol.setIdVol(rs.getInt("id_vol"));
                    vol.setIdVilleDepart(rs.getInt("id_ville_depart"));
                    vol.setIdVilleArrivee(rs.getInt("id_ville_arrivee"));
                    vol.setDateHeureDepart(rs.getTimestamp("date_heure_depart"));
                    vol.setDateHeureArrivee(rs.getTimestamp("date_heure_arrivee"));
                    vol.setStatut(rs.getString("statut"));
                    vol.setIdAvion(rs.getInt("id_avion"));
                    vol.setPrixEco(rs.getDouble("prix_eco"));
                    vol.setPrixBusiness(rs.getDouble("prix_business"));
                    vol.setFinReservation(rs.getTimestamp("fin_reservation"));

                    // Propriétés d'affichage
                    vol.setNomVilleDepart(rs.getString("nom_ville_depart"));
                    vol.setNomVilleArrivee(rs.getString("nom_ville_arrivee"));
                    vol.setNumeroAvion(rs.getString("numero_avion"));

                    System.out.println("Vol trouvé: " + vol.toString());
                    return vol;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération du vol: " + e.getMessage());
        }

        return null;
    }

    // 4. Mettre à jour un vol
    public static boolean updateVol(Vol vol) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = """
                    UPDATE vols SET
                    id_ville_depart = ?, id_ville_arrivee = ?, date_heure_depart = ?,
                    date_heure_arrivee = ?, statut = ?, id_avion = ?, prix_eco = ?,
                    prix_business = ?
                    WHERE id_vol = ?
                    """;

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, vol.getIdVilleDepart());
                pstmt.setInt(2, vol.getIdVilleArrivee());
                pstmt.setTimestamp(3, vol.getDateHeureDepart());
                pstmt.setTimestamp(4, vol.getDateHeureArrivee());
                pstmt.setString(5, vol.getStatut());
                pstmt.setInt(6, vol.getIdAvion());
                pstmt.setDouble(7, vol.getPrixEco());
                pstmt.setDouble(8, vol.getPrixBusiness());
                pstmt.setInt(9, vol.getIdVol());

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Vol mis à jour avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour du vol: " + e.getMessage());
            return false;
        }
    }

    // 5. Supprimer un vol (annuler)
    public static boolean deleteVol(int idVol) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = "DELETE FROM vols WHERE id_vol = ?";

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, idVol);

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Vol supprimé avec succès! Lignes affectées: " + rowsAffected);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du vol: " + e.getMessage());
            return false;
        }
    }

    // 6. Récupérer toutes les villes (pour les listes déroulantes)
    public static List<Ville> getAllVilles() {
        List<Ville> villes = new ArrayList<>();
        String sql = "SELECT * FROM villes ORDER BY nom";

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Ville ville = new Ville();
                    ville.setIdVille(rs.getInt("id_ville"));
                    ville.setNom(rs.getString("nom"));
                    villes.add(ville);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des villes: " + e.getMessage());
        }

        return villes;
    }

    // 7. Récupérer tous les avions (pour les listes déroulantes)
    public static List<Avion> getAllAvions() {
        List<Avion> avions = new ArrayList<>();
        String sql = "SELECT * FROM avions ORDER BY numero";

        try {
            Connexion connexion = Connexion.getInstance();
            try (Connection conn = connexion.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Avion avion = new Avion();
                    avion.setIdAvion(rs.getInt("id_avion"));
                    avion.setNumero(rs.getString("numero"));
                    avion.setModele(rs.getString("modele"));
                    avion.setNbSiegeBusiness(rs.getInt("nbsiegebusiness"));
                    avion.setNbSiegeEco(rs.getInt("nbsiegeeco"));
                    avion.setDateCreation(rs.getDate("date_creation"));
                    avions.add(avion);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des avions: " + e.getMessage());
        }

        return avions;
    }

    // Getters et Setters
    public int getIdVol() {
        return idVol;
    }

    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }

    public int getIdVilleDepart() {
        return idVilleDepart;
    }

    public void setIdVilleDepart(int idVilleDepart) {
        this.idVilleDepart = idVilleDepart;
    }

    public int getIdVilleArrivee() {
        return idVilleArrivee;
    }

    public void setIdVilleArrivee(int idVilleArrivee) {
        this.idVilleArrivee = idVilleArrivee;
    }

    public Timestamp getDateHeureDepart() {
        return dateHeureDepart;
    }

    public void setDateHeureDepart(Timestamp dateHeureDepart) {
        this.dateHeureDepart = dateHeureDepart;
    }

    public Timestamp getDateHeureArrivee() {
        return dateHeureArrivee;
    }

    public void setDateHeureArrivee(Timestamp dateHeureArrivee) {
        this.dateHeureArrivee = dateHeureArrivee;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public int getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(int idAvion) {
        this.idAvion = idAvion;
    }

    public Double getPrixEco() {
        return prixEco;
    }

    public void setPrixEco(Double prixEco) {
        this.prixEco = prixEco;
    }

    public Double getPrixBusiness() {
        return prixBusiness;
    }

    public void setPrixBusiness(Double prixBusiness) {
        this.prixBusiness = prixBusiness;
    }

    public Timestamp getFinReservation() {
        return finReservation;
    }

    public void setFinReservation(Timestamp finReservation) {
        this.finReservation = finReservation;
    }

    // Getters et Setters pour les propriétés d'affichage
    public String getNomVilleDepart() {
        return nomVilleDepart;
    }

    public void setNomVilleDepart(String nomVilleDepart) {
        this.nomVilleDepart = nomVilleDepart;
    }

    public String getNomVilleArrivee() {
        return nomVilleArrivee;
    }

    public void setNomVilleArrivee(String nomVilleArrivee) {
        this.nomVilleArrivee = nomVilleArrivee;
    }

    public String getNumeroAvion() {
        return numeroAvion;
    }

    public void setNumeroAvion(String numeroAvion) {
        this.numeroAvion = numeroAvion;
    }

    @Override
    public String toString() {
        return "Vol " + idVol + " : " + nomVilleDepart + " → " + nomVilleArrivee +
                " (" + dateHeureDepart + ")";
    }
}
