package com.ja.travel.guidePackage.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.travel.dto.GuidePlanningApplicationDto;
import com.ja.travel.dto.GuidePlanningComment;
import com.ja.travel.dto.UserDto;
import com.ja.travel.guidePackage.service.PackageService;

@RestController
@RequestMapping("/guidePackage/*")
public class RestPackageController {

	@Autowired
	private PackageService packageService;

	@RequestMapping("updateGuideApplicationaStatusByUser")
	public Map<String, Object> updateGuideApplicationaStatusByUser(
			GuidePlanningApplicationDto guidePlanningApplicationDto, String value) {

		Map<String, Object> map = packageService.updateGuideApplicationaStatusByUser(guidePlanningApplicationDto,
				value);

		return map;
	}

	@RequestMapping("getPackageApplicationList")
	public Map<String, Object> getPackageApplicationList(HttpSession session, int pageNum, String searchType,
			String searchWord) {

		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> list = packageService.getGuidePlanningList(pageNum, searchType, searchWord, session);
		int totalCount = packageService.getGuidePlanningCount(searchWord);

		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		if (sessionUser != null) {
			map.put("sessionUser", sessionUser);
		}
		
		
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}

	@RequestMapping("guideApplicationDetailInfo")
	public Map<String, Object> guideApplicationDetailInfo(int guide_planning_id, Model model) {

		Map<String, Object> map = packageService.getPlaceByDayForPlan(guide_planning_id);


		return map;
	}

	@RequestMapping("packagePayProcess")
	public String packagePayProcess(HttpServletRequest request) {
	    int partner_order_id = Integer.parseInt(request.getParameter("partner_order_id"));
	    int partner_user_id = Integer.parseInt(request.getParameter("partner_user_id"));
	    String item_name = request.getParameter("item_name");
	    int total_amount = Integer.parseInt(request.getParameter("total_amount"));
		try {
			
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			
			
			try {
				
				HttpURLConnection connect = (HttpURLConnection) address.openConnection();
				connect.setRequestMethod("POST");
				connect.setRequestProperty("Authorization", "KakaoAK d52a1588cb1321edcb60419ee3262720");
				connect.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				connect.setDoOutput(true);
				
				String encodedItemName = URLEncoder.encode(item_name, "UTF-8");

				
				String parmeter = "cid=TC0ONETIME&partner_order_id="+ 
				partner_order_id+"&partner_user_id=" + partner_user_id+
				"&item_name="+ encodedItemName 
						+ "&quantity=1" + "&total_amount=" + total_amount + "&tax_free_amount=0&approval_url=http://localhost:8181/travel/package&cancel_url=http://localhost:8181/&fail_url=http://localhost:8181/";
				
				OutputStream outPutStream = connect.getOutputStream();
				DataOutputStream dataOutputStream = new DataOutputStream(outPutStream);
				dataOutputStream.writeBytes(parmeter);
				dataOutputStream.close();
				
				
				
				int result = connect.getResponseCode();
				
				InputStream inputStream;
				
				if(result == 200) {
					inputStream = connect.getInputStream();
				}else {
					inputStream = connect.getErrorStream();
				}
				
				
				InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
				BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
				
				return bufferedReader.readLine();
				
				
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			
		} catch (MalformedURLException e) {
			
			e.printStackTrace();
		}
		
		return "";
	}
	
@RequestMapping("packageIn")
	public Map<String,Object> packageIn(int guide_planning_id, HttpSession session){
	
		Map<String,Object> map = packageService.insertPackageApplication(guide_planning_id, session);
		
	return map;
	}

@RequestMapping("getCoupon")
	public Map<String,Object> getCoupon(int user_id){
	
		
		
		Map<String, Object> map = packageService.getMyCoupon(user_id);

		
		
	return map;
	}

	@RequestMapping("createInitComment")
	public Map<String, Object> createInitComment(@ModelAttribute GuidePlanningComment guidePlanningComment, HttpSession session) {
		
		
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		
		packageService.createInitComment(guidePlanningComment, sessionUser);
		Map<String, Object> map = new HashMap<>();
		
		map.put("ok", "ok");
		
		return map;
	}
	
	@RequestMapping("getCommentList")
	public Map<String, Object> getCommentList(int guide_planning_id, HttpSession session) {
		
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		
		List<Map<String, Object>> list = packageService.getCommentList(guide_planning_id, sessionUser);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		return map;
	}
	
	@RequestMapping("addLike")
	public Map<String, Object> addLike(int guide_planning_comment_id, HttpSession session) {
		
		UserDto sessionUser = (UserDto) session.getAttribute("sessionuser");
		
		packageService.addLike(guide_planning_comment_id, sessionUser);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ok", "ok");
		
		return map;
	}

}
