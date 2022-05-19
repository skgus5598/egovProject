package egovframework.example.sample.web.admin.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.example.sample.web.admin.dto.AdminDTO;
import egovframework.example.sample.web.mapper.AdminMapper;

@Service
public class AdminServiceImpl  implements AdminService{
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
		
	@Override
	public void registerAccount(AdminDTO dto, HttpServletResponse response, HttpServletRequest request) {
		
		String path = request.getContextPath();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String regDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		dto.setRegDate(regDate);   // 날짜 형식 
		
		String securePw=encoder.encode(dto.getUserPwd());   // 비밀번호 암호화 
		System.out.println("암호화된 비번 : " + securePw);
		dto.setUserPwd(securePw);
		
		
		
		int result = adminMapper.registerAdmin(dto);
		System.out.println("result : " + result);
		
		if(result == 1) {
			System.out.println("success");
			out.print("<script>alert('회원가입 성공! 로그인을 해주세요'); location.href=' "+path+"/loginForm.do';</script>");
		}else {
			System.out.println("failed");
			out.print("<script>alert('회원가입 실패!'); location.href='admin/main'; location.href=' "+path+"/main.do'</script>");
		}
		
	}

	@Override
	public ArrayList<AdminDTO> memberAllList(Model model) {	
		ArrayList<AdminDTO>  memList = adminMapper.memberList();		
		System.out.println("memberLis로 들어");
		return memList;
	}

	@Override
	public int loginCheck(String userEmail, String userPwd, String autoLogin, HttpServletRequest request, HttpServletResponse response) {
		int result = 0 ;
		
			AdminDTO dto = adminMapper.loginCheck(userEmail);
			if(dto != null) { 					// 암호화된 비번 or 암호화 만들기 이전에 저장된 비번 
				if(encoder.matches(userPwd, dto.getUserPwd()) || userPwd.equals(dto.getUserPwd()) ) {  // 비밀번호 일치  여부 
					HttpSession session = request.getSession();
					session.setAttribute("userName", dto.getUserName());
					result = 1;  // 로그인 성공  
					
					if(autoLogin != null) {  // 자동로그인 설정 (쿠키설정)
						System.out.println("쿠키만들기~~");
						autoLogin(session, response);						
					}					
				}else {
					System.out.println("비번 틀림 ");
					 // 비밀번호 불일치 
				}
			}else {
				System.out.println("없는 이메일 ");			
			}			
		return result;		
	}

	private void autoLogin(HttpSession session, HttpServletResponse response) {
		System.out.println("session.getAttribute??" + session.getAttribute("userName"));
//		Cookie loginCookie = new Cookie("loginCookie" , session.getId());
		Cookie loginCookie = new Cookie("loginCookie" , (String) session.getAttribute("userName"));
		loginCookie.setPath("/");  // 최상위, 모든 경로에서 다 사용하겠다 
		loginCookie.setMaxAge(60*60*24*7); 
		response.addCookie(loginCookie);
		
	}
	
	@Override
	public String userNickCheck(String userNick) {		
		AdminDTO dto = adminMapper.userNickCheck(userNick);
			if(dto != null) { // 닉네임 중복 
				return "{\"result\" : 0}";	
			}else {
				if(userNick.length() <=30) {  // 30글자 이하인지 체크 
					if(userNick.matches("[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\\s]*$")) { //특수문자 포함여부 체크 
						return "{\"result\" : 1}";			
					}else {
						return "{\"result\" : 3}";			
					}
				}else {
					return "{\"result\" : 2}";			 //글자 수 초과 
				}	
			}
		}
	
	@Override
	public String userEmailCheck(String userEmail) {		
		AdminDTO dto = adminMapper.userEmailCheck(userEmail);
		if(dto != null) { // 이메일 중복 
			return "{\"result\" : 0}";	
		}else {
			if(userEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {				// 이메일 형식 체크 
				return "{\"result\" : 1}";  // ok 
			}else {
				return "{\"result\" : 2}";  // 형식 안맞음 
			}
		}	
	}

	@Override
	public String forgotPwdCheck(String userEmail, String userPhone) {
		AdminDTO dto = adminMapper.forgotPwdCheck(userEmail);
		System.out.println("okokok ");
		if(dto != null) {
			if(userPhone.equals(dto.getUserPhone())) { 
				System.out.println("111");
				return "{\"result\" : 1}";  ///  임시비번 발급 - js로 
			}else { 
				System.out.println("000");
				return "{\"result\" : 0}";  // 폰번호 안맞음 
			}
		}else {
			System.out.println("222");
			return "{\"result\" : 2}";  // 없는 이메일 
		}
		
		
	}


	


}
