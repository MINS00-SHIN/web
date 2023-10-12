package com.team2.healthsns.controller;

import com.team2.healthsns.service.CommunityService;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class CommunityController_auth {
    @Autowired
    CommunityService service;

    @GetMapping("/AuthCommunity/list")
    public ModelAndView CommunityListAuth(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setTotalRecord(service.totalRecordAuth(pVO));
        List<CommunityVO> list = service.CommunityPageListAuth(pVO);
        mav.addObject("list", list);
        mav.addObject("pVO", pVO);
        mav.setViewName("community/Community_Auth");
        return mav;
    }

    @GetMapping("/AuthCommunity/write")
    public String CommunityWrite() {
        return "/community/Community_Posting_Auth";
    }

    @PostMapping("/AuthCommunity/writeOk")
    public ModelAndView CommunityWriteOk(CommunityVO vo, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        vo.setUserid((String) request.getSession().getAttribute("logId"));
        int result = service.CommunityInsertAuth(vo);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("community/Community_Auth");
            mav.addObject("msg", "등록");
        }
        return mav;
    }

    @GetMapping("/AuthCommunity/view")
    public ModelAndView CommunityView(int post_id, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        service.hitCountAuth(post_id);
        CommunityVO vo = service.CommunitySelectAuth(post_id);
        mav.addObject("vo", vo);
        mav.addObject("pVO", pVO);
        mav.setViewName("/community/Community_Auth");
        return mav;
    }

    @GetMapping("/AuthCommunity/edit")
    public ModelAndView CommunityEdit(int post_id) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("vo", service.CommunitySelectAuth(post_id));
        mav.setViewName("community/Community_Edit_Auth");
        return mav;
    }

    @PostMapping("/AuthCommunity/editOk")
    public ModelAndView CommunityEditOk(CommunityVO vo) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityUpdateAuth(vo);
        if (result > 0) {
            mav.setViewName("redirect:view?no=" + vo.getPost_id());
        } else {
            mav.setViewName("community/Community_Auth");
            mav.addObject("msg", "수정");
        }
        return mav;
    }

    @GetMapping("/AuthCommunity/delete")
    public ModelAndView CommunityDelete(int post_id) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityDeleteAuth(post_id);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("redirect:view?no=" + post_id);
        }
        return mav;
    }
}
