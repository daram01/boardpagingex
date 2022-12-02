package model1.board;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect{
	public BoardDAO(ServletContext application) {
		super(application);
	}

	// 게시물 갯수를 세는 메서드.
	public int selectCount(Map<String,Object> map) {
		int totalCount = 0;
		
		String query = "select count(*) from board";
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " "
					+ " like '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(query); // 쿼리문 실행
			rs.next(); // 첫번째 행으로 이동
			totalCount = rs.getInt(1); // 첫번째 컬럼 값을 가져온다.
			
		} catch(Exception e) {
			System.out.println("게시물 수를 받아오던 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 게시물 목록을 가져오는 메서드.
	public List<BoardDTO> selectList(Map<String,Object> map) {
		List<BoardDTO> bbs = new ArrayList<>();
		
		String query = " select * from board ";
		if(map.get("searchWord") != null) {
			query += " where " + map.get("searchField") + " "
					+ " like '%" + map.get("searchWord") + "%' ";
		}
		query += " order by num desc ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}
			
		}catch(Exception e) {
			System.out.println("게시물 목록을 가져오던 중 예외 발생");
			e.printStackTrace();
		}
		
		
		return bbs;
	}
	
}  // main 끝                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     