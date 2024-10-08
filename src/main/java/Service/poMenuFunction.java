package Service;

import DAO.PurchaseOrderMapper;
import Database.Database;
import Entity.Purchase_Order;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;


public class poMenuFunction {

    public static void poListing() throws IOException {
        int poMenuOptions;
        Scanner poScanner = new Scanner(System.in);
        List<Purchase_Order> poList;
        try (SqlSession conn = Database.getInstance().openSession()) {
            PurchaseOrderMapper poMapper = conn.getMapper(PurchaseOrderMapper.class);
            poList = poMapper.selectALLpo();
        }

        System.out.printf("%-10s | %-11s | %-10s | %-7s | %-15s | %-13s | %-11s\n\n", "PO Number", "Product ID", "Quantity", "Cost", "Order Date", "Supplier ID", "Status");
        for (Purchase_Order po : poList) {
            System.out.printf("%-10s | %-11s | %-10d | %-7.2f | %-15s | %-13s | %-11s\n",
                    po.getPo_number(),
                    po.getProduct_id(),
                    po.getPurchase_quantity(),
                    po.getOrder_price(),
                    po.getOrder_date(),
                    po.getSupplier_id(),
                    po.getStatus());
        }

        do {
            System.out.println("Choose Option:");
            System.out.println("1 > Create Purchase Order");
            System.out.println("2 > Search Order History");
            System.out.println("3 > Edit Order");
            System.out.println("4 > Cancel Order");
            System.out.println("5 > Return");
            poMenuOptions = poScanner.nextInt();
            switch (poMenuOptions) {
                case 1:
                    createPurchaseOrder();
                    break;
                case 2:
                    searchPurchaseOrder();
                    break;
                case 3:
                    editPurchaseOrder();
                    break;
                case 4:
                    cancelPurchaseOrder();
                    break;
                case 5:
                    // fuckOff();
                    break;
                default:
                    System.out.println("Invalid Option. Try Again.");
                    System.in.read(); // This is supposed to be unread, dw
                    System.out.print("\n\n");
            }
        } while (poMenuOptions != 5);
    }

    public static void createPurchaseOrder() throws IOException {
        Purchase_Order newPO = getNewPurchaseOrder();
        try (SqlSession conn = Database.getInstance().openSession()) {
            PurchaseOrderMapper productMapper = conn.getMapper(PurchaseOrderMapper.class);
            productMapper.insertPo(newPO);
            conn.commit();
        }
    }

    public static Purchase_Order getNewPurchaseOrder() throws IOException {
        boolean invalid;
        Purchase_Order newPO = new Purchase_Order();
        Scanner newPoScanner = new Scanner(System.in);
        do {
            invalid = false;
            System.out.print("\nEnter product ID to order (Eg. P00001): ");

            newPO.setProduct_id(newPoScanner.nextLine());
            if (newPO.getProduct_id().matches("^P\\d{5}$")) {
            } else {
                invalid = true;
                System.out.println("\nInvalid product ID format. Try Again.");
                System.in.read();
            }
        } while (invalid);

        System.out.print("\nEnter quantity: ");
        newPO.setPurchase_quantity(newPoScanner.nextInt());
        newPoScanner.nextLine();

        do {
            invalid = false;
            System.out.print("\nEnter supplier ID to order from (Eg. SP00001): ");
            newPO.setSupplier_id(newPoScanner.nextLine());
            if (newPO.getSupplier_id().matches("^SP\\d{5}$")) {
            } else {
                invalid = true;
                System.out.println("\nInvalid supplier ID format. Try Again.");
                System.in.read();
            }
        } while (invalid);

        System.out.print("\n\n");
        System.out.println("Purchase Order Created. Awaiting response and payment calculations from Supplier.");
        return newPO;
    }


