package com.team2.healthsns.service;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.UserVO;

import java.util.List;

public interface UserService {
    public UserVO UserSelectAll(String id);
    public String GetSessionEmail(String logId);
    public List<UserVO> GetFollowRanking();
    public List<CommunityVO> getTopPostsByDate(String date);

    public int idCheck(String userid);

    // 2. 회원가입
    public int userInsert(UserVO vo); // UserVO 모양의 데이터를 받아서 반환하지않는다.

    // 로그인
    public String loginSelect(String userid, String userpwd);

    // 아이디 찾기
    public String findId(String email);

    // 비밀번호 찾기
    public String findPw(String userid, String email, String pwd_q, String pwd_a);

    // 비밀번호 변경
    public int changePwd(String pwd, String userid);

    public int emailCheck(String email);
}
