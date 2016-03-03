<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/layout/inc/tags.jspf" %>

	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="/resources/js/vertx/sockjs-0.3.4.js"></script>
	<script src="/resources/js/vertx/vertx-eventbus.js"></script>
	
	<input type="text" id="input" />
	<script>
		var IS_DUMMY_DATA = false;
		var SERVER_LIST = [{serverNm: 'WU1', grpNm: 'WU'}, {serverNm: 'WS1', grpNm: 'WS'}]
		
		if (IS_DUMMY_DATA == false) {
			var BUS_SOCKJS_CLIENT = "bus.sockjs.client";
			var BUS_SOCKJS_SERVER = "bus.sockjs.server";
			
			var eb = new EventBus("http://localhost:9090/eventbus/");
			eb.onopen = function() {
				eb.registerHandler(BUS_SOCKJS_CLIENT, function(err, msg) {
					//console.log(msg.body)
					if (typeof memPushChart == "function") { 
						memPushChart(msg.body);
					}
				});
			};
			function send() {
				eb.publish(BUS_SOCKJS_SERVER, "aaaa");
			}
			//send();
		} else {
			
			var WU1 = {};
			WU1.name = 'WU1';
			WU1.data = [];
			var ttt = (new Date()).getTime();
			
			var WS1 = {};
			WS1.name = 'WS1';
			WS1.data = [];
			
			for (var i=-5; i<0; i++) {
				WU1.data.push({x: 0, y: 0});
				WS1.data.push({x: 0, y: 0});
			}
			
			var pushMemoryChartInterval = setInterval(function(){
			//setTimeout(function(){
				if (typeof memPushChart == "function") { 
					WU1.data.shift();
					WU1.data.push({x: (new Date()).getTime(), y: Math.floor(Math.random() * 100) + 0});
					
					WS1.data.shift();
					WS1.data.push({x: (new Date()).getTime(), y: Math.floor(Math.random() * 50) + 0});
					var data = []
					data.push(WU1);
					data.push(WS1);
					
					memPushChart(data);
					
				}
			}, 1000);
			
			setInterval(function(){
				var mem_per = Math.floor(Math.random() * 100) + 0;
				if (typeof spdmtPushChart == "function") {
					
					var startTime = (new Date()).getTime();
					var data = "{grp: 'grp_was_req', data: {server: 'null' , threadId: '38' , sessionId: 'FEDE85678952F8190570845E12D5E7D7' , uri: '/bg-middle.png' , ip: '127.0.0.1' , stTime: '" + startTime + "' }}";
					spdmtPushChart(data);
					
					data = "{grp: 'grp_was_req', data: {server: 'null' , threadId: '38' , uri: '/bg-middle.png' , ip: '127.0.0.1' , edTime: '" + (startTime + Math.floor(Math.random() * 10000) + 0) + "' , status: '200' }}";
					spdmtPushChart(data);
				}
			}, 1000);
		}
	</script>
	
	<p />
	<!-- /.row -->
	<div class="row">
	    <div class="col-lg-5">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.speedMeter"/></div>
                <div class="panel-body">
                    <div style="height: 200px"><%@ include file="/WEB-INF/jsp/view/module/chart/speedMeter.jspf" %></div>
                </div>
            </div>
	    </div>
	    
	    <div class="col-lg-4">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.xView"/></div>
                <div class="panel-body">
                    <div style="height: 200px"><%@ include file="/WEB-INF/jsp/view/module/chart/xView.jspf" %></div>
                </div>
            </div>
	    </div>
	    <div class="col-lg-3">
	    	<div class="row">
			    <div class="col-lg-12">
			        <div class="panel panel-primary">
			        	<div class="panel-heading"><spring:message code="tit.panel.tps"/></div>
		                <div class="panel-body">
		                    <div style="height: 80px"><%@ include file="/WEB-INF/jsp/view/module/chart/tps.jspf" %></div>
		                </div>
		            </div>
			    </div>
			    <div class="col-lg-12">
			        <div class="panel panel-primary">
			        	<div class="panel-heading"><spring:message code="tit.panel.resTime"/></div>
		                <div class="panel-body">
		                    <div style="height: 80px"><%@ include file="/WEB-INF/jsp/view/module/chart/resTime.jspf" %></div>
		                </div>
		            </div>
			    </div>
		    </div>
		</div>
	</div>
	<!-- /.row -->
	
	<div class="row">
	    <div class="col-lg-4">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.tph"/></div>
                <div class="panel-body">
                    <div style="height: 120px"><%@ include file="/WEB-INF/jsp/view/module/chart/tph.jspf" %></div>
                </div>
            </div>
	    </div>
	    
	    <div class="col-lg-3">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.mem"/></div>
                <div class="panel-body">
                    <div style="height: 120px"><%@ include file="/WEB-INF/jsp/view/module/chart/mem.jspf" %></div>
                </div>
            </div>
	    </div>
	    <div class="col-lg-3">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.ds"/></div>
                <div class="panel-body">
                    <div style="height: 120px"><%@ include file="/WEB-INF/jsp/view/module/chart/ds.jspf" %></div>
                </div>
            </div>
	    </div>
	    <div class="col-lg-2">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.noti"/></div>
                <div class="panel-body">
                    <div style="height: 120px"><%@ include file="/WEB-INF/jsp/view/module/chart/noti.jspf" %></div>
                </div>
            </div>
	    </div>
	</div>
	<!-- /.row -->


