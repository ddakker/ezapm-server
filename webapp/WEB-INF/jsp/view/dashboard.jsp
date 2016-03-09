<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/layout/inc/tags.jspf" %>

	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="/resources/js/vertx/sockjs-0.3.4.js"></script>
	<script src="/resources/js/vertx/vertx-eventbus.js"></script>
	<script src="/resources/js/lib/sha1.js"></script>
	<script src="/resources/js/chart/ezbarchart.js"></script>
	
	<script>
		var IS_DUMMY_DATA = false;
		var SERVER_LIST = [{serverNm: 'WU1', grpNm: 'WU'}, {serverNm: 'WS1', grpNm: 'WS'}]

		if (IS_DUMMY_DATA == false) {
			var BUS_SOCKJS_CLIENT = "bus.sockjs.client";
			var BUS_SOCKJS_SERVER = "bus.sockjs.server";

			var eb;
			if (IS_DUMMY_DATA)	eb = new EventBus("http://localhost:9091/eventbus/");
			else				eb = new EventBus("http://192.168.110.119:9091/eventbus/");
			eb.onopen = function() {
				eb.registerHandler(BUS_SOCKJS_CLIENT, function(err, msg) {
					//console.log(msg.body)					

					var revData = $.parseJSON(msg.body);//eval("(" + msg.body + ")");

					if (revData.grp == "grp_was_mem") {
						if (typeof memPushChart == "function") 		memPushChart(revData);
					} else if (revData.grp == "grp_resInfo") {
						if (typeof tpsPushChart == "function") 		tpsPushChart(revData);
						if (typeof resTimePushChart == "function") 	resTimePushChart(revData);
					} else if (revData.grp == "grp_was_req") {
						if (typeof spdmtPushChart == "function")	spdmtPushChart(revData);
						if (typeof xViewPushChart == "function")	xViewPushChart(revData);
					}
					
					
				});
			};
			function send() {
				eb.publish(BUS_SOCKJS_SERVER, "aaaa");
			}
			//send();
		} else if (IS_DUMMY_DATA == true){
			/* setInterval(function(){
				if (typeof memPushChart == "function") {
					var startTime = (new Date()).getTime();
					var per = Math.floor(Math.random() * 100) + 0;
					var data = "{\"grp\": \"grp_was_mem\", \"data\": {\"serverNm\": \"WU1\", \"heapUsedPercent\": \"" + per + "\", \"heapMax\": \"31457280\", \"heapUsed\": \"21667352\", \"nonHeapUsed\": \"34733480\", \"time\": \"" + startTime + "\"}}";
					memPushChart($.parseJSON(data));

					startTime += 1000;
					per = Math.floor(Math.random() * 50) + 0;
					data = "{\"grp\": \"grp_was_mem\", \"data\": {\"serverNm\": \"WS1\", \"heapUsedPercent\": \"" + per + "\", \"heapMax\": \"31457280\", \"heapUsed\": \"21667352\", \"nonHeapUsed\": \"34733480\", \"time\": \"" + startTime + "\"}}";
					memPushChart($.parseJSON(data));
				}
			}, 2000); */

			/* var beforeArray = [
			                   	{serverNm: 'WU1', threadId: '1', sessionId : "AA1"} ,
			                   	{serverNm: 'WS1', threadId: '2', sessionId : "AA2"} ,
			                   	{serverNm: 'WU1', threadId: '3', sessionId : "AA3"} ,
			                   	{serverNm: 'WS1', threadId: '4', sessionId : "AA4"} ,
			                   	{serverNm: 'WU1', threadId: '5', sessionId : "AA5"} ,
			                   	{serverNm: 'WU1', threadId: '6', sessionId : "AA6"} ,
			                   	{serverNm: 'WS1', threadId: '7', sessionId : "AA7"} ,
			                   	{serverNm: 'WU1', threadId: '8', sessionId : "AA8"} ,
			                   	{serverNm: 'WU1', threadId: '9', sessionId : "AA9"} ,
			                   	{serverNm: 'WU1', threadId: '10', sessionId : "AA10"} ,
			                   	{serverNm: 'WS1', threadId: '11', sessionId : "AA11"} ,
			                   	{serverNm: 'WU1', threadId: '12', sessionId : "AA12"} ,
			                   	{serverNm: 'WS1', threadId: '13', sessionId : "AA13"} ,
			                   	{serverNm: 'WU1', threadId: '14', sessionId : "AA14"} ,
			                   	{serverNm: 'WS1', threadId: '15', sessionId : "AA15"} ,
			                   	{serverNm: 'WS1', threadId: '16', sessionId : "AA16"} ,
			                   	{serverNm: 'WU1', threadId: '17', sessionId : "AA17"} ,
			                   	{serverNm: 'WS1', threadId: '18', sessionId : "AA18"}
			                  ];

			var afterArray = [];


			setInterval(function(){
				var mem_per = Math.floor(Math.random() * 100) + 0;
				if (typeof spdmtPushChart == "function") {
					var startTime = (new Date()).getTime();
					var data = "";

					var rnd = Math.floor(Math.random() * 2) + 1;

					if (afterArray.length == 0) {
						rnd = 1;
					} else if (afterArray.length > 10) {
						rnd = 0;
					}

					if (rnd == 1) {

						rnd = Math.floor(Math.random() * 17) + 1;
						var value = beforeArray[rnd];

						afterArray.push(value);

						data = '{"grp": "grp_was_req", "data": {"serverNm": "' + value.serverNm + '" , "threadId": "' + value.threadId + '", "sessionId": "' + value.sessionId + '" , "uri": "/bg-middle.png" , "ip": "127.0.0.1" , "stTime": "' + startTime + '" }}';
						spdmtPushChart($.parseJSON(data));

					} else {

						rnd = Math.floor(Math.random() * afterArray.length);
						
						data = '{"grp": "grp_was_req", "data": {"serverNm": "' + afterArray[rnd].serverNm + '" , "threadId": "' + afterArray[rnd].threadId + '" , "sessionId": "' + afterArray[rnd].sessionId + '" ,  "uri": "/bg-middle.png" , "ip": "127.0.0.1" , "edTime": "' + startTime + '" , "status": "200" }}';
						afterArray.splice(rnd, 1);

						spdmtPushChart($.parseJSON(data));
					}
				}
			}, 50);
			 */
			/*
			setInterval(function(){
				if (typeof tpsPushChart == "function") {
					var startTime = (new Date()).getTime();
					var per = Math.floor(Math.random() * 50) + 0;
					
					var a = "";
					var l = Math.floor(Math.random() * 1000) + 100;
					for (var i=0; i<l; i++) {
						a += ", " + (Math.floor(Math.random() * 5000) + 500);
					}
					a = a.substring(2);
					
					var b = "";
					var l = Math.floor(Math.random() * 100) + 10;
					for (var i=0; i<l; i++) {
						b += ", " + (Math.floor(Math.random() * 5000) + 500);
					}
					b = b.substring(2);
					
					//var data = "{\"grp\": \"grp_tps\", \"period\": \"5000\", \"data\":{\"WU1\": [" + a + "],\"WS1\": [" + b + "]}}";
					var data = "{\"grp\": \"grp_tps\", \"period\": \"5000\", \"data\":{\"WU1\":{\"resTime\":" + (Math.floor(Math.random() * 20) + 1) + ".125,\"tps\":" + (Math.floor(Math.random() * 50) + 1) + ".61}, \"WS1\":{\"resTime\":" + (Math.floor(Math.random() * 50) + 1) + ".125,\"tps\":" + (Math.floor(Math.random() * 20) + 1) + ".61}}}";
					tpsPushChart($.parseJSON(data));
					resTimePushChart($.parseJSON(data));
				}
			}, 3000);
			 */

			/* setInterval(function(){
				if (typeof dsPushChart == "function") {
					var startTime = (new Date()).getTime();
					var per = Math.floor(Math.random() * 100) + 0;
					var data = "{\"grp\": \"grp_was_mem\", \"data\": {\"serverNm\": \"WU1\", \"heapUsedPercent\": \"" + per + "\", \"heapMax\": \"31457280\", \"heapUsed\": \"21667352\", \"nonHeapUsed\": \"34733480\", \"time\": \"" + startTime + "\"}}";
					dsPushChart($.parseJSON(data));

					startTime += 1000;
					per = Math.floor(Math.random() * 50) + 0;
					data = "{\"grp\": \"grp_was_mem\", \"data\": {\"serverNm\": \"WS1\", \"heapUsedPercent\": \"" + per + "\", \"heapMax\": \"31457280\", \"heapUsed\": \"21667352\", \"nonHeapUsed\": \"34733480\", \"time\": \"" + startTime + "\"}}";
					dsPushChart($.parseJSON(data));
				}
			}, 2000); */
			
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