    public static void searchPurchaseOrder() throws IOException {
        // More akin to a Filtering function.
        Scanner sc = new Scanner(System.in);
        int filterOptions;
        do {
            System.out.println("Choose Filter Method:");
            System.out.println("1 > Supplier ID");
            System.out.println("2 > Product ID");
            System.out.println("3 > Order Date");
            System.out.println("4 > Return");
            filterOptions = sc.nextInt();

            switch (filterOptions) {
                case 1:
                    boolean invalid;
                    Scanner supplierSc = new Scanner(System.in);
                    String targetSupplier = "";
                    do {
                        invalid = false;
                        System.out.print("\nEnter supplier ID (Eg. SP00001): ");
                        targetSupplier = supplierSc.nextLine();
                        if (targetSupplier.matches("^SP\\d{5}$")) {

                        } else {
                            invalid = true;
                            System.out.println("\nInvalid supplier ID format. Try Again.");
                            System.in.read();
                        }
                    } while (invalid);

                    List<Purchase_Order> targetList;
                    try (SqlSession conn = Database.getInstance().openSession()) {
                        PurchaseOrderMapper poMapper = conn.getMapper(PurchaseOrderMapper.class);
                        targetList = poMapper.selectIDfortaget(targetSupplier);
                    }

                    System.out.printf("%-10s | %-11s | %-10s | %-7s | %-13s | %-11s\n\n", "PO Number", "Product ID", "Quantity", "Cost", "Order Date", "Status");
                    for (Purchase_Order po : targetList) {
                        System.out.printf("%-10s | %-11s | %-10d | %-7.2f | %-13s | %-11s\n",
                                po.getPo_number(),
                                po.getProduct_id(),
                                po.getPurchase_quantity(),
                                po.getOrder_price(),
                                po.getOrder_date(),
                                po.getStatus());
                    }
                    System.out.println("\n");
                    break;

                case 2:
                    Scanner productSc = new Scanner(System.in);
                    String targetProduct = "";
                    do {
                        invalid = false;
                        System.out.print("\nEnter product ID (Eg. P00001): ");
                        targetProduct = productSc.nextLine();
                        if (targetProduct.matches("^P\\d{5}$")) {
                        } else {
                            invalid = true;
                            System.out.println("\nInvalid product ID format. Try Again.");
                            System.in.read();
                        }
                    } while (invalid);


                    new Purchase_Order();
                    List<Purchase_Order> targetPO;
                    try (SqlSession conn = Database.getInstance().openSession()) {
                        PurchaseOrderMapper poMapper = conn.getMapper(PurchaseOrderMapper.class);
                        targetPO = poMapper.selectBYPOIDToList(targetProduct);
                    }
                    System.out.printf("%-10s | %-10s | %-7s | %-13s | %-11s\n\n", "PO Number", "Product ID", "Quantity", "Cost", "Order Date", "Status");
                    for (Purchase_Order po : targetPO) {
                        System.out.printf("%-10s | %-10d | %-7.2f | %-13s | %-11s\n",
                                po.getPo_number(),
                                po.getPurchase_quantity(),
                                po.getOrder_price(),
                                po.getOrder_date(),
                                po.getStatus());
                    }
                    break;


                case 3:
                    String startDate, endDate;

                    List<Purchase_Order> poList;
                    System.out.println("Enter start date.");
                    startDate = getDate();
                    System.out.println("\nEnter end date.");
                    endDate = getDate();

                    try (SqlSession conn = Database.getInstance().openSession()) {
                        PurchaseOrderMapper poMapper = conn.getMapper(PurchaseOrderMapper.class);
                        poList = poMapper.selectByDate(startDate, endDate);
                    }

                    if (poList == null || poList.isEmpty()) {
                        System.out.println("No purchase orders found for the given date range.");
                    } else {
                        System.out.printf("%-15s | %-10s | %-10s | %-12s | %-8s | %-13s | %-11s\n\n", "Order Date", "PO Number", "Product ID", "Quantity", "Cost", "Supplier ID", "Status");
                        for (Purchase_Order po : poList) {
                            System.out.printf("%-15s | %-10s | %-10s | %-12d | %-8.2f | %-13s | %-11s\n",
                                    po.getOrder_date(),
                                    po.getPo_number(),
                                    po.getProduct_id(),
                                    po.getPurchase_quantity(),
                                    po.getOrder_price(),
                                    po.getSupplier_id(),
                                    po.getStatus());
                        }
                    }


                    break;


                case 4:
                    break;

                default:
                    System.out.println("Invalid Option. Try Again.");
                    System.in.read();
                    break;

            }
        } while (filterOptions != 4);
    }

    private static String getDate() {
        int month, year, day = 0;
        String date;
        Scanner dateSc = new Scanner(System.in);

        do {
            System.out.print("Year (YYYY): ");
            year = dateSc.nextInt();

            if (year > 2024) {
                System.out.println("\nInvalid Year. Try Again.");
            }
        } while (year > 2024);

        do {
            System.out.print("Month (MM): ");
            month = dateSc.nextInt();
            if (month < 1 || month > 12) {
                System.out.println("\nInvalid Month. Please enter a month between 1 and 12.");
            }
        } while (month < 1 || month > 12);


        boolean validDay;
        do {
            validDay = true;
            System.out.print("Day (DD): ");
            day = dateSc.nextInt();
            if (month == 2) { // February
                if (isLeapYear(year)) {
                    if (day < 1 || day > 29) {
                        validDay = false;
                        System.out.println("\nInvalid Day for February in a Leap Year. Try Again.");
                    }
                } else {
                    if (day < 1 || day > 28) {
                        validDay = false;
                        System.out.println("\nInvalid Day for February. Try Again.");
                    }
                }
            } else if (month == 4 || month == 6 || month == 9 || month == 11) { // Months with 30 days
                if (day < 1 || day > 30) {
                    validDay = false;
                    System.out.println("\nInvalid Day. This month has 30 days. Try Again.");
                }
            } else { // Months with 31 days
                if (day < 1 || day > 31) {
                    validDay = false;
                    System.out.println("\nInvalid Day. This month has 31 days. Try Again.");
                }
            }
        } while (!validDay);

        date = String.format("%04d-%02d-%02d", year, month, day);
        return date;
    }


