package egovframework.example.sample.web.board.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService extends FileService {
	
	public void boardList(Model model, String keyword, int num);  // 게시판 목록 가져오기 
	public void addContent(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) ; // 게시글 등록하기 
	public void writeView(String boardSeq, Model model);
	public void deleteList(List<String> boardSeq); // 체크리스트 삭제하기(update)
	public String deleteImgFile(String imgPath, String boardSeq, Model model); // 이미지 파일 삭제 
	public void updateContent(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response);
	
}
