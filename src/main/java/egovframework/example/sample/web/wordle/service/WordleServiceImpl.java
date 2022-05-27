package egovframework.example.sample.web.wordle.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import egovframework.example.sample.web.mapper.WordleMapper;
import egovframework.example.sample.web.wordle.dto.WordleDTO;

@Service
public class WordleServiceImpl implements WordleService {
	
	@Autowired
	private WordleMapper mapper;

	@Override
	public void getRandomWord(Model model) {
		WordleDTO dto = mapper.getWord();
		model.addAttribute("originWord", dto.getWord());
	}

}
