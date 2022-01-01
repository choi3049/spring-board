package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
 
	@Override
	public List list() throws Exception {

		return dao.list();
	}

	//게시물 총 갯수
	@Override
	public int count() throws Exception {
		return dao.count();
	}

	//게시물 목록 + 페이징
	@Override
	public List listPage(int displayPost, int postNum) throws Exception {
		return dao.listPage(displayPost, postNum);
	}

	@Override
	public void write(BoardVO vo) throws Exception {
		dao.write(vo);		
	}
 
}