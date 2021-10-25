package web.jsp10.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UploadDAO {

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
		
	}
	
	// 업로드 파일 정보 저장
	
	public void uploadImg(String writer, String imgName ) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn = getConnection();
			String sql = "insert into uploadTable values(?,?)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, imgName);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//이미지 가져오기
	
	public List getImg(String writer) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      //String imgName= null;
	      List imgs = null;
	      try {
	         conn = getConnection();
	         String sql = "select img from uploadTable where writer=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, writer);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	        	 imgs = new ArrayList();
	        	 do {
	        		 //String imgName = rs.getString("img"); 이걸 한번에 해준게 아래것
	        		 imgs.add(rs.getString("img")); // 컬럼명으로 결과에서 데이터 추출
	        		 
	        	 }while(rs.next());
	        	 
	         }
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	         if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
	      }
	      return imgs;
	   }

	
	
	
}
