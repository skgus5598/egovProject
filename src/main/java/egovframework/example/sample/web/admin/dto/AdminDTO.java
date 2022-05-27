package egovframework.example.sample.web.admin.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;


public class AdminDTO {
	
	private int userSeq;
	private String userName;
	private String userNick;
	private String userEmail;
	private String userPwd;
	private String userBirth;
	private String userPhone;
	private String userAddr;
	private String userAuth;  //  관리자 1  ,일반 2
	private String delYn;    // 유저 삭제여부 
	private String regDate;
	private String modDate;
	
	private String userPwdCheck;
	private String autoLogin; // 자동로그인 체크여부 
	
	
	public String getUserPwdCheck() {
		return userPwdCheck;
	}
	public void setUserPwdCheck(String userPwdCheck) {
		this.userPwdCheck = userPwdCheck;
	}
	public int getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public String getUserAuth() {
		return userAuth;
	}
	public void setUserAuth(String userAuth) {
		this.userAuth = userAuth;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;

	}	
	
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	@Override
	public String toString() {
		return "[userName=" + userName + ", userNick=" + userNick + ", userEmail="
				+ userEmail + ", userPhone=" + userPhone
				+ ", userAddr=" + userAddr + ", userAuth=" + userAuth + ", delYn=" + delYn + "]";
	}

	
	
}
