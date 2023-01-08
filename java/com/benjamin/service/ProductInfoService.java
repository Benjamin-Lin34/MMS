package com.benjamin.service;

import com.benjamin.pojo.ProductInfo;
import com.benjamin.pojo.vo.ProductInfoVo;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ProductInfoService {

    List<ProductInfo> getAll();

    PageInfo splitPage(int pageNum, int pageSize);

    int save(ProductInfo info);

    ProductInfo getByID(int id);

    int update(ProductInfo info);

    int delete(int pid);

    int deleteBatch(String[] ids);

    List<ProductInfo> selectCondition(ProductInfoVo vo);

    public PageInfo splitPageVo(ProductInfoVo vo, int pageSize);
}
