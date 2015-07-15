package com.java.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.board.dto.BoardDto;
import com.java.coupon.dto.CouponDto;
import com.java.member.dto.MemberDto;
import com.java.point.dto.PointDto;

@Component
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * @name:login
	 * @date:2015. 6. 23.
	 * @author:김정훈
	 * @description:id와 password가 일치하는 member_id를 DB에서 가져옴
	 */
	@Override
	public String login(String id, String password) {
		// TODO Auto-generated method stub
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("id", id);
		hMap.put("password", password);
		return sqlSession.selectOne("dao.MemberMapper.login", hMap);

	}

	/**
	 * @name:register
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:회원정보 DB에등록
	 */
	@Override
	public int register(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("dao.MemberMapper.register", memberDto);
	}

	/**
	 * @name:registerCheck
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:등록하는 member_id가 DB에 있는지 확인
	 */
	@Override
	public int registerCheck(String member_id) {
		int check = 0;
		String id = sqlSession.selectOne("dao.MemberMapper.registerCheck",member_id);

		if (id != null) {
			check = 1;
		}
		return check;
	}

	/**
	 * @name:fbRegisterCheck
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:페이스북 계정으로 로그인한 클라이언트중 이전에 방문하여 등록이 되어있는지 확인
	 */
	@Override
	public int fbRegisterCheck(String member_id) {
		int check = 0;
		String id = sqlSession.selectOne("dao.MemberMapper.fbRegisterCheck",member_id);

		if (id != null){
			check = 1;
		}else{
			check=0;
		}
			
		return check;
	}

	/**
	 * @name:fbRegister
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:페이스북 계정으로 로그인한 클라이언트 정보를 DB에 등록
	 */
	@Override
	public int fbRegister(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("dao.MemberMapper.fbRegister", memberDto);
	}

	/**
	 * @name:fbRegisterSelect
	 * @date:2015. 6. 26.
	 * @author:김정훈
	 * @description:페이스북 계정으로 로그인한 클라이언트 정보를 DB에서 가져옴
	 */
	@Override
	public MemberDto fbRegisterSelect(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.fbRegisterSelect",member_id);
	}

	/**
	 * @name:updatePassword
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:
	 */
	@Override
	public int updatePassword(String email,String password) {
		HashMap<String,String> hMap=new HashMap<String,String>();
		hMap.put("email", email);
		hMap.put("password", password);
		return sqlSession.update("dao.MemberMapper.updatePassword",hMap);
	}

	/**
	 * @name:myPageUpdate_pwdCheck
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:
	 */
	@Override
	public int myPageUpdate_pwdCheck(String member_id, String member_pwd) {
		HashMap<String,String> hMap=new HashMap<String,String>();
		hMap.put("member_id", member_id);
		hMap.put("member_pwd", member_pwd);
		
		int check=0;
		String email=sqlSession.selectOne("dao.MemberMapper.myPageUpdate_pwdCheck",hMap);
		if(email!=null) check=1;
		
		return check;
	}

	@Override
	public int myPageUpdate(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("dao.MemberMapper.myPageUpdate",memberDto);
	}

	@Override
	public int myPageDelete(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.delete("dao.MemberMapper.myPageDelete",memberDto);
	}

	@Override
	public int totalPoint(String member_id) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("dao.MemberMapper.totalPoint",member_id);
	}

	@Override
	public List<HashMap<String,Object>> point_info(String member_id,int startRow,int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		
		return sqlSession.selectList("dao.MemberMapper.point_info",hMap);
	}

	@Override
	public int totalBoard(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalBoard",member_id);
	}

	@Override
	public List<HashMap<String, Object>> board_info(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dao.MemberMapper.board_info",member_id);
	}
	
	@Override
	public int totalFavorite(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalFavorite",member_id);
	}
	
	@Override
	public List<HashMap<String, Object>> favorite_info(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dao.MemberMapper.favorite_info",member_id);
	}

	@Override
	public int point_info_count(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.point_info_count",member_id);
	}

	@Override
	public int totalCoupon(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalCoupon",member_id);
	}

	@Override
	public List<HashMap<String, Object>> coupon_info(String member_id, int startRow,
			int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		return sqlSession.selectList("dao.MemberMapper.coupon_info",hMap);
	}

	

}
