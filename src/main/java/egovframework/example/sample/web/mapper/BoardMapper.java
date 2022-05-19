package egovframework.example.sample.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.example.sample.web.board.dto.BoardDTO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface BoardMapper {
	
	public List<BoardDTO> boardList(@Param("s") int start, @Param("e") int end, @Param("keyword") String keyword);
	public int addContent(BoardDTO dto);
	public BoardDTO writeView(String boardSeq);
	public void deleteList(List<String> boardSeq);
	public int getCount(String keyword);
	public int deleteImgFile(String boardSeq);
	public int updateContent(BoardDTO dto);
	
}
