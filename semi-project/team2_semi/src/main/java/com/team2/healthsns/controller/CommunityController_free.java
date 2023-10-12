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
public class CommunityController_free {
    @Autowired
    CommunityService service;

    @GetMapping("/FreeCommunity/list")
    public ModelAndView CommunityListFree(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setTotalRecord(service.totalRecordFree(pVO));
        List<CommunityVO> list = service.CommunityPageListFree(pVO);
        mav.addObject("list", list);
        mav.addObject("pVO", pVO);
        mav.setViewName("Community/CommunityListFree");
        return mav;
    }

    @GetMapping("/FreeCommunity/write")
    public String CommunityWrite() {
        return "/Community/CommunityWriteFree";
    }

    @PostMapping("/FreeCommunity/writeOk")
    public ModelAndView CommunityWriteOk(CommunityVO vo, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        vo.setUserid((String) request.getSession().getAttribute("logId"));
        int result = service.CommunityInsertFree(vo);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("Community/CommunityResultFree");
            mav.addObject("msg", "등록");
        }
        return mav;
    }

    @GetMapping("/FreeCommunity/view")
    public ModelAndView CommunityView(int post_id, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        service.hitCountFree(post_id);
        CommunityVO vo = service.CommunitySelectFree(post_id);
        mav.addObject("vo", vo);
        mav.addObject("pVO", pVO);
        mav.setViewName("/Community/CommunityViewFree");
        return mav;
    }

    @GetMapping("/FreeCommunity/edit")
    public ModelAndView CommunityEdit(int post_id) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("vo", service.CommunitySelectFree(post_id));
        mav.setViewName("Community/CommunityEditFree");
        return mav;
    }

    @PostMapping("/FreeCommunity/editOk")
    public ModelAndView CommunityEditOk(CommunityVO vo) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityUpdateFree(vo);
        if (result > 0) {
            mav.setViewName("redirect:view?no=" + vo.getPost_id());
        } else {
            mav.setViewName("Community/CommunityResultFree");
            mav.addObject("msg", "수정");
        }
        return mav;
    }

    @GetMapping("/FreeCommunity/delete")
    public ModelAndView CommunityDelete(int post_id) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityDeleteFree(post_id);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("redirect:view?no=" + post_id);
        }
        return mav;
    }
}
