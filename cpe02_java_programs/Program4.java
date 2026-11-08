import javax.swing.JOptionPane;

// Program 4: Triangle Classification
public class Program4 {
    public static void main(String[] args) {
        double a = Double.parseDouble(JOptionPane.showInputDialog("Enter side 1:"));
        double b = Double.parseDouble(JOptionPane.showInputDialog("Enter side 2:"));
        double c = Double.parseDouble(JOptionPane.showInputDialog("Enter side 3:"));
        String type;
        if (a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a) {
            type = "not a valid triangle";
        } else if (a == b && b == c) {
            type = "Equilateral";
        } else if (a == b || b == c || a == c) {
            type = "Isosceles";
        } else {
            type = "Scalene";
        }
        JOptionPane.showMessageDialog(null, "The triangle is " + type + ".");
    }
}
