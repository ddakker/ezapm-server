package org.ezdevgroup.ezapm.server.collector.verticle;

import io.vertx.core.net.NetSocket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.parsetools.RecordParser;

import java.util.ArrayList;
import java.util.List;

public class ServerVerticle extends AbstractVerticle {
	private static Logger log = LoggerFactory.getLogger(ServerVerticle.class);

	public static List<NetSocket> clientSocketList = new ArrayList<>();

	@Override
	public void start() throws Exception {
		try {
			vertx.createNetServer().connectHandler(socket -> {
				clientSocketList.add(socket);

				String handlerID = socket.writeHandlerID();

				socket.handler(RecordParser.newDelimited("\n", buffer -> {

					String message = buffer.toString().trim();

					log.info(socket.remoteAddress() + " (" + handlerID + ") => " + message);


					/*vertx.eventBus().<String> send(DelayExecVerticle.ALL_PRODUCTS_ADDRESS, message, result -> {
						if (result.succeeded()) {
							log.debug("SS result.result().body(): " + result.result().body());
							socket.write("Receive => " + message + "\r\n");
						} else {
							log.error("FF result.cause().toString(): " + result.cause().toString());
						}
					});*/
					//socket.close();
					
					//vertx.eventBus().<String> send(DelayExecVerticle.ALL_PRODUCTS_ADDRESS, message);
					
					//vertx.eventBus().<String> send("chat.to.server", ": 테스트여 00");
					if (message.contains("grp_was_req")) {
						vertx.eventBus().send(DataProcessVerticle.BUS_DATA_PROCESS_TPS, message);
					}
					vertx.eventBus().send(SockjsVerticle.BUS_SOCKJS_SERVER, message);
					//vertx.eventBus().send(SockjsVerticle.BUS_SOCKJS_CLIENT, message);

				}));
				socket.closeHandler(v -> {
					System.out.println("The socket has been closed");
					clientSocketList.remove(socket);
					socket.close();
				});

			}).listen(9999);
		} catch (Exception e) {
			System.err.println("sock e: " + e);
		}
	}
}
