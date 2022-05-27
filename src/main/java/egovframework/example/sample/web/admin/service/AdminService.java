package egovframework.example.sample.web.admin.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import egovframework.example.sample.web.admin.dto.AdminDTO;

public interface AdminService {
	
	public void registerAccount(AdminDTO dto, HttpServletResponse response, HttpServletRequest request);  // 회원가입
	public  ArrayList<AdminDTO> memberAllList();  // 멤버 전체 리스트
	public int loginCheck(String userEmail, String userPwd, String autoLogin, HttpServletRequest request, HttpServletResponse response);  // 로그인 체크 
	public String userNickCheck(String userNick); // 닉네임 중복 체크 
	public String userEmailCheck(String userEmail); // 이메일 중복 체크 
	public String forgotPwdCheck(String userEmail, String userPhone); // 비밀번호 임시발급 
	
}
