package com.sxt.sys.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.domain.Notice;
import com.sxt.sys.service.NoticeService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.NoticeVo;

@Controller
@RequestMapping("notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	/**
	 * 跳转到noticeManager.jsp
	 */
	@RequestMapping("toNoticeManager")
	public String toNoticeManager() {
		return "sys/notice/noticeManager";
	}
	
	
	/**
	 * 加载公告列表
	 */
	@RequestMapping("loadAllNotices")
	@ResponseBody
	public DataGridView loadAllNotices(NoticeVo noticeVo) {
		return this.noticeService.queryAllNotices(noticeVo);
	}
	
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddNotice")
	public String toAddNotice() {
		return "sys/notice/noticeAdd";
	}
	
	/**
	 * 添加
	 */
	@RequestMapping("addNotice")
	@ResponseBody
	public Map<String,Object> addNotice(NoticeVo noticeVo){
		Map<String, Object> map=new HashMap<>();
		String msg="添加成功";
		try {
			//做添加
			noticeVo.setCreatetime(new Date());
			this.noticeService.addNotice(noticeVo);
		} catch (Exception e) {
			msg="添加失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("toUpdateNotice")
	public String toUpdateNotice(NoticeVo noticeVo,Model model) {
		Notice notice=this.noticeService.queryNoticeById(noticeVo.getId());
		model.addAttribute("notice", notice);
		return "sys/notice/noticeUpdate";
	}
	
	/**
	 * 修改
	 */
	@RequestMapping("updateNotice")
	@ResponseBody
	public Map<String,Object> updateNotice(NoticeVo noticeVo){
		Map<String, Object> map=new HashMap<>();
		String msg="修改成功";
		try {
			//做修改
			this.noticeService.updateNotice(noticeVo);
		} catch (Exception e) {
			msg="修改失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 删除
	 */
	@RequestMapping("deleteNotice")
	@ResponseBody
	public Map<String,Object> deleteNotice(NoticeVo noticeVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			//做删除
			this.noticeService.deleteNotice(noticeVo.getId());
		} catch (Exception e) {
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteNotice")
	@ResponseBody
	public Map<String,Object> batchDeleteNotice(NoticeVo noticeVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			//做删除
			Integer[] ids=noticeVo.getIds();
			if(null!=ids&&ids.length>0) {
				for (Integer integer : ids) {
					this.noticeService.deleteNotice(integer);
				}
			}
		} catch (Exception e) {
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 查看公告
	 */
	@RequestMapping("showNotice")
	public String showNotice(NoticeVo noticeVo,Model model) {
		model.addAttribute("notice", this.noticeService.queryNoticeById(noticeVo.getId()));
		return "sys/notice/noticeShow";
	}
}
