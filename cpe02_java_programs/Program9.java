import javax.swing.JOptionPane;

// Program 9: Daily High Temperatures Analysis
public class Program9 {
    public static void main(String[] args) {
        int hot = 0, pleasant = 0, cold = 0;
        String out = "";
        String input = JOptionPane.showInputDialog("Enter temperature (blank/Cancel to finish):");
        while (input != null && !input.trim().isEmpty()) {
            int t = Integer.parseInt(input.trim());
            if (t >= 85) {
                hot++;
                out += t + " - Hot\n";
            } else if (t >= 60) {
                pleasant++;
                out += t + " - Pleasant\n";
            } else {
                cold++;
                out += t + " - Cold\n";
            }
            input = JOptionPane.showInputDialog("Enter temperature (blank/Cancel to finish):");
        }
        JOptionPane.showMessageDialog(null, out + "\nHot: " + hot + "\nPleasant: " + pleasant + "\nCold: " + cold);
    }
}
