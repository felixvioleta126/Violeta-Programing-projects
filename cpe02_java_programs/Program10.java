import javax.swing.JOptionPane;

// Program 10: Exam Scores and Grade Distribution
public class Program10 {
    public static void main(String[] args) {
        int[] count = new int[5]; // A, B, C, D, F
        int total = 0;
        int score = Integer.parseInt(JOptionPane.showInputDialog("Enter score (-1 to end):"));
        while (score >= 0) {
            if (score >= 90) {
                count[0]++;
            } else if (score >= 80) {
                count[1]++;
            } else if (score >= 70) {
                count[2]++;
            } else if (score >= 60) {
                count[3]++;
            } else {
                count[4]++;
            }
            total++;
            score = Integer.parseInt(JOptionPane.showInputDialog("Enter score (-1 to end):"));
        }
        JOptionPane.showMessageDialog(null, "Total = " + total + "\nA = " + count[0] + "\nB = " + count[1]
                + "\nC = " + count[2] + "\nD = " + count[3] + "\nF = " + count[4]);
    }
}
