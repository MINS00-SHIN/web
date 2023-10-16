package com.team2.healthsns.controller;

import com.team2.healthsns.util.UriUtil;
import com.team2.healthsns.service.CommunityService;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

@Controller
public class CommunityAuthController {
    @Autowired
    CommunityService service;

    @RequestMapping(value = "/AuthCommunity/list", method = RequestMethod.GET)
    public String list(Model model, @ModelAttribute("pVO") PagingVO pVO) {
        try {
            // Fetch the records based on the parameters in pVO
            pVO.setTotalRecord(service.totalRecordAuth(pVO));

            List<CommunityVO> communityItems = service.CommunityPageListAuth(pVO);
            model.addAttribute("list", communityItems);

            // Add all the search and sort parameters to the model to be used in the frontend
            model.addAttribute("page", pVO.getNowPage());
            model.addAttribute("searchKey", pVO.getSearchKey());
            model.addAttribute("searchWord", pVO.getSearchWord());
            model.addAttribute("category", pVO.getCategory());
            model.addAttribute("postSort", pVO.getPostSort());

            // Add the generated URI for search and sort to the model
            model.addAttribute("uri", getUri(pVO));
            model.addAttribute("pVO", pVO);

        } catch (Exception e) {
            // Optionally: Log the exception or handle it accordingly
            e.printStackTrace();
        }
        return "community/Community_Auth";
    }

    private String getUri(PagingVO pVO) {
        int page = pVO.getNowPage();
        String searchType = pVO.getSearchKey();
        String keyword = pVO.getSearchWord();
        String category = pVO.getCategory(); // Fetch category info
        String postSort = pVO.getPostSort(); // Fetch sort option

        return UriUtil.makeSearch(page, searchType, keyword, category, postSort);
    }



    @GetMapping("/AuthCommunity/write")
    public String CommunityWrite(HttpSession session) {
        String logstatus = (String) session.getAttribute("LogStatus");
        if (!logstatus.equals("Y")) {
            return "/minihome/wrong";
        }
        return "/community/Community_Posting_Auth";
    }

    @PostMapping("/AuthCommunity/writeOk")
    public ModelAndView CommunityWriteOk(@RequestParam(value = "first-part", required = false) String firstpart,
                                         @RequestParam(value = "body-part", required = false) List<String> bodyparts,
                                         @RequestParam("subject") String subject,
                                         @RequestParam("content") String content,
                                         HttpSession session) {
        ModelAndView mav = new ModelAndView();
        String userid = (String) session.getAttribute("LogId");
        CommunityVO bVO = new CommunityVO();
        bVO.setUserid(userid);
        bVO.setBoard_cat("auth");
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

        int result = service.CommunityInsertAuth(bVO);

        if (result > 0) {
            mav.setViewName("redirect:/AuthCommunity/list");
        } else {
            mav.setViewName("/minihome/wrong");
        }

        return mav;
    }

    //여기서부터 내가 한 것

    @GetMapping("/board/view")
    public ModelAndView CommunityView(int post_id, PagingVO pVO) {

        ModelAndView mav = new ModelAndView();
        service.hitCountAuth(post_id);
        CommunityVO vo = service.CommunitySelectAuth(post_id);
        if (vo == null) {
            mav.setViewName("minihome/wrong");
            return mav;
        }
        StringBuilder sb = new StringBuilder();
        if (vo.getBodypart() != null) {
            StringTokenizer st = new StringTokenizer(vo.getBodypart(), "/");
            Map<String, String> wordMap = new HashMap<>();
            wordMap.put("chest", "가슴");
            wordMap.put("shoulder", "어깨");
            wordMap.put("back", "등");
            wordMap.put("arm", "팔");
            wordMap.put("stomach", "복부");
            wordMap.put("waist", "허리");
            wordMap.put("thigh", "허벅지");
            wordMap.put("hip", "엉덩이");
            wordMap.put("calf", "종아리");
            while (st.hasMoreTokens()) {
                String temp = st.nextToken();
                if (wordMap.containsKey(temp)) {
                    sb.append("#").append(wordMap.get(temp)).append(" ").append(" ");
                }
            }
            vo.setBodypart(String.valueOf(sb));
        }
        mav.addObject("vo", vo);
        mav.addObject("pVO", pVO);
        mav.setViewName("/community/Community_post");
        return mav;
    }

    @GetMapping("/board/edit")
    public ModelAndView CommunityEdit(int post_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        String logid = (String) session.getAttribute("LogId");
        CommunityVO vo = service.CommunitySelectAuth(post_id);
        if(!logid.equals(vo.getUserid())){
            mav.setViewName("/minihome/wrong");
            return mav;
        }
        mav.addObject("vo", vo);
        mav.setViewName("/community/Community_Post_edit");
        return mav;
    }

    @PostMapping("/board/editOk")
    public ModelAndView CommunityEditOk(@RequestParam(value = "post_id")int post_id,
                                        @RequestParam(value = "body-part",required = false)List<String> bodyparts,
                                        @RequestParam(value="first-part",required = false)String firstpart,
                                        @RequestParam("subject")String subject,
                                        @RequestParam("content")String content,
                                        HttpSession session) {
        ModelAndView mav = new ModelAndView();
        CommunityVO vo = new CommunityVO();
        vo.setPost_id(post_id);
        vo.setTitle(subject);
        vo.setContent(content);
        if(firstpart!=null){
            vo.setCat(firstpart);
        }
        if(bodyparts!=null){
            StringBuilder sb = new StringBuilder();
            for(int i = 0; i<bodyparts.size();i++){
                sb.append(bodyparts.get(i)).append("/");
            }
            vo.setBodypart(String.valueOf(sb));
        }

        int result = service.CommunityUpdateAuth(vo);
        System.out.println(result==1);
        mav.setViewName("redirect:/board/view?post_id=" + vo.getPost_id());
        return mav;
    }

    @GetMapping("/board/delete")
    public ModelAndView CommunityDelete(int post_id) {
        ModelAndView mav = new ModelAndView();
        CommunityVO temp = service.CommunitySelectAuth(post_id);
        String board_cat = temp.getBoard_cat();
        int result = service.CommunityDeleteAuth(post_id);
        System.out.println(result==1);
        if(board_cat.equals("auth")){
            mav.setViewName("redirect:/AuthCommunity/list");
        }else if(board_cat.equals("free")){
            mav.setViewName("redirect:/FreeCommunity/list");
        }else{
            mav.setViewName("redirect:/QaCommunity/list");
        }
        return mav;
    }

    @PostMapping("/board/like")
    @ResponseBody
    public int increaseLike(int post_id){
        service.increaseLike(post_id);
        CommunityVO vo = service.CommunitySelectAuth(post_id);
        return vo.getLike();
    }
}
