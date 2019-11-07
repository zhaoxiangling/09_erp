	package com.sxt.bus.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.domain.Goods;
import com.sxt.bus.domain.Provider;
import com.sxt.bus.service.GoodsService;
import com.sxt.bus.service.ProviderService;
import com.sxt.bus.vo.GoodsVo;
import com.sxt.bus.vo.ProviderVo;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.TreeNode;

@Controller
@RequestMapping("goods")
public class GoodsController {

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private ProviderService providerService;

	/**
	 * 跳转到商品管理页面
	 */
	@RequestMapping("toGoodsManager")
	public String toGoodsManager() {
		return "bus/goods/goodsManager";
	}

	/**
	 * 左边的树地址
	 */
	@RequestMapping("toGoodsLeft")
	public String toGoodsLeft() {
		return "bus/goods/goodsLeft";
	}

	/**
	 * 右边的列表
	 */
	@RequestMapping("toGoodsRight")
	public String toGoodsRight() {
		return "bus/goods/goodsRight";
	}

	/**
	 * 加载左边的供应商树 返回json
	 */
	@RequestMapping("loadLeftProviderTree")
	@ResponseBody
	public List<TreeNode> loadLeftProviderTree(GoodsVo goodsVo) {
		// 查询所有供应商
		List<Provider> providers = providerService.queryAllProvider(new ProviderVo());
		List<TreeNode> nodes=new ArrayList<>();
		nodes.add(new TreeNode(0, 0, "所有供应商", true, true));
		for (Provider d : providers) {
			nodes.add(new TreeNode(d.getId(), 0, d.getProvidername(), false, false));
		}
		return nodes;
	}

	/**
	 * 加载商品数据
	 */
	@RequestMapping("loadGoods")
	@ResponseBody
	public DataGridView loadGoods(GoodsVo goodsVo) {
		return goodsService.loadGoods(goodsVo);
	}

	/**
	 * 跳转到添加商品页面
	 */
	@RequestMapping("toAddGoods")
	public String toAddGoods(Model model) {
		// 查询所有供应商
		List<Provider> providers = this.providerService
				.queryAllProvider(new ProviderVo());
		model.addAttribute("providers", providers);
		return "bus/goods/goodsAdd";
	}

	/**
	 * 添加商品
	 */
	@RequestMapping("addGoods")
	@ResponseBody
	public Map<String, Object> addGoods(GoodsVo goodsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "添加成功";
		try {
			goodsService.addGoods(goodsVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "添加失败";
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 跳转到修改商品页面
	 */
	@RequestMapping("toUpdateGoods")
	public String toUpdateGoods(GoodsVo goodsVo, Model model) {
		// 查询所有供应商
		List<Provider> providers = this.providerService
				.queryAllProvider(new ProviderVo());
		model.addAttribute("providers", providers);
		// 根据商品ID查询所有商品信息
		Goods goods = this.goodsService.queryGoodsById(goodsVo.getId());
		model.addAttribute("goods", goods);
		return "bus/goods/goodsUpdate";
	}

	/**
	 * 修改商品
	 */
	@RequestMapping("updateGoods")
	@ResponseBody
	public Map<String, Object> updateGoods(GoodsVo goodsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "修改成功";
		try {
			goodsService.updateGoods(goodsVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "修改失败";
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 删除商品
	 */
	@RequestMapping("deleteGoods")
	@ResponseBody
	public Map<String, Object> deleteGoods(GoodsVo goodsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			goodsService.deleteGoods(goodsVo);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 批量删除
	 */
	@RequestMapping("batchDeleteGoods")
	@ResponseBody
	public Map<String, Object> batchDeleteGoods(GoodsVo goodsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = "删除成功";
		try {
			Integer[] ids = goodsVo.getIds();
			for (Integer id : ids) {
				goodsVo.setId(id);
				goodsService.deleteGoods(goodsVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}

	/**
	 * 根据供应商ID查询商品信息
	 */
	@RequestMapping("loadGoodsByProviderId")
	@ResponseBody
	public List<Goods> loadGoodsByProviderId(GoodsVo goodsVo){
		return this.goodsService.loadGoodsByProviderId(goodsVo);
	}
}
