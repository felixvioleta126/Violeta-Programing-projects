import javax.swing.JOptionPane;

// Program 3: Number System Converter Using Arrays
public class Program3 {
    public static void main(String[] args) {
        int n = Integer.parseInt(JOptionPane.showInputDialog("Enter a positive decimal number:"));
        int choice = Integer.parseInt(JOptionPane.showInputDialog(
                "1 - Binary\n2 - Octal\n3 - Hexadecimal\nEnter choice:"));
        if (n < 0 || choice < 1 || choice > 3) {
            JOptionPane.showMessageDialog(null, "Invalid input.");
            return;
        }
        int[] bases = {2, 8, 16};
        int base = bases[choice - 1];
        char[] symbols = "0123456789ABCDEF".toCharArray();
        char[] digits = new char[32];
        int k = 0;
        do {
            digits[k++] = symbols[n % base];
            n /= base;
        } while (n > 0);
        String result = "";
        for (int i = k - 1; i >= 0; i--) {
            result += digits[i];
        }
        JOptionPane.showMessageDialog(null, "Result: " + result);
    }
}
