package com.team2.healthsns.service;

import com.team2.healthsns.mapper.UserMapper;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.UserVO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class UserServicempl implements UserService {
    @Inject
     UserMapper mapper;

    @Override
    public UserVO UserSelectAll(String id) {
        return mapper.UserSelectAll(id);
    }

    @Override
    public String GetSessionEmail(String logId) {
        return mapper.GetSessionEmail(logId);
    }

    @Override
    public List<UserVO> GetFollowRanking() {
        return mapper.GetFollowRanking();
    }

    @Override
    public List<CommunityVO> getTopPostsByDate(String date) {
        return mapper.getTopPostsByDate(date);
    }

    @Override
    public int userInsert(UserVO vo) {
        return mapper.userInsert(vo);
    }

    // 로그인
    @Override
    public String loginSelect(String userid, String userpwd) {
        return mapper.loginSelect(userid, userpwd);
    }

    // 아이디 중복 체크
    @Override
    public int idCheck(String userid) {

        return mapper.idCheck(userid);
    }

    // 아이디 찾기 기능 구현
    @Override
    public String findId(String email) { // findId 메서드 선언, email 파라미터를 입력 받음
        String foundId = mapper.findId(email); // mapper 객체의 findId 메서드 호출하여 얻은 CRUD 수행 결과물을 foundId에 저장.
        return foundId != null ? foundId : ""; // 조회된 결과값이 널인 경우 ""반환, 널이 아니면 foundId값 반환.
    }

    @Override
    // 비밀번호 찾기 기능 구현
    public String findPw(String userid, String email, String pwd_q, String pwd_a) {
        return mapper.findPw(userid, email, pwd_q, pwd_a);
    }

    @Override
    public int changePwd(String pwd, String userid) {
        // TODO Auto-generated method stub
        return mapper.changePwd(pwd, userid);
    }

    @Override
    public int emailCheck(String email) {
        return mapper.emailCheck(email);
    }

    @Override
    public int updateUser(String userid_e, String username_e, String email_e, String pwd_q_e, String pwd_a_e, String userpwd_e, String comment_e, String LogId) {
        return mapper.updateUser(userid_e, username_e, email_e, pwd_q_e, pwd_a_e, userpwd_e, comment_e, LogId);
    }

}
