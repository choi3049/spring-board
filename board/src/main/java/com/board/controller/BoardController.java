package com.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.board.domain.BoardVO;
import com.board.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService service;

 
	//게시물 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(Model model) throws Exception {
	 List<BoardVO> list = null;
	 list = service.list();
	 model.addAttribute("list", list);
	}
 
	//게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWirte() throws Exception {
 
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String posttWirte(BoardVO vo) throws Exception {
	  service.write(vo);
	  
	  return "redirect:/board/list";
	}
	
	// 게시물 조회
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno,Model model) throws Exception {
		
		BoardVO vo = service.view(bno);
		model.addAttribute("view",vo);
	}
	
	// 게시물 목록 + 페이징 추가 검색
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void getListPage(Model model, @RequestParam("num") int num,
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			   @RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
			  ) throws Exception {
	
	 // 게시물 총 갯수
	 int count = service.count();
	 	 
	 //검색 게시물 총 갯수
	 count = service.searchCount(searchType, keyword);
	  
	 // 한 페이지에 출력할 게시물 갯수
	 int postNum = 5;
	  
	 // 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
	 int pageNum = (int)Math.ceil((double)count/postNum);
	  
	 // 출력할 게시물
	 int displayPost = (num - 1) * postNum;
	 
	 // 한번에 표시할 페이징 번호의 갯수
	 int pageNum_cnt = 10;

	 //	1페이지
	 int firstPageNum =1;
	 
	 // 표시되는 페이지 번호 중 마지막 번호
	 int endPageNum = (int)(Math.ceil((double)num / (double)pageNum_cnt) * pageNum_cnt);

	 // 표시되는 페이지 번호 중 첫번째 번호
	 int startPageNum = endPageNum - (pageNum_cnt - 1);
	 
	// 마지막 번호 재계산
	 int endPageNum_tmp = pageNum;
	  
	 if(endPageNum > endPageNum_tmp) {
	  endPageNum = endPageNum_tmp;
	 }
	 
	 boolean prev = num == 1 ? false : true;
	 boolean next = num == endPageNum_tmp ? false : true;
	 

	 
	 List<BoardVO> list = null; 
	 //list = service.listPage(displayPost, postNum);
	 list = service.listPage(displayPost, postNum, searchType, keyword);
	 model.addAttribute("list", list);   
	 model.addAttribute("pageNum", pageNum);
	 
	 model.addAttribute("searchType", searchType);
	 model.addAttribute("keyword", keyword);
	 
	 
	//페이징 수
	 model.addAttribute("startPageNum", startPageNum);
	 model.addAttribute("endPageNum", endPageNum);

	 
	// 시작 및 끝 번호
	 model.addAttribute("firstPageNum", firstPageNum);
	 model.addAttribute("endPageNum_tmp", endPageNum_tmp);

	 // 이전 및 다음 
	 model.addAttribute("prev", prev);
	 model.addAttribute("next", next);
	 
	// 현재 페이지
	 model.addAttribute("select", num);
	
	}
}	
