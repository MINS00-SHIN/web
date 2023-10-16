package com.team2.healthsns.controller;

import com.team2.healthsns.service.CommunityService;
import com.team2.healthsns.util.UriUtil;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.StringTokenizer;
import com.team2.healthsns.util.UriUtil;

@Controller
public class CommunityFreeController {
    @Autowired
    CommunityService service;

    @RequestMapping(value = "/FreeCommunity/list", method = RequestMethod.GET)
    public String list(Model model, @ModelAttribute("pVO") PagingVO pVO) {
        try {
            // Fetch the records based on the parameters in pVO
            pVO.setTotalRecord(service.totalRecordFree(pVO));

            List<CommunityVO> communityItems = service.CommunityPageListFree(pVO);
            model.addAttribute("list", communityItems);

            // Add all the search and sort parameters to the model to be used in the frontend
            model.addAttribute("page", pVO.getNowPage());
            model.addAttribute("searchKey", pVO.getSearchKey());
            model.addAttribute("searchWord", pVO.getSearchWord());
            model.addAttribute("category", pVO.getCategory());
            model.addAttribute("postSort", pVO.getPostSort());

            // Add the generated URI for search and sort to the model
            model.addAttribute("uri", getUri(pVO));
            model.addAttribute("pVO",pVO);

        } catch (Exception e) {
            // Optionally: Log the exception or handle it accordingly
            e.printStackTrace();
        }
        System.out.println("PostSort value: " + pVO.getPostSort());
        return "community/Community_Free";
    }

    private String getUri(PagingVO pVO) {
        int page = pVO.getNowPage();
        String searchType = pVO.getSearchKey();
        String keyword = pVO.getSearchWord();
        String category = pVO.getCategory(); // Fetch category info
        String postSort = pVO.getPostSort(); // Fetch sort option

        return UriUtil.makeSearch(page, searchType, keyword, category, postSort);
    }

    @GetMapping("/FreeCommunity/write")
    public String CommunityWrite(HttpSession session) {
        String logstatus = (String) session.getAttribute("LogStatus");
        if (!logstatus.equals("Y")) {
            return "/minihome/wrong";
        }
        return "/community/Community_Posting_Free";
    }

    @PostMapping("/FreeCommunity/writeOk")
    public ModelAndView CommunityWriteOk(@RequestParam(value = "first-part", required = false) String firstpart,
            @RequestParam(value = "body-part", required = false) List<String> bodyparts,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content,
            HttpSession session) {
        ModelAndView mav = new ModelAndView();
        String userid = (String) session.getAttribute("LogId");
        CommunityVO bVO = new CommunityVO();
        bVO.setUserid(userid);
        bVO.setBoard_cat("free");
        bVO.setTitle(subject);
        bVO.setContent(content);
        if (firstpart != null) {
            bVO.setCat(firstpart);
        }
        if (bodyparts != null) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bodyparts.size(); i++) {
                sb.append(bodyparts.get(i)).append("/");
            }
            bVO.setBodypart(String.valueOf(sb));
        }

        int result = service.CommunityInsertFree(bVO);

        if (result > 0) {
            mav.setViewName("redirect:/FreeCommunity/list");
        } else {
            mav.setViewName("/minihome/wrong");
        }

        return mav;
    }

}
