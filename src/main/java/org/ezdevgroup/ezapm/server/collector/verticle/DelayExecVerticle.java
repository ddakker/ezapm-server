/*package org.ezdevgroup.ezapm.server.collector.verticle;

import com.ezwel.core.framework.cache.Cache;
import com.ezwel.core.support.util.JsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Handler;
import io.vertx.core.eventbus.Message;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

public class DelayExecVerticle extends AbstractVerticle {
	private static Logger log = LoggerFactory.getLogger(DelayExecVerticle.class);


	public static final String ALL_PRODUCTS_ADDRESS = "example.all.products";
	public static final String BUS_DELAY_TPS = "bus.delay.tps";

	@Resource Cache<Map<String, Long>> reqTimeCache;

	@Override
	public void start() throws Exception {
		super.start();
		//vertx.eventBus().<String> consumer(ALL_PRODUCTS_ADDRESS).handler(allProductsHandler("test value"));
		
		vertx.eventBus().consumer(ALL_PRODUCTS_ADDRESS, (Message<String> message) -> {

			String messageData = message.body();

			log.debug("messageData: {}", messageData);
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//message.reply(messageData + " End");

		});

	}



	private Handler<Message<String>> allProductsHandler(String test) {
		log.debug("test: " + test);
		return msg -> vertx.<String> executeBlocking(future -> {
			log.debug("msg: " + msg);
			try {
				log.debug("처리");
				for (int i = 0; i < 10; i++) {
					log.debug(".");
					Thread.sleep(1000);
				}
				future.complete("처리 완료...");
			} catch (Exception e) {
				log.error("Failed to serialize result");
				future.fail(e);
			}
		} , result -> {
			if (result.succeeded()) {
				msg.reply(result.result());
			} else {
				msg.reply(result.cause().toString());
			}
		});
	}
}
*/