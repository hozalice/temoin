package mg.sprint.model;

import java.sql.Date;

import mg.itu.prom16.annotations.IntType;
import mg.itu.prom16.annotations.NotNull;
import mg.itu.prom16.annotations.ParamField;
import mg.itu.prom16.annotations.StringType;
import mg.itu.prom16.annotations.DateType;

public class Etudiant {

    @ParamField("nom")
    @StringType
    @NotNull
    String nom;

    @ParamField("etu")
    @IntType
    @NotNull
    int etu;

    @ParamField("date_de_naissance")
    @DateType
    @NotNull
    Date date_de_naissance;

    public Etudiant() {
    }

    public Etudiant(String nom, int etu, Date date_de_naissance) {
        this.nom = nom;
        this.etu = etu;
        this.date_de_naissance = date_de_naissance;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getEtu() {
        return etu;
    }

    public void setEtu(int etu) {
        this.etu = etu;
    }

    public Date getDate_de_naissance() {
        return date_de_naissance;
    }

    public void setDate_de_naissance(Date date_de_naissance) {
        this.date_de_naissance = date_de_naissance;
    }
}
