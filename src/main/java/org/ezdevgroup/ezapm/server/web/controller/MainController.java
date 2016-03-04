package org.ezdevgroup.ezapm.server.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ddakker on 2016-03-04.
 */
@Controller
public class MainController {
	private static Logger log = LoggerFactory.getLogger(MainController.class);

    @RequestMapping("/")
    public String hello() {
    	log.info("main");

        return "dashboard";
    }



}