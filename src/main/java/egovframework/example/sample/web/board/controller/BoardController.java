package egovframework.example.sample.web.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.DELETE;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.web.board.dto.BoardDTO;
import egovframework.example.sample.web.board.service.BoardService;
import egovframework.example.sample.web.board.service.FileService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bs;
	
	@RequestMapping("/boardList.do")
	public String boardList(Model model,
											@RequestParam(required = false) String keyword,
											@RequestParam(required = false, defaultValue = "1") int num) {
		bs.boardList(model, keyword, num);
		return "board/board";
	}
	
	@GetMapping("/board/writeForm.do")
	public String writeForm() {
		return "board/boardInsert";
	}
	
	@PostMapping("/board/addContent.do")
	public void addContent(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) {
		bs.addContent(mul, request, response);
	}
	
	@GetMapping("/writeView.do")
	public String writeView(@RequestParam String boardSeq, Model model) {
		bs.writeView(boardSeq, model);
		return "board/boardDetail";
	}
	
	@PostMapping("board/boardModify.do")
	public String modifyBoard(BoardDTO dto, Model model) {
		model.addAttribute("dto", dto);
		return "board/boardDetailModi";
	}
	
	@PostMapping("board/updateContent.do")
	public String  updateContent(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) {
		bs.updateContent(mul, request, response);
		return "redirect:/writeView.do?boardSeq="+mul.getParameter("boardSeq");
	}
	
	@PostMapping(value="/board/deleteFile.do")
	@ResponseBody
	public void deleteImgFile(@RequestParam("boardSeq") String boardSeq, @RequestParam("imgPath") String imgPath ,Model model ) {
		System.out.println("imgpath" + boardSeq);
		System.out.println("boardSeq" + imgPath);
		bs.deleteImgFile(imgPath, boardSeq, model);
	}
	
	
	
	
	@PostMapping(value="/board/deleteList.do" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public void deleteList(@RequestParam("arr[]") List<String> boardSeq) {		
		bs.deleteList(boardSeq);
	}
	
	@GetMapping("download.do")
	public void download(@RequestParam("file")String fileName, HttpServletResponse response) throws Exception{
		response.addHeader("Content-disposition", "attachement; fileName=" +fileName);
		File file = new File(FileService.IMAGE_REPO+"/" + fileName);
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis,  response.getOutputStream());
		fis.close();
	}
	

}
