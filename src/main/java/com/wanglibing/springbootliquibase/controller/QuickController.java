package com.wanglibing.springbootliquibase.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QuickController {
    @RequestMapping("/")
    @ResponseBody
    public String test(){
        return "Hello liquibase";
    }
}
