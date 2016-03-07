package org.ezdevgroup.ezapm.server.collector.verticle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.ezdevgroup.ezapm.server.collector.ShareData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.ezwel.core.framework.cache.Cache;
import com.ezwel.core.support.util.JsonUtils;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.eventbus.Message;

/**
 * 데이터 가공 처리
 * @author ddakker 2016. 3. 7.
 */
@Component
public class DataProcessVerticle extends AbstractVerticle {
	private static Logger log = LoggerFactory.getLogger(DataProcessVerticle.class);
	
	public static final String BUS_DATA_PROCESS_TPS = "bus.data.process.tps";
	
	@Resource Cache<Long> reqTimeCache;

	@Override
	public void start() throws Exception {
		System.out.println("DataSaveVerticle reqTimeCache: " + reqTimeCache);
		vertx.eventBus().consumer(DataProcessVerticle.BUS_DATA_PROCESS_TPS, (Message<String> message) -> {
			System.out.println("DelayExecVerticle reqTimeCache: " + reqTimeCache);
			String messageData = message.body();
			Map msgMap = JsonUtils.toJson(messageData, HashMap.class);
			Map dataMap = (Map) msgMap.get("data");

			synchronized (ShareData.resMap) {
				String serverNm = (String) dataMap.get("serverNm");
				String key 		= ((String) dataMap.get("serverNm") + (String) dataMap.get("threadId") + (String) dataMap.get("sessionId") + (String) dataMap.get("uri"));
				
				if (dataMap.get("stTime") != null) {	// 요청
					reqTimeCache.put(key, (Long) dataMap.get("stTime"));
				}
				
				if (dataMap.get("edTime") != null) {    // 요청완료
					Long stTime = reqTimeCache.get(key);
					Long edTime = (Long) dataMap.get("edTime");
					
					Long resTime = edTime - stTime;		// 처리시간
					
					if (ShareData.resMap.get(serverNm) == null) {
						ShareData.resMap.put(serverNm, new ArrayList<Long>());
					}
					List<Long> serverResData = ShareData.resMap.get(serverNm);
					serverResData.add(resTime);
					
					reqTimeCache.remove(key);
				}
			}

		});
	}
	
	@Override
	public void stop() throws Exception {
	}

}
