package org.ezdevgroup.ezapm.server.collector.verticle;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ezwel.core.framework.cache.Cache;

import io.vertx.core.AbstractVerticle;

/**
 * 데이터 DB 저장 처리
 * @author ddakker 2016. 3. 7.
 */
@Component
public class DataSaveVerticle extends AbstractVerticle {
	private static Logger log = LoggerFactory.getLogger(DataSaveVerticle.class);

	@Override
	public void start() throws Exception {
	}
	
	@Override
	public void stop() throws Exception {
	}

}
