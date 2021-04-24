package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdmMemberController {
	@RequestMapping("/adm/member/login")
	public String login() {
		
		return "adm/member/login";
	}
}
