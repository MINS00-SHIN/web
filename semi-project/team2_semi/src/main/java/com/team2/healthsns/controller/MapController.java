package com.team2.healthsns.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team2.healthsns.service.MapService;
import com.team2.healthsns.vo.ReviewVO;

@Controller
public class MapController {
	@Autowired
	MapService service;

	@GetMapping("/map")
	public ModelAndView MapView() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/map/map");
		return mav;
	}

	@PostMapping("/submit-review")
	public ModelAndView submitReview(@RequestParam("placeName") String placeName,
			@RequestParam("comment") String comment, @RequestParam("x") String x, @RequestParam("y") String y,
			HttpSession session, @RequestParam("rating") int rating) {
		ReviewVO reviewvo = new ReviewVO();
		ModelAndView mav = new ModelAndView();
		reviewvo.setName(placeName);
		reviewvo.setReview(comment);
		reviewvo.setLatitude(String.valueOf(y));
		reviewvo.setLongitude(String.valueOf(x));
		reviewvo.setUserid((String) session.getAttribute("LogId"));
		reviewvo.setRating(rating);
		
		int result = 0;

		try {
			 result = service.WriteReview(reviewvo);	
		} catch(Exception e) {
			e.printStackTrace();
		}

		mav.setViewName("redirect:/map");
		return mav;

	}
	
	@PostMapping("/getreview")
	@ResponseBody
	public List<ReviewVO> GetReview(String x,String y,String placeName){
		List<ReviewVO> reviewList = null;
		reviewList = service.GetPlaceReview(x,y,placeName);
		
		return reviewList;
		
	}
}
