package com.team2.healthsns.mapper;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public UserVO UserSelectAll(String id);
    public String GetSessionEmail(String logId);
    public List<UserVO> GetFollowRanking();
    public List<CommunityVO> getTopPostsByDate(String date);

    // 1. 아이디 중복 검사
    public int idCheck(String userid);//아이디 중복확인

    // 2. 회원가입
    public int userInsert(UserVO vo); // UserVO 오브젝트 데이터를

    //3. 로그인
    public String loginSelect(String userid, String userpwd);

    //4. 아이디 찾기
    public String findId(String email);


    //5. 비밀번호 찾기
    public String findPw(String userid, String email, String pwd_q, String pwd_a);

    //6. 비밀번호 변경
    public int changePwd(String pwd, String userid);

    public int emailCheck(String email);
    public int updateUser(String userid_e, String username_e, String email_e, String pwd_q_e, String pwd_a_e, String userpwd_e, String comment_e, String LogId);
}
