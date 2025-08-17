package mg.sprint.model;

import java.sql.Date;
import mg.itu.prom16.annotations.*;

public class Avion {
    @ParamField("id_avion")
    private int idAvion;

    @ParamField("numero")
    @StringType
    @NotNull
    private String numero; // immatriculation

    @ParamField("modele")
    @StringType
    @NotNull
    private String modele;

    @ParamField("nbsiegebusiness")
    @IntType
    private int nbSiegeBusiness;

    @ParamField("nbsiegeeco")
    @IntType
    private int nbSiegeEco;

    @ParamField("date_creation")
    @DateType
    private Date dateCreation;

    // Constructeur par défaut
    public Avion() {
    }

    // Constructeur avec paramètres
    public Avion(int idAvion, String numero, String modele, int nbSiegeBusiness, int nbSiegeEco, Date dateCreation) {
        this.idAvion = idAvion;
        this.numero = numero;
        this.modele = modele;
        this.nbSiegeBusiness = nbSiegeBusiness;
        this.nbSiegeEco = nbSiegeEco;
        this.dateCreation = dateCreation;
    }

    // Constructeur sans ID (pour insertion)
    public Avion(String numero, String modele, int nbSiegeBusiness, int nbSiegeEco) {
        this.numero = numero;
        this.modele = modele;
        this.nbSiegeBusiness = nbSiegeBusiness;
        this.nbSiegeEco = nbSiegeEco;
    }

    // Getters et Setters
    public int getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(int idAvion) {
        this.idAvion = idAvion;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public int getNbSiegeBusiness() {
        return nbSiegeBusiness;
    }

    public void setNbSiegeBusiness(int nbSiegeBusiness) {
        this.nbSiegeBusiness = nbSiegeBusiness;
    }

    public int getNbSiegeEco() {
        return nbSiegeEco;
    }

    public void setNbSiegeEco(int nbSiegeEco) {
        this.nbSiegeEco = nbSiegeEco;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    @Override
    public String toString() {
        return numero + " - " + modele;
    }
}
