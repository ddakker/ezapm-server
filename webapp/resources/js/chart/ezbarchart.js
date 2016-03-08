(function($){
	$.fn.ezbarchart = function(opts){
		var options = $.extend({}, $.fn.ezbarchart.defaultOpts, opts);
		//return this.each(function(){
        var $el = $(this);
        
        init(opts.data);
        setData(opts.data);
        //});
        
        if (options.effect) {
        	effect($el);
        }
        
        var chartObj = {};
        chartObj.setData = setData;
        chartObj.modifyData = modifyData;
        return chartObj;
        
        function init(data) {
        	if (options.yAxis.max <= 0) {
	        	$.each(data, function(idx, val){
		        	if (options.yAxis.max < val.y) {
		        		options.yAxis.max = val.y;
		        	}
		        });
        	}
        }
		
		function setData(data) {
			$el.empty();
	        
	        var barLen = data.length
	        var html = "<table width=\"100%\" height=\"100%\"><tr>";
	        $.each(data, function(idx, val){
	        	//var margin = 5;
	        	var width = 100/ barLen;
	        	//var height = (100 - (margin*2));
	        	//$el.append("<div id=\"ezbarchart_x_" + v.x + "\" style=\"width: " + width + "%; height: 100%; float: left; margin: " + margin + "px; border: 1px solid red\">" + v.x + "</div>")
	        	
	        	var padding = 3;
	        	
	        	var barUnitHeight = ($el.height() - (padding * 2)) / (options.yAxis.max + 8);
	        	//if (barUnitHeight < 2) barUnitHeight = 3;
	        	html += "<td width=\"" + width + "%\" height=\"100%\" align=\"center\" valign=\"bottom\" style=\"padding: " + padding + "px; border: 0px solid red\">";
	        	
	        	html += "<div name=\"divEzbarchartColumnVal_" + val.x + "\" style=\"font-size: 8px\">" + val.y + "</div>";
	        	html += "<div name=\"divEzbarchartColumn_" + val.x + "\" yData=\"" + val.y + "\" barUnitHeight=\"" + barUnitHeight + "\">";
	        	for (var i=0; i<val.y; i++) {
	        		html += "<div style=\"height: " + barUnitHeight + "px; border-bottom: 0.5px solid #478000; background-color: #72A133\"></div>";
	        	}
	        	html += "</div>";
	        	html += "<div style=\"font-size: 10px\">" + val.x + "</div>";
	        	html += "</td>";
	        });
	        html += "</tr></table>";
	        $el.html(html);
		}
		
		function modifyData(data) {
			$.each(data, function(idx, value) {
				var x 		= value.x;
				var y 		= value.y;
				var val 	= value.val;
				
				$el.find("div[name='divEzbarchartColumnVal_" + x + "']").html(val);
				
				var column = $el.find("div[name='divEzbarchartColumn_" + x + "']");
				var yData = parseInt(column.attr("yData"));
				var barUnitHeight = parseInt(column.attr("barUnitHeight"));
				column.empty();
				for (var i=0; i<y; i++) {
					column.append("<div style=\"height: " + barUnitHeight + "px; border-bottom: 0.5px solid #478000; background-color: #72A133\"></div>");
				}
				column.attr("yData", y);
			});
		}
		
		function effect($el) {
			setInterval(function(){
				$el.find("div[name^='divEzbarchartColumn']").each(function(){
					if (parseInt($(this).attr("yData")) > 0) {
						$("<div style=\"height: 0px\"></div>").insertAfter($(this).children().eq(0)).animate({
					        height: "3px"
						}, 100, function() {
							$(this).animate({
						        height: "0px"
							}, 500, function() {
								$(this).remove();
							})
						});
					}
					if (parseInt($(this).attr("yData")) > 1) {
					$("<div style=\"height: 0px\"></div>").insertAfter($(this).children().eq(2)).animate({
					        height: "2px"
						}, 100, function() {
							$(this).animate({
						        height: "0px"
							}, 500, function() {
								$(this).remove();
							})
						});
					}
				});
			}, 1000);
		}
	}
	
	$.fn.ezbarchart.defaultOpts = {
		effect : true,
		yAxis: {
			max: -1,
		}
	}


})(jQuery);