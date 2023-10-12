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
public class CommunityController_qa {
    @Autowired
    CommunityService service;

    @GetMapping("/QaCommunity/list")
    public ModelAndView CommunityListQa(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        pVO.setTotalRecord(service.totalRecordQa(pVO));
        List<CommunityVO> list = service.CommunityPageListQa(pVO);
        mav.addObject("list", list);
        mav.addObject("pVO", pVO);
        mav.setViewName("Community/CommunityListQa");
        return mav;
    }

    @GetMapping("/QaCommunity/write")
    public String CommunityWrite() {
        return "/Community/CommunityWriteQa";
    }

    @PostMapping("/QaCommunity/writeOk")
    public ModelAndView CommunityWriteOk(CommunityVO vo, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        vo.setUserid((String) request.getSession().getAttribute("logId"));
        int result = service.CommunityInsertQa(vo);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("Community/CommunityResultQa");
            mav.addObject("msg", "등록");
        }
        return mav;
    }

    @GetMapping("/QaCommunity/view")
    public ModelAndView CommunityView(int post_id, PagingVO pVO) {
        ModelAndView mav = new ModelAndView();
        service.hitCountQa(post_id);
        CommunityVO vo = service.CommunitySelectQa(post_id);
        mav.addObject("vo", vo);
        mav.addObject("pVO", pVO);
        mav.setViewName("/Community/CommunityViewQa");
        return mav;
    }

    @GetMapping("/QaCommunity/edit")
    public ModelAndView CommunityEdit(int post_id) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("vo", service.CommunitySelectQa(post_id));
        mav.setViewName("Community/CommunityEditQa");
        return mav;
    }

    @PostMapping("/QaCommunity/editOk")
    public ModelAndView CommunityEditOk(CommunityVO vo) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityUpdateQa(vo);
        if (result > 0) {
            mav.setViewName("redirect:view?no=" + vo.getPost_id());
        } else {
            mav.setViewName("Community/CommunityResultQa");
            mav.addObject("msg", "수정");
        }
        return mav;
    }

    @GetMapping("/QaCommunity/delete")
    public ModelAndView CommunityDelete(int post_id) {
        ModelAndView mav = new ModelAndView();
        int result = service.CommunityDeleteQa(post_id);
        if (result > 0) {
            mav.setViewName("redirect:list");
        } else {
            mav.setViewName("redirect:view?no=" + post_id);
        }
        return mav;
    }
}
