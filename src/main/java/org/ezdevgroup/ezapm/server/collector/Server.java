package org.ezdevgroup.ezapm.server.collector;

import org.ezdevgroup.ezapm.server.collector.config.AppContext;
import org.ezdevgroup.ezapm.server.collector.job.TimerJob;
import org.ezdevgroup.ezapm.server.collector.verticle.DelayExecVerticle;
import org.ezdevgroup.ezapm.server.collector.verticle.ServerVerticle2;
import org.ezdevgroup.ezapm.server.collector.verticle.SockjsVerticle;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;
import org.ezdevgroup.ezapm.server.collector.verticle.ServerVerticle;

import java.util.Timer;

import static java.lang.Thread.sleep;

public class Server {
	public static void main(String[] args) {
		ApplicationContext context = new AnnotationConfigApplicationContext(AppContext.class);
		final Vertx vertx = Vertx.vertx();
		//vertx.deployVerticle(new SpringDemoVerticle(context));
		//vertx.deployVerticle(new DelayExecVerticle(), new DeploymentOptions().setWorker(true).setInstances(10));
		vertx.deployVerticle(DelayExecVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
		//vertx.deployVerticle(new SockjsVerticle());
		vertx.deployVerticle(SockjsVerticle.class.getName(), new DeploymentOptions().setWorker(true).setInstances(2));
		vertx.deployVerticle(new ServerVerticle());
		vertx.deployVerticle(new ServerVerticle2());

		Timer timer = new Timer("VERTX-BG-TIMER", true);
		int period = 5000;
		timer.schedule(new TimerJob(vertx, period), 5000,  period);
	}
}
