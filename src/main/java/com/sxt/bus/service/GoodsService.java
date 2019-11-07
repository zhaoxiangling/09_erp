package com.sxt.bus.service;

import java.util.List;

import com.sxt.bus.domain.Goods;
import com.sxt.bus.vo.GoodsVo;
import com.sxt.sys.utils.DataGridView;

public interface GoodsService {

	List<Goods> queryAllGoods(GoodsVo goodsVo);

	DataGridView loadGoods(GoodsVo goodsVo);

	void addGoods(GoodsVo goodsVo);

	Goods queryGoodsById(Integer id);

	void updateGoods(GoodsVo goodsVo);

	void deleteGoods(GoodsVo goodsVo);

	List<Goods> loadGoodsByProviderId(GoodsVo goodsVo);


}
