package egovframework.example.sample.web.admin.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.web.admin.dto.AdminDTO;
import egovframework.example.sample.web.admin.service.AdminService;

@Controller
public class CustomEduController {
	
	@Autowired
	private  AdminService adminService;

	
	
	@RequestMapping("/main.do")
	public String mainPage() {
		return "admin/main";
	}
	
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "admin/loginForm";
	}
	
	@GetMapping("forgotPassword.do")
	public String forgotPwd() {
		return "admin/forgotPassword";
	}
	
	@RequestMapping("registerForm.do")
	public String registerForm() {
		return "admin/registerForm";
	}
	
	@RequestMapping("forgotPw.do")
	public String forgotPassword() {
		return "admin/forgotPassword";
	}
	
	
	
	@PostMapping("admin/loginCheck.do")  // required =false로 해야  null값도 에러 없이 받아옴 
	public String loginCheck(@RequestParam String userEmail , @RequestParam String userPwd, 
												@RequestParam(value="autoLogin", required = false )String autoLogin ,HttpServletRequest request,
												HttpServletResponse response) {
		int result = adminService.loginCheck(userEmail, userPwd,  autoLogin, request, response);
		if(result == 1) {
			return "redirect:/main.do";
		}else {
			return "redirect:/loginForm.do";
		}
	}
	
	@RequestMapping("admin/logout.do")
	public String logout(HttpSession session, HttpServletResponse response,
										@CookieValue(value="loginCookie", required=false) Cookie loginCookie) {
		session.removeAttribute("userName");  // 세션 종료 
				
		if(loginCookie != null) {  // 자동로그인 체크한 user만 
			loginCookie.setMaxAge(0); // 쿠키 만료 
			loginCookie.setPath("/");
			response.addCookie(loginCookie);
			

		}
		
		return "redirect:/main.do";
	}
	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
