package org.ezdevgroup.ezapm.server.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ddakker on 2016-03-04.
 */
@Controller
public class MainController {

    @RequestMapping("/")
    public String hello() {

        return "dashboard";
    }



}