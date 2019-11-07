package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Goods;
import com.sxt.bus.mapper.GoodsMapper;
import com.sxt.bus.service.GoodsService;
import com.sxt.bus.vo.GoodsVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	private GoodsMapper goodsMapper;

	@Override
	public List<Goods> queryAllGoods(GoodsVo goodsVo) {
		return goodsMapper.queryAllGoods(goodsVo);
	}
	@Override
	public DataGridView loadGoods(GoodsVo goodsVo) {
		Page<Goods> page=PageHelper.startPage(goodsVo.getPage(), goodsVo.getLimit());
		List<Goods> list=this.goodsMapper.queryAllGoods(goodsVo);
		DataGridView view=new DataGridView();
		view.setCount(page.getTotal());
		view.setData(list);
		return view;
	}
	@Override
	public void addGoods(GoodsVo goodsVo) {
		this.goodsMapper.insert(goodsVo);
	}
	@Override
	public Goods queryGoodsById(Integer id) {
		return this.goodsMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateGoods(GoodsVo goodsVo) {
		this.goodsMapper.updateByPrimaryKey(goodsVo);
	}
	@Override
	public void deleteGoods(GoodsVo goodsVo) {
		this.goodsMapper.deleteByPrimaryKey(goodsVo.getId());
	}
	@Override
	public List<Goods> loadGoodsByProviderId(GoodsVo goodsVo) {
		return this.goodsMapper.queryAllGoods(goodsVo);
	}
	
}
