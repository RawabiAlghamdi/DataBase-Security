package com.hotelmanagement;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;

public class DbConnection {

    private final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private final String DB_URL = "jdbc:mysql://localhost:3306/hotelbooking?allowPublicKeyRetrieval=true&useSSL=false";
    private final String DB_USER = "EMCS651";
    private final String DB_PASS = "Pwd@1234";

    private String query;
    private Connection con;
    private PreparedStatement pst;
    private ResultSet rs;

    private boolean set;

    public DbConnection() {
        this.con = this.getDbConnection();
    }

    //method to connect database
    public final Connection getDbConnection() {
        con = null;
        try {
            if (null == con) {
                Class.forName(DB_DRIVER);
                con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            }
            System.out.println("Database Has been connected");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return con;
    }

    //generate hash pssword using salt
    public static String generateHash(String pass) {
        String hashPass = null;
        String algorithm = "SHA-256";
        try {
            //message digest for the hash algorithm
            MessageDigest md = MessageDigest.getInstance(algorithm);
            //update the mesage digest with the password
            md.update(pass.getBytes());
            //get the hash byet's
            byte[] byets = md.digest();
            //convert the byets to hexadecimal
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < byets.length; i++) {
                sb.append(Integer.toString((byets[i] & 0xff) + 0x100, 16).substring(1));
            }
            hashPass = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
        return hashPass;
    }

    //check password strength
    public boolean checkPassword(String password) {
        boolean check = false;
        int upChars = 0, lowChars = 0;
        int special = 0, digits = 0;
        if (password.length() >= 8) {
            for (int i = 0; i < password.length(); i++) {
                char ch = password.charAt(i);
                if (Character.isUpperCase(ch)) {
                    upChars = 1;
                } else if (Character.isLowerCase(ch)) {
                    lowChars = 1;
                } else if (Character.isDigit(ch)) {
                    digits = 1;
                } else {
                    special = 1;
                }
            }
            if (upChars == 1 && lowChars == 1 && digits == 1 && special == 1) {
                check = true;
            }
        }
        return check;
    }

    //create pdf invoice
    public void createInvoice(String path, int guestId, int roomNum, Date bookingDate) {
        
        try {
            rs = bookingInvoiceData(guestId, roomNum, bookingDate);
            while(rs.next()){
                //Creating the PDF
            PDDocument MyPDF = new PDDocument();
            //Creating a Blank Page
            PDPage newpage = new PDPage();
            //Adding the blank page to our PDF
            MyPDF.addPage(newpage);
            PDFont font = PDType0Font.load(MyPDF, new File(path + "/" + "Roboto-Regular.ttf"));
            //Getting the required Page
            //0 index for the first page
            PDPage MyPage = MyPDF.getPage(0);
            //Initializing the content stream
                PDPageContentStream cs = new PDPageContentStream(MyPDF, MyPage);
                cs.beginText();
                cs.setFont(font, 25);
                cs.newLineAtOffset(270, 750);
                //String variable to store the text
                String InvoiceTitle = "ABC Hotel";
                //Writing the text to the PDF Fie
                cs.showText(InvoiceTitle);
                //Ending the text
                cs.endText();
                //invoice title
                //Writing the Invoice title
                cs.beginText();
                cs.setFont(font, 15);
                cs.newLineAtOffset(270, 720);
                cs.showText("Booking Invoice");
                cs.endText();
                //booking message
                String bMessage = "Hi "+rs.getString("FName")+" thanks to use ABC Hotel services. We have confirmed your room bookings.Please check the details below";
                
                cs.beginText();
                cs.setFont(font, 11);
                cs.newLineAtOffset(20, 690);
                cs.showText(bMessage);
                cs.endText();

                //writing the customer details
                cs.beginText();
                cs.setFont(font, 11);
                cs.setLeading(20f);
                cs.newLineAtOffset(60, 670);
                cs.showText("Customer Name: ");
                cs.newLine();
                cs.showText("Phone Number: ");
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.setLeading(20f);
                cs.newLineAtOffset(150, 670);
                cs.showText(rs.getString("FName")+" "+rs.getString("LName"));
                cs.newLine();
                cs.showText(rs.getString("PhoneNo"));
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.setLeading(20f);
                cs.newLineAtOffset(350, 670);
                cs.showText("Arrival Date: ");
                cs.newLine();
                cs.showText("Departure Date: ");
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.setLeading(20f);
                cs.newLineAtOffset(450, 670);
                cs.showText(rs.getDate("ArrivalDate").toString());
                cs.newLine();
                cs.showText(rs.getDate("DepartureDate").toString());
                cs.endText();

                //booking table info
                cs.beginText();
                cs.setFont(font, 11);
                cs.newLineAtOffset(60, 610);
                cs.showText("Room Number");
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.newLineAtOffset(180, 610);
                cs.showText("Adults");
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.newLineAtOffset(300, 610);
                cs.showText("Children");
                cs.endText();

                cs.beginText();
                cs.setFont(font, 11);
                cs.newLineAtOffset(420, 610);
                cs.showText("Price");
                cs.endText();
                
                //show table data
               
                cs.beginText();
                cs.setFont(font, 12);
                cs.setLeading(20f);
                cs.newLineAtOffset(60, 590);
                cs.showText(String.valueOf(rs.getInt("RoomNo")));
                cs.endText();
                
                
                //show adults
                cs.beginText();
                cs.setFont(font, 12);
                cs.setLeading(20f);
                cs.newLineAtOffset(180, 590);
                cs.showText(String.valueOf(rs.getInt("NumAdults")));
                cs.endText();
                
                //show children
                cs.beginText();
                cs.setFont(font, 12);
                cs.setLeading(20f);
                cs.newLineAtOffset(300, 590);
                cs.showText(String.valueOf(rs.getInt("NumChildreen")));
                cs.endText();
                
                //show price cs.beginText();
                cs.beginText();
                cs.setFont(font, 12);
                cs.setLeading(20f);
                cs.newLineAtOffset(420, 590);
                cs.showText(String.valueOf(rs.getInt("RoomPrice")));
                cs.endText();
                
                //Closing the content stream
                cs.close();
            
                String fileName = bookingDate.toString()+"-"+ String.valueOf(rs.getInt("RoomNo"))+"-"+String.valueOf(rs.getInt("GuestID"))+".pdf";
                //Saving the PDF
                MyPDF.save(path + "/"+fileName);
            }
            
        } catch (IOException | SQLException ex) {
            Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
/*
    //send email method
    public boolean sendEmail(int guestId, int roomNum) {
        boolean test = false;

        String gFName = null, gLName = null, gEmail = null;
        String fromEmail = "user@gmail.com";
        String password = "password";

        try {

            //fetch user data
            rs = getGuestById(guestId);
            while (rs.next()) {
                gFName = rs.getString("FName");
                gLName = rs.getString("LName");
                gEmail = rs.getString("Email");
            }

            System.out.print(gFName + " " + gLName + " " + gEmail);
            Properties pr = new Properties();
            pr.put("mail.smtp.host", "smtp.gmail.com");
            pr.put("mail.smtp.port", "587");
            pr.put("mail.smtp.auth", "true");
            pr.put("mail.smtp.starttls.enable", "true");

            //get session
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);

            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(gEmail));

            mess.setSubject("Hotel Booking Confirmation");

            mess.setText("Hi, " + gFName + " " + gLName + " thank you much to use our service. Your booking has been confirmed. Your booking room number is " + roomNum);
            Transport.send(mess);

            test = true;

        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (SQLException ex) {
            Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

        return test;
    }
*/
    //validate username
    public boolean validateUsername(String username){
        boolean check = false;
        Pattern pattern = Pattern.compile("[^a-zA-Z]");
        if(username != null){
            Matcher matcher = pattern.matcher(username);
            if(!matcher.find()){
                check = true;
            }
        }
        
        return check;
    }
    
    //authentication
    public ResultSet loginEmployee(String username, String password) {
        rs = null;
        try {
            query = "select EmployeeID, RoleID, FName, LName from employees where Username=? and Password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);

            rs = pst.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //Room CRUD Operations 
    //get all rooms data
    public ResultSet getAllRooms() {
        rs = null;

        try {
            query = "select * from rooms";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;

    }
    //get availabe rooms
    public ResultSet getAvailableRooms() {
        rs = null;

        try {
            query = "select * from rooms where Occupency=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, "Available");
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;

    }

    //get single room information
    public ResultSet getSingleRoom(int roomNo) {
        rs = null;

        try {
            query = "select * from rooms where RoomNo=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roomNo);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //room insert method
    public boolean insertRoom(int roomNo, String roomType, int roomPrice, String roomDesc, String occupacy) {
        set = false;
        try {
            query = "insert into rooms(RoomNo,RoomType, RoomPrice, RoomDesc, Occupency ) values(?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roomNo);
            pst.setString(2, roomType);
            pst.setInt(3, roomPrice);
            pst.setString(4, roomDesc);
            pst.setString(5, occupacy);

            int ex = pst.executeUpdate();
            if (ex > 0) {
                set = true;
            }
            pst.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    //room update method
    public boolean updateRoomInfo(int roomNo, String roomType, int roomPrice, String roomDesc, String occupacy) {
        set = false;
        try {
            query = "update rooms set RoomType=?, RoomPrice=?, RoomDesc=?, Occupency=? where RoomNo=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, roomType);
            pst.setInt(2, roomPrice);
            pst.setString(3, roomDesc);
            pst.setString(4, occupacy);
            pst.setInt(5, roomNo);
            int res = pst.executeUpdate();
            if (res > 0) {
                set = true;
            }
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    //change room status
    public boolean changeRoomStatus(int roomId, String status) {
        set = false;

        try {
            query = "update rooms set Occupency=? where RoomNo=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, status);
            pst.setInt(2, roomId);
            int res = pst.executeUpdate();
            if (res > 0) {
                set = true;
            }
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return set;
    }

    //delete room by room number
    public void delteRoom(int roomNo) {
        try {
            query = "delete from rooms where RoomNo=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roomNo);
            pst.execute();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Employee crud process
    //get all employee list
    public ResultSet getAllEmployee() {
        rs = null;

        try {
            query = "select * from employees";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //get employee by id
    public ResultSet getEmployeeById(int empId) {
        rs = null;

        try {
            query = "select FName, LName, RoleID, EmployeeID from employees where EmployeeID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, empId);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //add employee method
    public boolean addEmployee(int empId, int roleId, String fName, String lName, String username, String password) {
        set = false;

        try {
            query = "insert into employees(EmployeeID, RoleID, FName, LName, Username, Password) values(?,?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, empId);
            pst.setInt(2, roleId);
            pst.setString(3, fName);
            pst.setString(4, lName);
            pst.setString(5, username);
            pst.setString(6, password);
            int i = pst.executeUpdate();
            if (i > 0) {
                set = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return set;
    }

    //employee update method
    public boolean updateEmployeeInfo(int empId, int roleId, String fName, String lName) {
        set = false;
        try {
            query = "update employees set roleID=?, FName=?, LName=? where EmployeeID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roleId);
            pst.setString(2, fName);
            pst.setString(3, lName);
            pst.setInt(4, empId);
            pst.executeUpdate();
            set = true;
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    //delete room by room number
    public void deleteEmployee(int empId) {
        try {
            query = "delete from employees where EmployeeID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, empId);
            pst.execute();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Guest crud process
    //get all guest list
    public ResultSet getAllGuest() {
        rs = null;

        try {
            query = "select * from guest";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //get guest by id
    public ResultSet getGuestById(int guestId) {
        rs = null;

        try {
            query = "select * from guest where GuestID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, guestId);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }

    //add employee method
    public boolean addGuest(String fName, String lName, String gender, String phone, String email) {
        set = false;

        try {
            query = "insert into guest(FName, LName, Gender, PhoneNo, Email) values(?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            
            pst.setString(1, fName);
            pst.setString(2, lName);
            pst.setString(3, gender);
            pst.setString(4, phone);
            pst.setString(5, email);
            int i = pst.executeUpdate();
            if (i > 0) {
                set = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return set;
    }

    //employee update method
    public boolean updateGuestInfo(int guestId, String fName, String lName, String gender, String phone, String email) {
        set = false;
        try {
            query = "update guest set FName=?, LName=?, Gender=?, PhoneNo=?, Email=? where GuestID=?";
            pst = this.con.prepareStatement(query);

            pst.setString(1, fName);
            pst.setString(2, lName);
            pst.setString(3, gender);
            pst.setString(4, phone);
            pst.setString(5, email);
            pst.setInt(6, guestId);

            pst.executeUpdate();
            set = true;
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    //delete room by room number
    public void deleteGuest(int guestId) {
        try {
            query = "delete from guest where GuestID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, guestId);
            pst.execute();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //performing bookings crud operation
    public ResultSet getBookingsById(int bookingId) {
        rs = null;
        try {
            query = "select * from booking where BookingID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, bookingId);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //performing bookings crud operation
    public ResultSet getBookings() {
        rs = null;
        try {
            query = "select * from booking";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //do new booking
    public boolean newBooking(int roomNum, int guestId, Date bookingDate, Date arrivalDate, Date departureDate, int numAdults, int numChildren) {
        set = false;
        try {
            query = "insert into booking(RoomNo, GuestID, BookingDate, ArrivalDate, DepartureDate, NumAdults, NumChildreen) values(?,?,?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roomNum);
            pst.setInt(2, guestId);
            pst.setDate(3, bookingDate);
            pst.setDate(4, arrivalDate);
            pst.setDate(5, departureDate);
            pst.setInt(6, numAdults);
            pst.setInt(7, numChildren);
            int i = pst.executeUpdate();
            if (i > 0) {
                set = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return set;
    }

    //update the booking informations
    public boolean updateBooking(int bookingId, int guestId, Date arrivalDate, Date departureDate, int numAdults, int numChildren) {
        set = false;
        try {
            query = "update booking set GuestID=?, ArrivalDate=?, DepartureDate=?, NumAdults=?, NumChildreen=? where BookingID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, guestId);
            pst.setDate(2, arrivalDate);
            pst.setDate(3, departureDate);
            pst.setInt(4, numAdults);
            pst.setInt(5, numChildren);
            pst.setInt(6, bookingId);
            int i = pst.executeUpdate();
            if (i > 0) {
                set = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return set;
    }

    //cancel the booking
    public void cancelBooking(int bookigId) {
        try {
            query = "delete from booking where BookingID=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, bookigId);
            pst.execute();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    //get bookings data for invoice
    public ResultSet bookingInvoiceData(int uid, int roomNum, Date bookingDate){
        rs = null;
        try{
            query = "SELECT booking.*, guest.FName, guest.LName, guest.PhoneNo, rooms.RoomPrice FROM booking\n" +
"inner join guest on booking.GuestID = guest.GuestID \n" +
"inner join rooms on booking.RoomNo = rooms.RoomNo\n" +
"where booking.RoomNo=? and booking.GuestID=? and booking.BookingDate=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, roomNum);
            pst.setInt(2, uid);
            pst.setDate(3, bookingDate);
            rs = pst.executeQuery();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rs;
    }
}
