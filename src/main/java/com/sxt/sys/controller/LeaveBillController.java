package com.sxt.sys.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYSConstast;
import com.sxt.sys.domain.LeaveBill;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.LeaveBillService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LeaveBillVo;

@Controller
@RequestMapping("leaveBill")
public class LeaveBillController {
	
	@Autowired
	private LeaveBillService leaveBillService;

	/**
	 * 跳转到leaveBillManager.jsp
	 */
	@RequestMapping("toLeaveBillManager")
	public String toLeaveBillManager() {
		return "sys/leaveBill/leaveBillManager";
	}
	
	
	/**
	 * 加载请假单列表
	 */
	@RequestMapping("loadAllLeaveBills")
	@ResponseBody
	public DataGridView loadAllLeaveBills(LeaveBillVo leaveBillVo,HttpSession session) {
		User user = (User) session.getAttribute("user");
		if(user.getType()==SYSConstast.USER_TYPE_SUPER) {
			return this.leaveBillService.queryAllLeaveBills(leaveBillVo);
		}else {
			leaveBillVo.setUserid(user.getId());
			return this.leaveBillService.queryAllLeaveBills(leaveBillVo);
		}
		
	}
	
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping("toAddLeaveBill")
	public String toAddLeaveBill() {
		return "sys/leaveBill/leaveBillAdd";
	}
	
	/**
	 * 添加
	 */
	@RequestMapping("addLeaveBill")
	@ResponseBody
	public Map<String,Object> addLeaveBill(LeaveBillVo leaveBillVo){
		Map<String, Object> map=new HashMap<>();
		String msg="添加成功";
		try {
			this.leaveBillService.addLeaveBill(leaveBillVo);
		} catch (Exception e) {
			msg="添加失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("toUpdateLeaveBill")
	public String toUpdateLeaveBill(LeaveBillVo leaveBillVo,Model model) {
		LeaveBill leaveBill=this.leaveBillService.queryLeaveBillById(leaveBillVo.getId());
		model.addAttribute("leaveBill", leaveBill);
		return "sys/leaveBill/leaveBillUpdate";
	}
	
	/**
	 * 修改
	 */
	@RequestMapping("updateLeaveBill")
	@ResponseBody
	public Map<String,Object> updateLeaveBill(LeaveBillVo leaveBillVo){
		Map<String, Object> map=new HashMap<>();
		String msg="修改成功";
		try {
			//做修改
			this.leaveBillService.updateLeaveBill(leaveBillVo);
		} catch (Exception e) {
			msg="修改失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	/**
	 * 删除
	 */
	@RequestMapping("deleteLeaveBill")
	@ResponseBody
	public Map<String,Object> deleteLeaveBill(LeaveBillVo leaveBillVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			//做删除
			this.leaveBillService.deleteLeaveBill(leaveBillVo.getId());
		} catch (Exception e) {
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteLeaveBill")
	@ResponseBody
	public Map<String,Object> batchDeleteLeaveBill(LeaveBillVo leaveBillVo){
		Map<String, Object> map=new HashMap<>();
		String msg="删除成功";
		try {
			//做删除
			Integer[] ids=leaveBillVo.getIds();
			if(null!=ids&&ids.length>0) {
				for (Integer integer : ids) {
					this.leaveBillService.deleteLeaveBill(integer);
				}
			}
		} catch (Exception e) {
			msg="删除失败"+e.getMessage();
		}
		map.put("msg", msg);
		return map;
	}
}
