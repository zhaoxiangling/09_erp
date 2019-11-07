package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Goods;
import com.sxt.bus.domain.Inport;
import com.sxt.bus.mapper.GoodsMapper;
import com.sxt.bus.mapper.InportMapper;
import com.sxt.bus.service.InportService;
import com.sxt.bus.vo.InportVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class InportServiceImpl implements InportService {

	@Autowired
	private InportMapper inportMapper;
	
	@Autowired
	private GoodsMapper goodsMapper;

	@Override
	public List<Inport> queryAllInport(InportVo inportVo) {
		return inportMapper.queryAllInport(inportVo);
	}
	@Override
	public DataGridView loadInport(InportVo inportVo) {
		Page<Inport> page=PageHelper.startPage(inportVo.getPage(), inportVo.getLimit());
		List<Inport> list=this.inportMapper.queryAllInport(inportVo);
		DataGridView view=new DataGridView();
		view.setCount(page.getTotal());
		view.setData(list);
		return view;
	}
	@Override
	public void addInport(InportVo inportVo) {
		this.inportMapper.insert(inportVo);
		//更新商品的库存
		Integer goodsId=inportVo.getGoodsid();
		Goods goods = goodsMapper.selectByPrimaryKey(goodsId);
		//新的库存是  老库存+进货的数量
		goods.setNumber(goods.getNumber()+inportVo.getNumber());
		//更新
		this.goodsMapper.updateByPrimaryKey(goods);
	}
	@Override
	public Inport queryInportById(Integer id) {
		return this.inportMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateInport(InportVo inportVo) {
		this.inportMapper.updateByPrimaryKey(inportVo);
	}
	@Override
	public void deleteInport(InportVo inportVo) {
		this.inportMapper.deleteByPrimaryKey(inportVo.getId());
	}
	
}
