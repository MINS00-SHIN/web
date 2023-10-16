package com.team2.healthsns;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.UserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session) {
		//자동로그인용 나중에 지워야함
		session.setAttribute("LogId", "helloworld2");
		session.setAttribute("LogStatus","Y");

		return "home";
	}


	@GetMapping("/home")
	public String realhome(){
		return "home_temp";
	}


	
}
