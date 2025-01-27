package com.example.library.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {
    public boolean isValidAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session != null && session.getAttribute("admin") != null;
    }

    public boolean isValidStudent(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session != null && session.getAttribute("student") != null;
    }
}
