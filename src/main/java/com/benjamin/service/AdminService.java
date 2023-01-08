package com.benjamin.service;

import com.benjamin.pojo.Admin;

public interface AdminService {
    Admin login(String name, String pwd);
}
