package org.ezdevgroup.ezapm.server.collector.job;

import java.util.ArrayList;
import java.util.Collections;
import java.util.TimerTask;

import org.ezdevgroup.ezapm.server.collector.ShareData;
import org.ezdevgroup.ezapm.server.collector.verticle.DataProcessVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.SockjsVerticle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ezwel.core.support.util.JsonUtils;

import io.vertx.core.Vertx;

/**
 * Created by ddakker on 2016-03-04.
 */
public class TimerJob extends TimerTask {
	private static Logger log = LoggerFactory.getLogger(TimerJob.class);
	
    private Vertx vertx;
    private int period;


    public TimerJob(Vertx vertx, int period) {
        this.vertx = vertx;
        this.period = period;
    }

    @Override
    public void run() {
        synchronized (ShareData.resMap) {
        	String jsonStr = JsonUtils.toString(ShareData.resMap);
            //DelayExecVerticle.tpsMap.clear();
            for (String key : ShareData.resMap.keySet()) {
            	ShareData.resMap.put(key, null);
            }

            jsonStr =  "{\"grp\": \"grp_resInfo\", \"period\": " + period + ", \"data\": " + jsonStr + "}";
            vertx.eventBus().send(SockjsVerticle.BUS_SOCKJS_SERVER, jsonStr);
		}

    }
}
