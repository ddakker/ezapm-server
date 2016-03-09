package org.ezdevgroup.ezapm.server.collector.job;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.LongSummaryStatistics;
import java.util.Map;
import java.util.Set;
import java.util.TimerTask;

import org.ezdevgroup.ezapm.server.collector.ShareData;
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
        	Map<String, Map<String, Double>> dataMap = new HashMap<>();
        	
        	Set<String> keys = ShareData.resMap.keySet();
        	for (Iterator<String> iterator = keys.iterator(); iterator.hasNext();) {
                String key = iterator.next();
                List<Long> resTimes = ShareData.resMap.get(key);
                System.out.println("resTimes: " + resTimes);
                
                Map<String, Double> serverInfoMap = new HashMap<>();
                if (resTimes != null) {
	                LongSummaryStatistics stats = resTimes.stream().mapToLong((x) -> x).summaryStatistics();
	                System.out.println("stats s: " + stats.getCount());
	                System.out.println("stats a: " + stats.getAverage());
	                
	                serverInfoMap.put("tps", (stats.getCount() * 1.0) / (period / 1000));
	                serverInfoMap.put("resTime", new Double(stats.getAverage()));
                } else {
                	serverInfoMap.put("tps", 0d);
	                serverInfoMap.put("resTime", 0d);
                }
                
                dataMap.put(key, serverInfoMap);
        	}
        	String jsonStr = JsonUtils.toString(dataMap);
        	System.out.println("jsonStr: " + jsonStr);
            //DelayExecVerticle.tpsMap.clear();
            for (String key : ShareData.resMap.keySet()) {
            	ShareData.resMap.put(key, null);
            }

            jsonStr =  "{\"grp\": \"grp_resInfo\", \"period\": " + period + ", \"data\": " + jsonStr + "}";
            vertx.eventBus().send(SockjsVerticle.BUS_SOCKJS_SERVER, jsonStr);
		}

    }
}
