<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/layout/inc/tags.jspf" %>

	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="/resources/js/vertx/sockjs-0.3.4.js"></script>
	<script src="/resources/js/vertx/vertx-eventbus.js"></script>
	
	<input type="text" id="input" />
	<script>
		var IS_DUMMY_DATA = true;
		var SERVER_LIST = [{serverNm: 'WU1', grpNm: 'WU'}, {serverNm: 'WS1', grpNm: 'WS'}]
		
		if (IS_DUMMY_DATA == false) {
			var BUS_SOCKJS_CLIENT = "bus.sockjs.client";
			var BUS_SOCKJS_SERVER = "bus.sockjs.server";
			
			var eb = new EventBus("http://localhost:9090/eventbus/");
			eb.onopen = function() {
				eb.registerHandler(BUS_SOCKJS_CLIENT, function(err, msg) {
					//console.log(msg.body)
					
					var revData = $.parseJSON(msg.body);//eval("(" + msg.body + ")");
					
					if (revData.grp == "grp_was_mem") {
						if (typeof memPushChart == "function") memPushChart(revData);
					} else if (revData.grp == "grp_tps") {
						if (typeof tpsPushChart == "function") tpsPushChart(revData);
					}
				});
			};
			function send() {
				eb.publish(BUS_SOCKJS_SERVER, "aaaa");
			}
			//send();
		} else {
			setInterval(function(){
				if (typeof memPushChart == "function") {
					var startTime = (new Date()).getTime();
					var per = Math.floor(Math.random() * 100) + 0;
					var data = "{grp: 'grp_was_mem', data: {serverNm: 'WU1', heapUsedPercent: '" + per + "', heapMax: '63438848', heapUsed: '40509152', nonHeapUsed: '32213336', time: '" + startTime + "'}}";
					memPushChart(eval("(" + data + ")"));
					
					startTime += 1000;
					per = Math.floor(Math.random() * 50) + 0;
					data = "{grp: 'grp_was_mem', data: {serverNm: 'WS1', heapUsedPercent: '" + per + "', heapMax: '63438848', heapUsed: '40509152', nonHeapUsed: '32213336', time: '" + startTime + "'}}";
					memPushChart(eval("(" + data + ")"));
				}
			}, 2000);
			
			/* setInterval(function(){
				var mem_per = Math.floor(Math.random() * 100) + 0;
				if (typeof spdmtPushChart == "function") {
					var startTime = (new Date()).getTime();
					var data = "{grp: 'grp_was_req', data: {UUID: 'a', server: 'null' , threadId: '38' , sessionId: 'FEDE85678952F8190570845E12D5E7D7' , uri: '/bg-middle.png' , ip: '127.0.0.1' , stTime: '" + startTime + "' }}";
					spdmtPushChart(data);
					
					data = "{grp: 'grp_was_req', data: {UUID: 'a', server: 'null' , threadId: '38' , uri: '/bg-middle.png' , ip: '127.0.0.1' , edTime: '" + (startTime + Math.floor(Math.random() * 10000) + 0) + "' , status: '200' }}";
					spdmtPushChart(data);
				}
			}, 1000); */
		}
	</script>
	
	<p />
	<!-- /.row -->
	<div class="row">
	    <div class="col-lg-5">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.speedMeter"/></div>
                <div class="panel-body">
                    <div style="height: 200px"><%@ include file="/WEB-INF/jsp/view/module/chart/spdmt.jspf" %></div>
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
                    <div style="height: 150px"><%@ include file="/WEB-INF/jsp/view/module/chart/tph.jspf" %></div>
                </div>
            </div>
	    </div>
	    
	    <div class="col-lg-3">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.mem"/></div>
                <div class="panel-body">
                    <div style="height: 150px"><%@ include file="/WEB-INF/jsp/view/module/chart/mem.jspf" %></div>
                </div>
            </div>
	    </div>
	    <div class="col-lg-3">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.ds"/></div>
                <div class="panel-body">
                    <div style="height: 150px"><%@ include file="/WEB-INF/jsp/view/module/chart/ds.jspf" %></div>
                </div>
            </div>
	    </div>
	    <div class="col-lg-2">
	        <div class="panel panel-primary">
	        	<div class="panel-heading"><spring:message code="tit.panel.noti"/></div>
                <div class="panel-body">
                    <div style="height: 150px"><%@ include file="/WEB-INF/jsp/view/module/chart/noti.jspf" %></div>
                </div>
            </div>
	    </div>
	</div>
	<!-- /.row -->



