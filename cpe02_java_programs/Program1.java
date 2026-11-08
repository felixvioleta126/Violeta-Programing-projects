import javax.swing.JOptionPane;

// Program 1: Arithmetic Sequence
public class Program1 {
    public static void main(String[] args) {
        int first = Integer.parseInt(JOptionPane.showInputDialog("Enter first number:"));
        int diff = Integer.parseInt(JOptionPane.showInputDialog("Enter difference:"));
        int[] seq = new int[16];
        String out = "";
        for (int i = 0; i < 16; i++) {
            seq[i] = first + i * diff;
            out += seq[i] + " ";
        }
        JOptionPane.showMessageDialog(null, out.trim());
    }

}
