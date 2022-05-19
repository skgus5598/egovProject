package egovframework.example.sample.web.board.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.web.board.dto.BoardDTO;

public interface FileService {
	
	public static final String IMAGE_REPO = "/Users/raina/Desktop/egovProejct/egovProject/src/main/webapp/boardImg";
	public BoardDTO fileProcess(MultipartHttpServletRequest mul);
}
