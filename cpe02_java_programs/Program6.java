import javax.swing.JOptionPane;

// Program 6: Day of Year Calculation
public class Program6 {
    public static void main(String[] args) {
        int month = Integer.parseInt(JOptionPane.showInputDialog("Enter month (1-12):"));
        int day = Integer.parseInt(JOptionPane.showInputDialog("Enter day:"));
        int year = Integer.parseInt(JOptionPane.showInputDialog("Enter year:"));
        int[] days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            days[1] = 29;
        }
        if (month < 1 || month > 12 || day < 1 || day > days[month - 1]) {
            JOptionPane.showMessageDialog(null, "Invalid date.");
            return;
        }
        int total = day;
        for (int i = 0; i < month - 1; i++) {
            total += days[i];
        }
        JOptionPane.showMessageDialog(null, "Day number: " + total);
    }
}
