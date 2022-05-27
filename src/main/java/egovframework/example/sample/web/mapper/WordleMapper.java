package egovframework.example.sample.web.mapper;

import egovframework.example.sample.web.wordle.dto.WordleDTO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface WordleMapper {

	public WordleDTO getWord();
	

}
