package com.sxt.bus.service;

import java.util.List;

import com.sxt.bus.domain.Inport;
import com.sxt.bus.vo.InportVo;
import com.sxt.sys.utils.DataGridView;

public interface InportService {

	List<Inport> queryAllInport(InportVo inportVo);

	DataGridView loadInport(InportVo inportVo);

	void addInport(InportVo inportVo);

	Inport queryInportById(Integer id);

	void updateInport(InportVo inportVo);

	void deleteInport(InportVo inportVo);

}
