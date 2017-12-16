package com.localeplanet.util;

import java.io.*;
import java.sql.*;
import java.util.*;

/**
 * various debugging utilities
 *
 * @author Andrew Marcuse
 * @version 2003.12.04
 */
public class DebugUtil
{
    public static void toString(PrintWriter out, Throwable t)
    {
        if (t == null)
        {
            out.println("(no exception)");
            return;
        }
        out.print("Message: ");
        out.println(t.getMessage());
        out.print("Class:   ");
        out.println(t.getClass().getName());
        out.print("String:  ");
        out.println(t.toString());
        
        if (t instanceof SQLException)
        {
            SQLException sqlex = (SQLException)t;
            out.print("SQL State :");
            out.println(sqlex.getSQLState());
            out.print("SQL code: ");
            out.println(sqlex.getErrorCode());
        }
        out.println("Stack: ");
        t.printStackTrace(out);
        
        Throwable cause = t.getCause();
        if (cause != null)
        {
            toString(out, cause);
        }
        out.println();
    }

    public static String toString(Throwable t)
    {
        StringWriter sw = new StringWriter();
        PrintWriter out = new PrintWriter(sw);

        toString(out, t);
        out.flush();

        return(sw.toString());
    }
}
