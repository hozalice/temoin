package mg.sprint.model;

import mg.itu.prom16.annotations.*;

public class ValidationTest {
    @ParamField("nom")
    @NotNull
    @StringType
    private String nom;

    @ParamField("age")
    @NotNull
    @IntType
    private Integer age;

    @ParamField("moyenne")
    @NotNull
    @DoubleType
    private Double moyenne;

    // Getters and Setters
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Double getMoyenne() {
        return moyenne;
    }

    public void setMoyenne(Double moyenne) {
        this.moyenne = moyenne;
    }
}