    private static boolean isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }


    public static void editPurchaseOrder() throws IOException {

        Purchase_Order targetPo;
        String targetNumber = "";
        int choice;
        boolean invalid;
        Scanner targetProductScanner = new Scanner(System.in);
        Scanner choiceScanner = new Scanner(System.in);

        do {
            invalid = false;
            System.out.print("\nEnter Target Purchase Order number (Eg. PO00001): ");
            targetNumber = targetProductScanner.nextLine();
            if (targetNumber.matches("^PO\\d{5}$")) {
            } else {
                invalid = true;
                System.out.println("\nInvalid product ID format. Try Again.");
                System.in.read();
            }
        } while (invalid);


        try (SqlSession conn = Database.getInstance().openSession()) {
            PurchaseOrderMapper poMapper = conn.getMapper(PurchaseOrderMapper.class);
            targetPo = poMapper.selectBYPOID(targetNumber);
        }
        if (targetPo == null) {
            System.out.println("Target Purchase Order Not Found!");
        } else if (!Objects.equals(targetPo.getStatus(), "Pending")) {
            System.out.print("\nUnable to modify specified Purchase Order. (PO already confirmed/completed!)\n");
            System.in.read();
        } else {
            do {
                System.out.println("Choose value to modify:");
                System.out.println("1 > Product ID");
                System.out.println("2 > Quantity");
                System.out.println("3 > Return");

                choice = choiceScanner.nextInt();
                choiceScanner.nextLine();
                switch (choice) {
                    case 1:
                        do {
                            invalid = false;
                            System.out.print("\nEnter new product ID (Eg. P00001): ");
                            targetPo.setProduct_id(choiceScanner.nextLine());
                            if (targetPo.getProduct_id().matches("^P\\d{5}$")) {
                            } else {
                                invalid = true;
                                System.out.println("\nInvalid product ID format. Try Again.");
                                System.in.read();
                            }
                        } while (invalid);
                        break;
                    case 2:
                        System.out.print("Enter new Quantity: ");
                        targetPo.setPurchase_quantity(choiceScanner.nextInt());
                        break;
                    case 3:
                        break;
                    default:
                        System.out.println("Invalid Input. Try Again.");
                        System.in.read();
                        break;
                }


                try (SqlSession conn = Database.getInstance().openSession()) {
                    PurchaseOrderMapper mapper = conn.getMapper(PurchaseOrderMapper.class);
                    mapper.updateModifyData(targetPo);
                    conn.commit();
                }
            } while (choice != 3);
            System.out.println("Purchase Order Successfully Modified!");
        }


    }


    public static void cancelPurchaseOrder() throws IOException {
        String confirmation;
        String targetNumber = "";
        Scanner targetPoScanner = new Scanner(System.in);
        Scanner confirmationScanner = new Scanner(System.in);
        boolean invalid;
        do {
            invalid = false;
            System.out.print("\nEnter Target Purchase Order (Eg. PO00001): ");
            targetNumber = targetPoScanner.nextLine();
            if (targetNumber.matches("^PO\\d{5}$")) {
            } else {
                invalid = true;
                System.out.println("\nInvalid product ID format. Try Again.");
                System.in.read();
            }
        } while (invalid);

        Purchase_Order targetPo;
        try (SqlSession conn = Database.getInstance().openSession()) {
            PurchaseOrderMapper purchaseOrderMapper = conn.getMapper(PurchaseOrderMapper.class);
            targetPo = purchaseOrderMapper.selectBYPOID(targetNumber);
        }

        if (!Objects.equals(targetPo.getStatus(), "Pending")) {
            System.out.print("\nUnable to Delete Specified Purchase Order. (PO already confirmed/completed!)\n");
            System.in.read();
        } else {

            System.out.printf("%-10s | %-11s | %-10d | %-5.2f | %-12s | %-11s\n",
                    targetPo.getPo_number(),
                    targetPo.getProduct_id(),
                    targetPo.getPurchase_quantity(),
                    targetPo.getOrder_price(),
                    targetPo.getSupplier_id(),
                    targetPo.getStatus());


            System.out.println("Are you sure you would like to cancel this Purchase Order?\n");
            System.out.print("Enter 1 to cancel, enter any other key to return > ");
            confirmation = confirmationScanner.nextLine();

            if (Objects.equals(confirmation, "1")) {
                try (SqlSession sqlSession = Database.getInstance().openSession()) {
                    PurchaseOrderMapper mapper = sqlSession.getMapper(PurchaseOrderMapper.class);
                    mapper.cancelPoByID(targetPo.getPo_number());
                    sqlSession.commit();
                }
                System.out.println("Purchase Order canceled.");
            } else ;
        }
    }

}
