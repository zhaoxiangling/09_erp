package com.sxt.sys.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sxt.sys.utils.RandomStrUtils;

@Controller
@RequestMapping("upload")
public class UploadController {

	@RequestMapping("uploadFile")
	@ResponseBody
	public Map<String,Object> uploadFile(MultipartFile mf,HttpSession session){
		Map<String,Object> map=new HashMap<>();	
		map.put("code", 0);
		map.put("msg", "");
		
		// 1,得到老名字
		String oldName = mf.getOriginalFilename();
		// 2,得到tomcat里面的upload目录
		String realPath = session.getServletContext().getRealPath(
				"/upload/");
		// 3,得到当前时间2018-07-14
		String currentDate = RandomStrUtils.getCurrentDateToStr();
		// 4,得到新的父目录的路径 并判断是否存在 如果不存在就创建
		String newRealPath = realPath + "/" + currentDate;
		File parentFile = new File(newRealPath);
		if (!parentFile.exists()) {
			parentFile.mkdirs();// 创建文件夹
		}
		// 5,得到新名字
		String newName = RandomStrUtils.createFileNameUseTime(oldName);
		// 6,构造文件
		File file = new File(parentFile, newName);
		// 7，上传
		try {
			mf.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		Map<String,Object> data=new HashMap<>();
		data.put("src", "../upload/"+currentDate+"/"+newName);
		map.put("data", data);
		return map;
	}
}
