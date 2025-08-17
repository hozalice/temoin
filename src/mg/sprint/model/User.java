package mg.sprint.model;

import java.sql.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mg.itu.prom16.annotations.*;

public class User {
    @ParamField("nom")
    @StringType
    @NotNull
    private String nom;

    @ParamField("prenom")
    @StringType
    @NotNull
    private String prenom;

    @ParamField("date_naissance")
    @DateType
    @NotNull
    private Date dateNaissance;

    @ParamField("login")
    @StringType
    @NotNull
    private String login;

    @ParamField("password")
    @StringType
    @NotNull
    private String password;

    // Constructeur par défaut
    public User() {
    }

    // Constructeur avec paramètres
    public User(String nom, String prenom, Date dateNaissance, String login, String password) {
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.login = login;
        this.password = password;
    }

    // Getters et Setters
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", dateNaissance=" + dateNaissance +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    // Fonction statique pour vérifier le login et mot de passe
    public static boolean checkLogin(String login, String password) {
        try {
            Connexion connexion = Connexion.getInstance();
            String sql = "SELECT COUNT(*) FROM users WHERE login = ? AND password = ?";

            try (Connection conn = connexion.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, login);
                pstmt.setString(2, password);

                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la vérification du login: " + e.getMessage());
        }
        return false;
    }
}