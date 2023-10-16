package com.team2.healthsns.controller;

import com.team2.healthsns.mapper.UserMapper;
import com.team2.healthsns.service.UserService;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    UserService service;

    @PostMapping("/getuseremail")
    @ResponseBody
    public String getSessionEmail(HttpSession session) {
        //매개변수 logId를 이용해서 이메일만 select
        return service.GetSessionEmail((String) session.getAttribute("LogId"));
    }

    @GetMapping("/myPage")
    public ModelAndView MyPageView(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        String userid = (String) session.getAttribute("LogId");
        String logStatus = (String) session.getAttribute("LogStatus");
        if (userid.isEmpty() || !logStatus.equals("Y")) {
            mav.setViewName("/minihome/wrong");
            return mav;
        }
        //비로그인 상태 제한 끝
        //유저정보 다 가져와야함
        UserVO uservo = service.UserSelectAll(userid);
        mav.addObject("uservo", uservo);
        mav.setViewName("/user/userInfoChange");
        return mav;
    }

    @GetMapping("/user/logout")
    public ModelAndView Logout(HttpSession session){
        session.invalidate();
        ModelAndView mav = new ModelAndView();
        System.out.println("로그아웃찍먹하다옴");
        mav.setViewName("redirect:/home");
        return mav;
    }


    //
    @GetMapping("/userForm")
    public ModelAndView userFormView() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/user/userForm"); // JSP 파일 있는 폴더를 잡아줌 views까진 들어가진 상태.
        return mav;
    }

    @PostMapping("/user/idCheck")
    @ResponseBody
    public int idCheck(String inputid){
        int result = 1;
        try{
            result = service.idCheck(inputid);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return result;
        }
    }

    @PostMapping("/user/idEmail")
    @ResponseBody
    public int emailCheck(String inputemail){
        int result = 1;
        try{
            result = service.emailCheck(inputemail);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return result;
        }
    }

    @PostMapping("/userFormOK")
    public ModelAndView userFormOK(UserVO vo) {
        ModelAndView mav = new ModelAndView();
        System.out.println(vo.getUserid()); // 임시

        System.out.println(vo.toString());
        if ("none".equals(vo.getPwd_q()) || vo.getPwd_q() == null) {
            mav.setViewName("redirect:signUpFail");
            return mav;
        }

        try {
            int result = service.userInsert(vo);

            if (result > 0) {
                mav.setViewName("redirect:/home");
            } else {
                mav.setViewName("user/signUpFail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            mav.setViewName("user/signUpFail");
        }
        return mav;

    }

    @RequestMapping("/user/login")
    public String login() {
        return "user/login";
    }

    @PostMapping("/user/loginOk")
    public ModelAndView loginOk(@RequestParam("userid") String userid,
                                @RequestParam("userpwd") String userpwd,
                                HttpSession session) {

        ModelAndView mav = new ModelAndView();
        String selectid = service.loginSelect(userid, userpwd);
        if (selectid!=null) {
            System.out.println(selectid);
            session.setAttribute("LogId", selectid);
            session.setAttribute("LogStatus", "Y");
            mav.setViewName("redirect:/home");
            System.out.println("여기들림");
        } else {// 로그인 실패 -> 로그인 폼으로 이동
            System.out.println("실패 들림");
            mav.setViewName("redirect:/user/login");
        }
        return mav;
    }


    @GetMapping("/user/userFind")
    public String userFind() {
        return "user/userFind";
    }

    @PostMapping("/user/findId") // 로 요청을 받음
    @ResponseBody // 응답을 전송함
    public String findId(String email) { // 메서드 findId 선언, email 파라미터를 입력받음. jsp에서 var params = "email=" + userEmailV;에서
        // 전달됨.
        // 서비스를 통해 이메일을 기반으로 아이디를 조회
        String foundId = service.findId(email); // 서비스 객체의 findID()메소드를 호출하여 아이디를 찾고 그 결과값을 foundId 변수에 저장함.
        return foundId; // 조회된 아이디를 반환.
    }


    //비밀번호 찾기
    @PostMapping("/user/checkUserInfo")
    @ResponseBody // 응답을 전송함
    public String checkUserInfo(@RequestParam("userid") String userid,
                                @RequestParam("email") String email,
                                @RequestParam("pwd_q") String pwd_q,
                                @RequestParam("pwd_a") String pwd_a) {

        String result = service.findPw(userid, email, pwd_q, pwd_a);
        return result;
    }


    @PostMapping("/user/changepwd")
    @ResponseBody
    public int changePwd(@RequestParam("changepwd") String pwd, @RequestParam("useridV") String userid) {
        int result = service.changePwd(pwd, userid);
        return result;
    }





    @PostMapping("/getfollowranking")
    @ResponseBody
    public List<UserVO> GetFollowRank() {
        List<UserVO> ranklist = service.GetFollowRanking();
        return ranklist;


    }

    @PostMapping("/getpostranking")
    @ResponseBody
    public List<CommunityVO> GetPostRank() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        return service.getTopPostsByDate(date);
    }

    @PostMapping("/user/editprofile")
    public ModelAndView EditProfile(String userid, String userpwd, String userpwd2,
                           String username, String email,
                           String pwd_q, String pwd_a, String comment,
                           HttpSession session){
        ModelAndView mav = new ModelAndView();
        String LogId = (String) session.getAttribute("LogId");
        System.out.println("LogId = "+LogId);
        System.out.println("userpwd = "+userpwd);
        String selectid = service.loginSelect(LogId, userpwd);
        System.out.println(selectid==null);
        if (selectid != null){//기존비번이랑 세션 같으면
            String userid_e = userid;
            String username_e = username;
            String email_e = email;
            String pwd_q_e = pwd_q;
            String pwd_a_e = pwd_a;
            String userpwd_e = userpwd;
            String comment_e = comment;
            if (!(userpwd2 == null || userpwd2.trim().isEmpty())) {
                System.out.println("여기 들어옴?...");
                userpwd_e=userpwd2;
            }
            int result = service.updateUser(userid_e, username_e, email_e, pwd_q_e, pwd_a_e, userpwd_e, comment_e, LogId);
            if(result==1){
                session.invalidate();
                mav.setViewName("/user/login");
            }else{
                mav.setViewName("/minihome/wrong");
            }
        }else{
            System.out.println("실패");
            mav.setViewName("/minihome/wrong");
        }
        return mav;
    }
}
