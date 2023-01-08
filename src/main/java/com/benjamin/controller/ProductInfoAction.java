package com.benjamin.controller;

import com.benjamin.pojo.ProductInfo;
import com.benjamin.pojo.vo.ProductInfoVo;
import com.benjamin.service.ProductInfoService;
import com.benjamin.utils.FileNameUtil;
import com.github.pagehelper.PageInfo;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/prod")
public class ProductInfoAction {
    public static final int PAGE_SIZE = 5;
    String saveFileName = "";

    @Autowired
    ProductInfoService productInfoService;


    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request){
        List<ProductInfo> list = productInfoService.getAll();
        request.setAttribute("list", list);
        return "product";
    }


    @RequestMapping("/split")
    public String split(HttpServletRequest request){

        PageInfo info = productInfoService.splitPage(1, PAGE_SIZE);
        request.setAttribute("info", info);
        return "product";
    }


    @ResponseBody
    @RequestMapping("/ajaxSplit")
    public void ajaxSplit(ProductInfoVo vo, HttpSession session){

        PageInfo info = productInfoService.splitPageVo(vo, PAGE_SIZE);
        session.setAttribute("info", info);
    }

    @ResponseBody
    @RequestMapping("/ajaxImg")
    public Object ajaxImg(MultipartFile pimage, HttpServletRequest request){

        saveFileName = FileNameUtil.getUUIDFileName()+FileNameUtil.getFileType(pimage.getOriginalFilename());

        String path = request.getServletContext().getRealPath("/image_big");

        try {
            pimage.transferTo((new File(path+ File.separator+saveFileName)));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        JSONObject object = new JSONObject();
        object.put("imgurl", saveFileName);

        System.out.println(object.toString());
        return object.toString();
    }

    @RequestMapping("/save")
    public String save(ProductInfo info, HttpServletRequest request){
        info.setpImage(saveFileName);
        info.setpDate(new Date());

        int num = -1;
        try {
            num = productInfoService.save(info);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if(num > 0){
            request.setAttribute("msg", "Product added successfully");
        }else{
            request.setAttribute("msg", "Error");
        }

        return "forward:/prod/split.action";
    }

    @RequestMapping("/one")
    public String one(int pid, Model model){
        ProductInfo info = productInfoService.getByID(pid);
        model.addAttribute("prod", info);
        return "update";
    }

    @RequestMapping("/update")
    public String update(ProductInfo info, HttpServletRequest request){

        if(!saveFileName.equals("")){
            info.setpImage(saveFileName);
        }

        int num = -1;
        try {
            num = productInfoService.update(info);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if(num > 0){
            request.setAttribute("msg","update completed");
        }else{
            request.setAttribute("msg", "update failed");
        }

        saveFileName = "";
        return "forward:/prod/split.action";
    }

    @RequestMapping("/delete")
    public String delete(int pid, HttpServletRequest request){
        int num = -1;
        try {
            num= productInfoService.delete(pid);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (num > 0) {
            request.setAttribute("msg", "successfully deleted");
        }else{
            request.setAttribute("msg", "failed to delete");
        }

        return "forward:/prod/deleteAjaxSplit.action";
    }

    @ResponseBody
    @RequestMapping(value = "/deleteAjaxSplit", produces = "text/html; charset=UTF-8")
    public Object deleteAjaxSplit(HttpServletRequest request){
        PageInfo info = productInfoService.splitPage(1, PAGE_SIZE);
        request.getSession().setAttribute("info", info);
        return request.getAttribute("msg");
    }

    @RequestMapping("/deleteBatch")
    public String deleteBatch(String pids, HttpServletRequest request){

        String[] ps = pids.split(",");

        try {
            int num = productInfoService.deleteBatch(ps);
            if (num > 0) {
                request.setAttribute("msg", "Batch deletion successful");
            } else {
                request.setAttribute("msg", "Batch delete failed");
            }
        }catch (Exception e){
            request.setAttribute("msg", "Items cannot be deleted");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }

    @ResponseBody
    @RequestMapping("/condition")
    public void condition(ProductInfoVo vo, HttpSession session){
        List<ProductInfo> list = productInfoService.selectCondition(vo);
        session.setAttribute("list", list);
    }
}
