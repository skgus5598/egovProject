package egovframework.example.sample.web.wordle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.example.sample.web.wordle.service.WordleService;

@Controller
public class CustomEtcController {
	
	@Autowired
	private WordleService ws;

	@GetMapping("wordle.do")
	public String wordlePage(Model model) {
		ws.getRandomWord(model);
		return "wordle/wordle";
	}
	
}
