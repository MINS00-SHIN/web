package com.team2.healthsns.controller;

import com.team2.healthsns.service.MinihomeService;
import com.team2.healthsns.vo.MemoVO;
import com.team2.healthsns.vo.UserVO;
import com.team2.healthsns.vo.GuestbookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class MinihomeController {
    @Autowired
    MinihomeService service;

    @GetMapping("/minihome")
    public ModelAndView minihomeView(String id, HttpSession session) {
        ModelAndView mav = new ModelAndView();

        String userid = (String) session.getAttribute("LogId");
        try {
            UserVO uservo = service.UserSelect(id);//owner정보 불러오기
            if (uservo == null) {
                mav.setViewName("/minihome/wrong");
                return mav;
            }
            List<String> follower = service.FollowerSelect(id);//팔로워 정보 불러오기
            int follow = service.FollowSelect(id);//팔로우 수 불러오기
            int follower_count = follower.size();
            int memo_count = service.CountMemo(id);
            mav.addObject("memo_count", memo_count);
            //메모 수(카운트만 세면 됨)
            //오른쪽 달력에 띄울 달력정보 select
            List<GuestbookVO> guestbooklist = service.GuestbookSelect(id);// 방명록에 띄울 정보 select(리스트로)
            if (guestbooklist != null) {
                mav.addObject("guestbooklist", guestbooklist);
            }

            mav.addObject("uVO", uservo);
            mav.addObject("follower", follower);
            mav.addObject("follower_count", follower_count);
            mav.addObject("follow", follow);
            mav.setViewName("/minihome/minihome");

            //투데이 수(카운트만 세면 됨)
            int today = service.CountToday(id);

            if (!(userid == null)) {//로그인 상태라면 투데이 올리기
                try {
                    service.VisitInsert(id, userid);
                    today++;
                    mav.addObject("today", today);
                } catch (Exception e) {
                } finally {
                    mav.addObject("today", today);
                    return mav;
                }
            }
            mav.addObject("today", today);
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            mav.setViewName("/home");
            return mav;
        }


    }

    @PostMapping("/minihome/guestbookWrite")
    @ResponseBody
    public int GuestbookInsert(String content, String target_home, HttpSession session) {
        GuestbookVO gvo = new GuestbookVO();
        gvo.setContent(content);
        gvo.setTarget_home(target_home);
        gvo.setUserid((String) session.getAttribute("LogId"));
        int result = 0;
        System.out.println(gvo.getTarget_home());
        try {
            result = service.GuestbookInsert(gvo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/minihome/reload")
    @ResponseBody
    public List<GuestbookVO> ReloadGuestbook(String target_home) {
        List<GuestbookVO> guestbooklist = service.GuestbookSelect(target_home);
        return guestbooklist;
    }

    @PostMapping("/minihome/guestbookDelete")
    @ResponseBody
    public int GuestbookDelete(int guestbookid) {
        System.out.println(guestbookid);
        try {
            int result = service.GuestbookDelete(guestbookid);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @PostMapping("/minihome/unfollow")
    @ResponseBody
    public int Unfollow(String ownerid, HttpSession session) {
        String userid = (String) session.getAttribute("LogId");
        return service.FollowDelete(ownerid, userid);
    }

    @PostMapping("/minihome/follow")
    @ResponseBody
    public int Follow(String ownerid, HttpSession session) {
        String userid = (String) session.getAttribute("LogId");
        return service.FollowInsert(ownerid, userid);
    }

    @GetMapping("/minihome/memo/write")
    @ResponseBody
    public ModelAndView MemoWrite(HttpSession session) {
        ModelAndView mav = new ModelAndView();


        Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1; // MONTH는 0부터 시작합니다.
        int year = calendar.get(Calendar.YEAR);
        int date = calendar.get(Calendar.DATE);

        System.out.println(month+" "+year);


        List<MemoVO> memolist = service.MemoListSelect((String) session.getAttribute("LogId"),month,year);

        for(int i = 0; i<memolist.size(); i++){
            System.out.println(memolist.get(i).getWrite_date());
            if(date==Integer.parseInt(memolist.get(i).getWrite_date())){
                mav.setViewName("/minihome/wrong");
                System.out.println("리턴 직전");
                return mav;
            }
        }
        String id = (String) session.getAttribute("LogId");
        try {
            UserVO uservo = service.UserSelect(id);//owner정보 불러오기
            if (uservo == null) {
                mav.setViewName("/minihome/wrong");
                return mav;
            }
            List<String> follower = service.FollowerSelect(id);//팔로워 정보 불러오기
            int follow = service.FollowSelect(id);//팔로우 수 불러오기
            int follower_count = follower.size();

            int memo_count = service.CountMemo(id);
            mav.addObject("memo_count", memo_count);

            mav.addObject("uVO", uservo);
            mav.addObject("follower_count", follower_count);
            mav.addObject("follow", follow);
            mav.setViewName("/minihome/memoWrite");

            //투데이 수(카운트만 세면 됨)
            int today = service.CountToday(id);

            mav.addObject("today", today);
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            mav.setViewName("/home");
            return mav;
        }
    }

    @PostMapping("/minihome/memo/writeOk")
    public ModelAndView MemoInsert(@RequestParam(name = "first-part") String firstPart,//색깔 결정할 것
                                   @RequestParam(name = "body-part") List<String> bodyParts,//목록에 들어갈 것
                                   @RequestParam(name = "myCheck", required = false) Boolean myCheck,//인증게시판 여부
                                   @RequestParam(name = "editor") String content,//글 내용
                                   @RequestParam(name = "emoji") int emoji,//이모지
                                   HttpSession session) {
        ModelAndView mav = new ModelAndView();
        MemoVO mVO = new MemoVO();
        mVO.setUserid((String) session.getAttribute("LogId"));

        mVO.setEmoji(emoji);
        mVO.setCat(firstPart);
        mVO.setContent(content);
        int addauth = (myCheck == null || !myCheck) ? 0 : 1;
        mVO.setAdd_auth(addauth);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bodyParts.size(); i++) {
            sb.append(bodyParts.get(i)).append("/");
        }
        mVO.setBodypart(String.valueOf(sb));

        int result = service.MemoInsert(mVO);
        if (result > 0) {//insert성공시
            mav.setViewName("redirect:/minihome?id=" + mVO.getUserid());//뷰페이지로 이동해야하는데, 일단 미니홈으로 이동
            System.out.println("성공");
            return mav;
        } else {
            mav.setViewName("redirect:/minihome?id=" + mVO.getUserid());
            System.out.println("실패");
            return mav;
        }
    }

    @GetMapping("/minihome/memoView")
    public ModelAndView MemoView(int no, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        MemoVO mVO = service.MemoSelect(no);
        if(mVO==null){
            mav.setViewName("/minihome/wrong");
            return mav;
        }

        int checkDate = 1;
        //날짜 체크 시작
        Calendar calendar = Calendar.getInstance();
        int month_forcheck = calendar.get(Calendar.MONTH)+1;
        int year_forcheck = calendar.get(Calendar.YEAR);
        int date_forcheck = calendar.get(Calendar.DATE);
        List<MemoVO> memolist = service.MemoListSelect((String) session.getAttribute("LogId"), month_forcheck, year_forcheck);
        for(int i = 0; i<memolist.size(); i++){
            if(date_forcheck == Integer.parseInt(memolist.get(i).getWrite_date())){
                checkDate=0;
            }
        }

        //날짜 체크 끝

        mav.addObject("checkDate",checkDate);
        UserVO uVO = service.UserSelect(mVO.getUserid());
        mav.addObject("uVO", uVO);

        List<String> follower = service.FollowerSelect(uVO.getUserid());//팔로워 정보 불러오기
        int follow = service.FollowSelect(uVO.getUserid());//팔로우 수 불러오기
        int follower_count = follower.size();
        int today = service.CountToday(uVO.getUserid());

        mav.addObject("follower",follower);

        mav.addObject("follow", follow);
        mav.addObject("follower_count", follower_count);
        mav.addObject("today", today);

        //날짜쪼개기
        String temp = mVO.getWrite_date();

        String[] dateTimeParts = temp.split(" ");

        String[] dateParts = dateTimeParts[0].split("-");

        int memo_count = service.CountMemo(uVO.getUserid());
        mav.addObject("memo_count", memo_count);

        String year = String.valueOf(Integer.parseInt(dateParts[0]));
        String month = String.valueOf(Integer.parseInt(dateParts[1]));
        String day = String.valueOf(Integer.parseInt(dateParts[2]));
        //쪼개기 끝
        System.out.println(mVO.getAdd_auth());

        mav.addObject("mVO", mVO);//일단 그대로 넣어줌
        mav.addObject("year", year);
        mav.addObject("month", month);
        mav.addObject("day", day);
        List<String> bodypart = new ArrayList<String>();

        StringTokenizer st = new StringTokenizer(mVO.getBodypart(), "/");//바디파트 /기준으로 나눠줌 테스트해야함
        while (st.hasMoreTokens()) {
            bodypart.add(st.nextToken());
        }
        for (int i = 0; i < bodypart.size(); i++) {
            System.out.println(bodypart.get(i));
        }
        mav.addObject("bodypart", bodypart);
        return mav;
    }

    @PostMapping("/minihome/generateMemo")
    @ResponseBody
    public List<MemoVO> SelectMonthMemo(String userid, int month, int year){
        month++;
        List<MemoVO> list = service.MemoListSelect(userid, month, year);
        return list;
    }
}
