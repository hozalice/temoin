package mg.sprint.model;

import mg.itu.prom16.annotations.*;

public class Ville {
    @ParamField("id_ville")
    private int idVille;

    @ParamField("nom")
    @StringType
    @NotNull
    private String nom;

    // Constructeur par défaut
    public Ville() {
    }

    // Constructeur avec paramètres
    public Ville(int idVille, String nom) {
        this.idVille = idVille;
        this.nom = nom;
    }

    // Constructeur sans ID (pour insertion)
    public Ville(String nom) {
        this.nom = nom;
    }

    // Getters et Setters
    public int getIdVille() {
        return idVille;
    }

    public void setIdVille(int idVille) {
        this.idVille = idVille;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    @Override
    public String toString() {
        return nom;
    }
}
