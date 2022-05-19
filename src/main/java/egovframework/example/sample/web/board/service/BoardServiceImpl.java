package egovframework.example.sample.web.board.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.web.board.dto.BoardDTO;
import egovframework.example.sample.web.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	

	
	@Override
	public void boardList(Model model, String keyword, int num) {
		/*
		 *  페이징 관련 변수 세팅 
		 */
		System.out.println("num::" + num);
		  if(num == 0) {
	     		 num = 1;
	    	 }
		int pageNum = 5;
		int end = num * pageNum; //  2*5 = 10
		int start = end+1 - pageNum;   // 11 - 5 = 6
		
				if(keyword == null) {
					keyword = "";
				}				
				List<BoardDTO> boardList = mapper.boardList(start, end, keyword);								
			
				paging(start, keyword, model);
				
				model.addAttribute("boardList", boardList);			//게시물 
				model.addAttribute("keyword", keyword);			//겸색 조견 	
				model.addAttribute("cnt", num); //현재 페이지 
	}
	
	private void paging(int num, String keyword, Model model) {
		//추후 pagination 이용해보기 
		  
		int pageNum = 5  ;// 한 페이지에 나올 글 수 
		int totalPageNum = mapper.getCount(keyword); // 총 게시물 수    //  이게 null로 들여가셔 에려나옴 
				
		int totalEndPage = totalPageNum / pageNum;  // 마지막 페이지 
		if(totalPageNum % pageNum != 0) {  
			totalEndPage ++;
		}

		int pagingCount = (num-1) / pageNum; // (0 ~ 4 / 5 ~ 9)
		int beginPage = pagingCount * pageNum + 1 ;
		int endPage = beginPage + 5; // 10개로 한다면 여기 +5 해줘야한다
		
		
		model.addAttribute("totalPageNum", totalPageNum);
		model.addAttribute("startPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalEndPage", totalEndPage);
	}
	
	@Override
	public void writeView(String boardSeq, Model model) {
			BoardDTO dto = mapper.writeView(boardSeq);
			model.addAttribute("dto", dto);
	}
	
	@Override
	public void deleteList(List<String> boardSeq) {
		 mapper.deleteList(boardSeq);		
	}
	
	@Override
	public void updateContent(MultipartHttpServletRequest mul, HttpServletRequest request,
			HttpServletResponse response) {
		
		BoardDTO dto = fileProcess(mul);
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardText(mul.getParameter("boardText"));

		String updateDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		dto.setModDate(updateDate);
		dto.setBoardSeq(Integer.parseInt(mul.getParameter("boardSeq")));
				
		int result = mapper.updateContent(dto);
		System.out.println("result??" + result);
		
	}
	

	@Override
	public String deleteImgFile(String imgPath, String boardSeq, Model model) {
		File deleteOrigin = new File(IMAGE_REPO+"/"+imgPath);
		deleteOrigin.delete();
		mapper.deleteImgFile(boardSeq);
		BoardDTO dto = mapper.writeView(boardSeq);
		String returnPath = dto.getImgPath();
		return returnPath;
	}
	
	
	
	@Override
	public BoardDTO fileProcess(MultipartHttpServletRequest mul) {
		MultipartFile file = mul.getFile("imgPath");
		
		BoardDTO dto = new BoardDTO();

		if(file.getSize() != 0) {  // 파일을 션택했다면 
			SimpleDateFormat fo = new SimpleDateFormat("yyyyMMddHHmmss-") ;// 초단위로 져쟝 
			Calendar calendar = Calendar.getInstance();
			String fileName = fo.format(calendar.getTime()); // 져쟝 이름 형태 만들여주는 중
			fileName += file.getOriginalFilename();
			
			File saveFile = new File(IMAGE_REPO+"/"+fileName);
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			dto.setImgPath(fileName);

		}else {
			dto.setImgPath("");
		}
		System.out.println("succeess");
		return dto;
		
	}

	@Override
	public void addContent(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		
		BoardDTO dto = fileProcess(mul);
		
		dto.setBoardTitle(mul.getParameter("boardTitle"));
		dto.setBoardText(mul.getParameter("boardText"));

		String boardWriter = (String) session.getAttribute("userName");
		dto.setBoardWriter(boardWriter);
		
		String regDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		dto.setRegDate(regDate);
		
		int result = mapper.addContent(dto);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(result ==1) {
			out.print("<script>alert('게시물이 등록되었습니다.'); location.href='admin/main'; location.href=' "+path+"/boardList.do'</script>");
		}else {
			out.print("<script>alert('게시물 등록에 실패하였습니다.'); location.href='admin/main'; location.href=' "+path+"/boardList.do'</script>");
		}
		
		
	}




	



	

	

}
