package egovframework.example.sample.web.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.web.admin.dto.AdminDTO;
import egovframework.example.sample.web.admin.service.AdminService;

@Controller
public class CustomUserController {
	
	@Autowired
	private  AdminService adminService;
	
	
	@PostMapping("admin/registerAcc.do")
	public void registerAccount(AdminDTO dto, HttpServletResponse response, HttpServletRequest request) throws Exception {
		adminService.registerAccount(dto, response, request);
	}
	
	@RequestMapping("memberListPage.do")
	public String memberListPage() {
		return "admin/memberList";
	}
	
	@GetMapping(value = "memberList.do",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public ArrayList<AdminDTO> memberList(HttpServletResponse response, HttpServletRequest request) {
		ArrayList<AdminDTO> memList =adminService.memberAllList();
		System.out.println("hhere??list?" + memList.toString());
		return memList;

	}
	
	@GetMapping(value = "userNickCheck.do",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String userNickCheck(@RequestParam String userNick) {
		return adminService.userNickCheck(userNick);
	}
	
	@GetMapping(value = "userEmailCheck.do",  produces = "application/json;charset=utf-8")
	@ResponseBody
	public String userEmailCheck(@RequestParam String userEmail) {
		return adminService.userEmailCheck(userEmail);
	}
	
	@PostMapping(value="forgotPwCheck.do", produces="application/json;charset=utf-8")
	@ResponseBody
	public String forgotPwd(@RequestParam String userEmail, @RequestParam String userPhone) {
		return adminService.forgotPwdCheck(userEmail, userPhone);
	}
	
	
	
	

}
	
