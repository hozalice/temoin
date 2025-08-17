package mg.sprint.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
    // Paramètres de connexion PostgreSQL
    private static final String URL = "jdbc:postgresql://localhost:5432/temoin";
    private static final String USER = "postgres";
    private static final String PASSWORD = "hozalice";

    // Instance unique (Singleton)
    private static Connexion instance;
    private Connection connection;

    // Constructeur privé (Singleton)
    private Connexion() {
        try {
            // Charger le driver PostgreSQL
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur: Driver PostgreSQL non trouvé");
            e.printStackTrace();
        }
    }

    // Méthode pour obtenir l'instance unique
    public static Connexion getInstance() {
        if (instance == null) {
            instance = new Connexion();
        }
        return instance;
    }

    // Méthode pour obtenir la connexion
    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Connexion à PostgreSQL établie avec succès!");
            } catch (SQLException e) {
                System.err.println("Erreur lors de la connexion à PostgreSQL: " + e.getMessage());
                throw e;
            }
        }
        return connection;
    }

    // Méthode pour fermer la connexion
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Connexion à PostgreSQL fermée.");
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture de la connexion: " + e.getMessage());
            }
        }
    }

    // Méthode pour tester la connexion
    public boolean testConnection() {
        try {
            Connection conn = getConnection();
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Erreur lors du test de connexion: " + e.getMessage());
            return false;
        }
    }

    // Méthode pour configurer les paramètres de connexion
    public static void setConnectionParams(String url, String user, String password) {
        // Note: Dans une vraie application, vous pourriez vouloir utiliser des
        // propriétés
        // ou des variables d'environnement pour ces paramètres
        System.out.println("Configuration de la connexion:");
        System.out.println("URL: " + url);
        System.out.println("User: " + user);
        System.out.println("Password: " + (password != null ? "***" : "null"));
    }
}
