package Service;

import DAO.StaffMapper;
import Database.Database;
import Design.Design;
import Entity.Staff;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.Scanner;

public class StaffMenu {
        static Staff staff = new Staff();

        public static void staffMenu(int choice) throws IOException {
            Scanner sc = new Scanner(System.in);
            boolean keepRunning = true;

            while (keepRunning) {
                Design.DesignLOGO();

                int option = 0;
                boolean validInput = false;

                while (!validInput) {
                    System.out.print("""
                    1) Sign Up
                    2) Log In
                    3) Exit
                    Enter your option:""");

                    if (sc.hasNextInt()) {
                        option = sc.nextInt();
                        validInput = true;
                    } else {
                        System.out.println("Invalid input. Please enter a number between 1 and 3.");
                        sc.next();
                    }
                }

                switch (option) {
                    case 1:
                        signUp();
                        break;
                    case 2:
                        selectInformation(choice);
                        break;
                    case 3:
                        System.out.println("Exiting the program...");
                        keepRunning = false;
                        break;
                    default:
                        System.out.println("Invalid option. Please select a valid option between 1 and 3.");
                        break;
                }
            }
        }

    public static Staff getLogin() {
        Scanner in = new Scanner(System.in);
        Staff login = new Staff();
        System.out.print("Enter your id: ");
        login.setId(in.nextLine());
        System.out.print("Enter your password: ");
        login.setPassword(in.nextLine());
        return  login;
    }

    public static void selectInformation(int choice) throws IOException {
        Staff login = getLogin();
        Staff currentUser = null;

        try (SqlSession conn = Database.getInstance().openSession()) {
            StaffMapper staffMapper = conn.getMapper(StaffMapper.class);
            currentUser = staffMapper.selectStaffByIdAndPassword(login.getId());
        }
        if (currentUser != null) {
            if (currentUser.getPassword().equals(login.getPassword())) {
                System.out.println("You have successfully logged in!");
                ProfileMenu.profileList(currentUser.getId(),choice);
            } else {
                System.out.println("Wrong Password");
            }
        }
        else{
            System.out.println("Wrong ID");
        }

    }

    public static Staff getInput() {

        Staff staff = new Staff();
        Scanner in = new Scanner(System.in);


        String name;
        do {
            System.out.print("Enter name (only letters, at least 2 characters): ");
            name = in.nextLine();
            if (!name.matches("[a-zA-Z\\s]{2,}")) {
                System.out.println("Invalid name. Please enter a valid name.");
            } else {
                staff.setName(name);
            }
        } while (!name.matches("[a-zA-Z\\s]{2,}"));


        System.out.print("Enter Password: ");
        staff.setPassword(in.nextLine());


        int age;
        do {
            System.out.print("Enter age (must be between 18 and 65): ");
            while (!in.hasNextInt()) {
                System.out.println("Invalid input. Please enter a number.");
                in.next();
            }
            age = in.nextInt();
            if (age < 18 || age > 65) {
                System.out.println("Invalid age. Please enter a valid age between 18 and 65.");
            }
        } while (age < 18 || age > 65);
        staff.setAge(age);

        // Gender selection
        int selection;
        int check = 0;
        System.out.print("""
            1) Male
            2) Female
            Enter gender:""");
        do {
            selection = in.nextInt();
            switch (selection) {
                case 1:
                    staff.setGender("Male");
                    check = 1;
                    break;
                case 2:
                    staff.setGender("Female");
                    check = 1;
                    break;
                default:
                    System.out.println("Invalid selection. Please enter 1 for Male or 2 for Female.");
            }
        } while (check != 1);

        in.nextLine();

            boolean keepRunning = true;

            while (keepRunning) {
                int selectP = 0;
                boolean validInput = false;

                do {
                    System.out.print("""
                1) Inventory Clerk
                2) Warehouse Staff
                3) Logistics Coordinator
                Enter your option:""");

                    if (in.hasNextInt()) {
                        selectP = in.nextInt();
                        if (selectP >= 1 && selectP <= 3) {
                            validInput = true; // Set validInput to true only if the number is between 1 and 3
                        } else {
                            System.out.println("Invalid option. Please enter a number between 1 and 3.");
                        }
                    } else {
                        System.out.println("Invalid input. Please enter a number.");
                        in.next(); // Clear the invalid input
                    }
                } while (!validInput);

                // Use switch to assign the position based on the valid input
                switch (selectP) {
                    case 1:
                        staff.setPosition("Inventory Clerk");
                        keepRunning = false; // Exit the loop after assigning
                        break;
                    case 2:
                        staff.setPosition("Warehouse Staff");
                        keepRunning = false;
                        break;
                    case 3:
                        staff.setPosition("Logistics Coordinator");
                        keepRunning = false;
                        break;
                    default:
                        System.out.println("Invalid option. Please select a valid option between 1 and 3.");
                        break;
                }
            }
        in.nextLine();
        String phone;
        do {
            System.out.print("Enter phone (in format XXX-XXXXXXX or 10-13 digits): ");
            phone = in.nextLine();
            if (!phone.matches("\\d{3}-\\d{7}") && !phone.matches("\\d{10,13}")) {
                System.out.println("Invalid phone number. Please enter a valid phone number (e.g., 019-4719766 or 10-13 digits).");
            } else {
                staff.setPhone(phone);
            }
        } while (!phone.matches("\\d{3}-\\d{7}") && !phone.matches("\\d{10,13}"));

        return staff;
    }

    public static void signUp() {
        Staff insertInput = getInput();
            try (SqlSession conn = Database.getInstance().openSession()) {
                StaffMapper staffMapper = conn.getMapper(StaffMapper.class);
                staffMapper.insert(insertInput);
                conn.commit();
            }
    }


}
