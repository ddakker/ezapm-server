package org.ezdevgroup.ezapm.server.collector.job;

import com.ezwel.core.support.util.JsonUtils;
import io.vertx.core.Vertx;
import org.ezdevgroup.ezapm.server.collector.verticle.DelayExecVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.SockjsVerticle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.TimerTask;

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
        synchronized (DelayExecVerticle.tpsMap) {
            String tpsJsonStr = JsonUtils.toString(DelayExecVerticle.tpsMap);
            //DelayExecVerticle.tpsMap.clear();
            for (String key : DelayExecVerticle.tpsMap.keySet()) {
                DelayExecVerticle.tpsMap.put(key, 0);
            }

            tpsJsonStr =  "{\"grp\": \"grp_tps\", \"period\": " + period + ", \"data\": " + tpsJsonStr + "}";
            vertx.eventBus().send(SockjsVerticle.BUS_SOCKJS_SERVER, tpsJsonStr);
        }

    }
}
