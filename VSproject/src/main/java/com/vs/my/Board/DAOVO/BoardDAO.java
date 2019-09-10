package com.vs.my.Board.DAOVO;

import java.util.List;

import com.vs.my.User.DAOVO.UserVO;



public interface BoardDAO {


	public List<BoardVO> BoardAllData(int page);
	
	public void BoardInsertData(BoardVO vo);
	
	public BoardVO Content(BoardVO vo);
	
	public int BoardListCount();
	
	public List<BoardVO> UserBoard(BoardVO bv);
	
	public int UserBoardList(String u_id);
	
	public List<BoardVO> VSSBoard(int vss_seq); 
	
	public void BoardCnt(int b_seq);
	
	public void delCon(int b_seq);
	
	public int maxBoard();
	
	public List<BoardVO> VSSBoardAllData(BoardVO bv);
	
	public int VSSBoardListCount(BoardVO bv);
	
	
}
