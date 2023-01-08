package com.benjamin.service.impl;

import com.benjamin.mapper.ProductTypeMapper;
import com.benjamin.pojo.ProductType;
import com.benjamin.pojo.ProductTypeExample;
import com.benjamin.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    ProductTypeMapper productTypeMapper;

    @Override
    public List<ProductType> getAll() {
        return productTypeMapper.selectByExample(new ProductTypeExample());
    }
}
