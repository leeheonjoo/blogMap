package com.java.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.board.dto.BoardDto;
import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
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
	 * @description:id와 password가 일치하는 모든 정보를 DB에서 가져와 MemberDto로 반환
	 */
	@Override
	public MemberDto login(String id, String password) {
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
	public MemberDto fbRegisterCheck(String member_id) {
//		int check = 0;
//		String id = sqlSession.selectOne("dao.MemberMapper.fbRegisterCheck",member_id);

//		if (id != null){
//			check = 1;
//		}else{
//			check=0;
//		}
			
		return sqlSession.selectOne("dao.MemberMapper.fbRegisterCheck",member_id);
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
	 * @description:임시 비밀번호로 보내준 password를 해당email(id)의 password로 update해줌에 따라 숫자 반환  
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
	 * @description:회원 수정을 위해 DB에서 id와 password가 일치하는지 select문을 통해서 확인하여 값의 유무에따라 숫자반환
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

	/**
	 * @name:myPageUpdate
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:memberDto에 담은 정보들을 update문을 통해 수정하고 결과에 따라 숫자반환
	 */
	@Override
	public int myPageUpdate(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("dao.MemberMapper.myPageUpdate",memberDto);
	}

	/**
	 * @name:myPageDelete
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:memberDto를 통해 해당 아이디의 member_jointype을 0003으로 바꾸며 나머지 정보들을 null로 update함에 따라 숫자로반환 
	 */
	@Override
	public int myPageDelete(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("dao.MemberMapper.myPageDelete",memberDto);
	}

	/**
	 * @name:totalPoint
	 * @date:2015. 7. 2.
	 * @author:김정훈
	 * @description:point_info테이블에 member_id와 일치하는 포인트 값을 합산하여 반환
	 */
	@Override
	public int totalPoint(String member_id) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("dao.MemberMapper.totalPoint",member_id);
	}

	/**
	 * @name:point_info
	 * @date:2015. 7. 2.
	 * @author:김정훈
	 * @description:해당 아이디의 포인트 상세 정보들을 startRow와 endRow의 범위에 맞춰서 list를 가져옴
	 */
	@Override
	public List<HashMap<String,Object>> point_info(String member_id,int startRow,int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		
		return sqlSession.selectList("dao.MemberMapper.point_info",hMap);
	}

	/**
	 * @name:totalBoard
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:board테이블에서 해당 아이디의 게시물 갯수를 count(*)하여 결과값 반환
	 */
	@Override
	public int totalBoard(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalBoard",member_id);
	}

	/**
	 * @name:board_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 게시글 상세 정보들을 startRow와 endRow의 범위 맞춰서 list를 가져옴
	 */
	@Override
	public List<HashMap<String, Object>> board_info(String member_id,int startRow,int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		return sqlSession.selectList("dao.MemberMapper.board_info",hMap);
	}
	
	/**
	 * @name:totalFavorite
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:favorite테이블에서 해당 아이디의 즐겨찾기한 갯수를 count(*)하여 결과값 반환
	 */
	@Override
	public int totalFavorite(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalFavorite",member_id);
	}
	
	/**
	 * @name:favorite_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 즐겨찾기 상세 정보들을 startRow와 endRow의 범위에 맞춰서 list를 가져옴
	 */
	@Override
	public List<HashMap<String, Object>> favorite_info(String member_id,int startRow,int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		return sqlSession.selectList("dao.MemberMapper.favorite_info",hMap);
	}

	/**
	 * @name:point_info_count
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:point_info테이블에서 해당 아이디의 포인트 갯수를 count(*)하여 결과값 반환
	 */
	@Override
	public int point_info_count(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.point_info_count",member_id);
	}

	/**
	 * @name:totalCoupon
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:coupon_issue테이블에서 해당 아이디의 쿠폰 갯수를 count(*)하여 결과값 반환
	 */
	@Override
	public int totalCoupon(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("dao.MemberMapper.totalCoupon",member_id);
	}

	/**
	 * @name:coupon_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 사용가능한 쿠폰들의 상세 정보들을 startRow와 endRow의 범위에 맞춰서 list를 가져옴
	 */
	@Override
	public List<HashMap<String, Object>> coupon_info(String member_id, int startRow,
			int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		return sqlSession.selectList("dao.MemberMapper.coupon_info",hMap);
	}

	/**
	 * @name:managerRgCheck
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:중복체크를 위해 manager테이블에 select문을 수행하여 값의 유무에 따라 숫자반환 
	 */
	@Override
	public int managerRgCheck(String member_id) {
		int value=0;
		
		String manager_id=sqlSession.selectOne("dao.MemberMapper.managerRgCheck",member_id);
		if(manager_id!=null){
			value=1;
		}else{
			value=0;
		}
		return value;
	}

	/**
	 * @name:managerLogin
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:manager테이블에서 일치하는 id와 password의 managerDto를 반환
	 */
	@Override
	public ManagerDto managerLogin(String id, String password) {
		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("id", id);
		hMap.put("password", password);
		return sqlSession.selectOne("dao.MemberMapper.managerLogin",hMap);
	}

	/**
	 * @name:fbMemberDelete
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:페이스북으로 가입한 member_id의 member_jointype을 0003으로 update하며 다른 정보들을 null로 update함에따라 숫자로반환
	 */
	@Override
	public int fbMemberDelete(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.delete("dao.MemberMapper.fbMemberDelete",member_id);
	}

	/**
	 * @name:reRegister
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:탈퇴한 사용자 재가입할시 memberDto의 관련 정보를 해당아이디에 update함에 따라 숫자반환
	 */
	@Override
	public int reRegister(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("dao.MemberMapper.reRegister",memberDto);
	}

	/**
	 * @name:fbReRegister
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:탈퇴한 사용자 페이스북으로 재가입할시 memberDto의 관련 정보를 해당 아이디에 update함에 따라 숫자반환
	 */
	@Override
	public int fbReRegister(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return sqlSession.update("dao.MemberMapper.fbReRegister",memberDto);
	}

	/**
	 * @name:coupon_unusable_info
	 * @date:2015. 7. 22.
	 * @author:김정훈
	 * @description:해당 아이디의 사용불가능한 쿠폰들의 상세 정보들을 startRow와 endRow의 범위에 맞춰서 list를 가져옴
	 */
	@Override
	public List<HashMap<String, Object>> coupon_unusable_info(String member_id, int startRow, int endRow) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("startRow", startRow);
		hMap.put("endRow", endRow);
		return sqlSession.selectList("dao.MemberMapper.coupon_unusable_info",hMap);
	}

	

}
