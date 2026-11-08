import javax.swing.JOptionPane;

// Program 8: Greatest Common Divisor (Euclidean algorithm)
public class Program8 {
    public static void main(String[] args) {
        int a = Math.abs(Integer.parseInt(JOptionPane.showInputDialog("Enter first integer:")));
        int b = Math.abs(Integer.parseInt(JOptionPane.showInputDialog("Enter second integer:")));
        int x = a, y = b;
        while (y != 0) {
            int t = x % y;
            x = y;
            y = t;
        }
        JOptionPane.showMessageDialog(null, "GCD of " + a + " and " + b + " is " + x);
    }
}
