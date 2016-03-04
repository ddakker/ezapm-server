package org.ezdevgroup.ezapm.server.collector;

import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;
import org.ezdevgroup.ezapm.server.collector.job.TimerJob;
import org.ezdevgroup.ezapm.server.collector.verticle.DelayExecVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.ServerVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.ServerVerticle2;
import org.ezdevgroup.ezapm.server.collector.verticle.SockjsVerticle;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import java.util.Timer;

/**
 * Created by ddakker on 2016-03-04.
 */
@Component
public class ApmCollector {
	final Vertx vertx = Vertx.vertx();
	Timer timer = new Timer("VERTX-BG-TIMER", true);
	
    @PostConstruct
    public void init() {
    	
        //vertx.deployVerticle(new SpringDemoVerticle(context));
        //vertx.deployVerticle(new DelayExecVerticle(), new DeploymentOptions().setWorker(true).setInstances(10));
        vertx.deployVerticle(DelayExecVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
        //vertx.deployVerticle(new SockjsVerticle());
        vertx.deployVerticle(SockjsVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
        vertx.deployVerticle(new ServerVerticle());
        vertx.deployVerticle(new ServerVerticle2());

        
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
