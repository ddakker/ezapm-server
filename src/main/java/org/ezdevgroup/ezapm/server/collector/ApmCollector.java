package org.ezdevgroup.ezapm.server.collector;

import java.util.Map;
import java.util.Timer;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;

import org.ezdevgroup.ezapm.server.collector.job.TimerJob;
import org.ezdevgroup.ezapm.server.collector.verticle.DataProcessVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.ServerVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.SockjsVerticle;
import org.springframework.stereotype.Component;

import com.ezwel.core.framework.cache.Cache;

import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;

/**
 * Created by ddakker on 2016-03-04.
 */
@Component
public class ApmCollector {
	final Vertx vertx = Vertx.vertx();
	Timer timer = new Timer("VERTX-BG-TIMER", true);
	
	@Resource Cache<Map<String, Long>> reqTimeCache;
	@Resource DataProcessVerticle dataProcessVerticle;
	
    @PostConstruct
    public void init() {
    	System.out.println("ApmCollector reqTimeCache: " + reqTimeCache);
    	
        //vertx.deployVerticle(new SpringDemoVerticle(context));
        //vertx.deployVerticle(new DelayExecVerticle(), new DeploymentOptions().setWorker(true).setInstances(10));
        //vertx.deployVerticle(DelayExecVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
        //vertx.deployVerticle(new SockjsVerticle());
        vertx.deployVerticle(dataProcessVerticle, new DeploymentOptions().setWorker(true));
        vertx.deployVerticle(SockjsVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
        vertx.deployVerticle(new ServerVerticle());
        //vertx.deployVerticle(new ServerVerticle2());
        

        
        int period = 5000;
        timer.schedule(new TimerJob(vertx, period), 5000,  period);
        
        
    }
    
    @PreDestroy
    public void destroy() {
    	if (timer != null) {
    		timer.cancel();
    	}
    	if (vertx != null) {
    		vertx.close();
    	}
    }
}
