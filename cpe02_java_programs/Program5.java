import javax.swing.JOptionPane;

// Program 5: Palindrome Number Checker
public class Program5 {
    public static void main(String[] args) {
        long n = Long.parseLong(JOptionPane.showInputDialog("Enter a number:"));
        long rev = 0;
        for (long t = n; t > 0; t /= 10) {
            rev = rev * 10 + t % 10;
        }
        JOptionPane.showMessageDialog(null, n + (n >= 0 && rev == n ? " is" : " is not") + " a palindrome.");
    }
}
