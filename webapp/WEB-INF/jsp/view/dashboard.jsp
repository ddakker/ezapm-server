<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/layout/inc/tags.jspf" %>

	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>

	<script>
		var IS_DUMMY_DATA = true;		
		
		if (IS_DUMMY_DATA == false) {
			var BUS_SOCKJS_CLIENT = "bus.sockjs.client";	
			var eb = new EventBus("http://localhost:9090/eventbus/");
			eb.onopen = function() {
				eb.registerHandler(BUS_SOCKJS_CLIENT, function(err, msg) {
					console.log("msg.body: " + msg.body);
				});
			};
			function send(event) {
				if (event.keyCode == 13 || event.which == 13) {
					var message = $('#input').val();
					if (message.length > 0) {
						eb.publish("chat.to.server", message);
						$('#input').val("");
					}
				}
			}
		} else {
			setInterval(function(){
				var mem_per = Math.floor(Math.random() * 100) + 0;
				var data = "{grp: 'grp_was_mem', data: {serverNm: '', heapUsedPercent: '" + mem_per + "', heapMax: '1882718208', heapUsed: '326188032', nonHeapUsed: '25639144', time: '1456733298864'}}";
				var jsonData = eval("(" + data + ")");
				if (typeof pushMemoryChart == "function") { 
					pushMemoryChart(jsonData);
				}
			}, 5000);
			
			setInterval(function(){
				var mem_per = Math.floor(Math.random() * 100) + 0;
				var data = "{grp: 'grp_was_req', data: {server: 'null' , threadId: '38' , sessionId: 'FEDE85678952F8190570845E12D5E7D7' , uri: '/bg-middle.png' , ip: '127.0.0.1' , stTime: '1456736268795' }}";
				data = "{grp: 'grp_was_req', data: {server: 'null' , threadId: '38' , uri: '/bg-middle.png' , ip: '127.0.0.1' , edTime: '1456736268796' , status: '304' }}";
				var jsonData = eval("(" + data + ")");
				if (typeof pushXViewChart == "function") { 
					pushXViewChart(jsonData);
				}
			}, 5000);
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



