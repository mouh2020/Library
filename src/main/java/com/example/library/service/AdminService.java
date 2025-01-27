package com.example.library.service;

import com.example.library.dao.AdminDAO;
import com.example.library.dao.BookDAO;
import com.example.library.models.Admin;

public class AdminService {
    private AdminDAO adminDAO = new AdminDAO();
    public Admin getAdminByEmail(String email) {
        return  this.adminDAO.getAdminByEmail(email);
    }
}
