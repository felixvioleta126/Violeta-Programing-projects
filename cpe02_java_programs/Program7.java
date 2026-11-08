import javax.swing.JOptionPane;

// Program 7: Prime or Composite Checker
public class Program7 {
    public static void main(String[] args) {
        int n = Integer.parseInt(JOptionPane.showInputDialog("Enter an integer:"));
        boolean prime = true;
        for (int d = 2; d <= n / d; d++) {
            if (n % d == 0) {
                prime = false;
                break;
            }
        }
        String result;
        if (n <= 1) {
            result = "neither prime nor composite";
        } else if (prime) {
            result = "Prime";
        } else {
            result = "Composite";
        }
        JOptionPane.showMessageDialog(null, n + " is " + result + ".");
    }
}
