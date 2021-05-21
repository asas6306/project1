package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.AuthDao;
import com.example.demo.dto.Auth;

@Service
public class AuthService {
	@Autowired
	AuthDao authd;
	
	public List<Auth> getAuths() {
		
		return authd.getAuths();
	}
}
