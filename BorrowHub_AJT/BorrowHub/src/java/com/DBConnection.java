package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("org.apache.derby.client.ClientAutoloadedDriver");

            con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/BorrrowHub",
                "het",
                "het"
            );

            System.out.println("Database Connected Successfully!");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();   // ✅ VERY IMPORTANT
        }

        return con;
    }
}