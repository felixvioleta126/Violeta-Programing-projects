import javax.swing.JOptionPane;

// Program 2: Min/Max and Sorting of 5 Numbers
public class Program2 {
    public static void main(String[] args) {
        int[] a = new int[5];
        for (int i = 0; i < 5; i++) {
            a[i] = Integer.parseInt(JOptionPane.showInputDialog("Enter number " + (i + 1) + ":"));
        }
        // Bubble sort (ascending)
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4 - i; j++) {
                if (a[j] > a[j + 1]) {
                    int t = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = t;
                }
            }
        }
        String asc = "", desc = "";
        for (int i = 0; i < 5; i++) {
            asc += a[i] + " ";
            desc += a[4 - i] + " ";
        }
        JOptionPane.showMessageDialog(null, "Lowest: " + a[0] + "\nHighest: " + a[4]
                + "\nAscending: " + asc + "\nDescending: " + desc);
    }
}
