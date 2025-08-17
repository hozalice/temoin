// package mg.sprint.model;;

// import java.util.ArrayList;
// import java.util.List;

// public class Note {
//     String etu;
//     String matiere;
//     double note;

//     public Note(String etu, String matiere, double note) {
//         this.etu = etu;
//         this.matiere = matiere;
//         this.note = note;
//     }

//     public Note() {
//     }

//     public String getEtu() {
//         return etu;
//     }

//     public void setEtu(String etu) {
//         this.etu = etu;
//     }

//     public String getMatiere() {
//         return matiere;
//     }

//     public void setMatiere(String matiere) {
//         this.matiere = matiere;
//     }

//     public double getNote() {
//         return note;
//     }

//     public void setNote(double note) {
//         this.note = note;
//     }

//     public List<Note> getListe() {
//         List<Note> notes = new ArrayList<>();
//         notes.add(new Note("2380", "Math", 12.9));
//         notes.add(new Note("2635", "Anglais", 10.9));
//         notes.add(new Note("2777", "Science", 18.9));
//         return notes;
//     }

//     public List<Note> getListeByEtu(String etu) {
//         List<Note> all = getListe();
//         List<Note> notes = new ArrayList<>();
//         for (Note n : all) {
//             if (n.getEtu().equals(etu)) {
//                 notes.add(n);
//             }
//         }
//         return notes;
//     }
// }
