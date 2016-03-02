<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="/WEB-INF/jsp/layout/inc/tags.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" ng-app="AbnTest" >
	<head>
		<title>관리시스템 > <spring:message code="tit.site.nm"/></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		
		<!-- Bootstrap Core CSS -->
	    <link href="/resources/bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
	
	    <!-- <!-- MetisMenu CSS
	    <link href="/resources/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet"> -->
	
	    <!-- <!-- Timeline CSS
	    <link href="../dist/css/timeline.css" rel="stylesheet"> -->
	
	    <!-- Custom CSS -->
	    <link href="/resources/sb-admin/css/sb-admin-2.css" rel="stylesheet">
	
	    <!-- <!-- Morris Charts CSS
	    <link href="/resources/bower_components/morrisjs/morris.css" rel="stylesheet"> -->
	
	    <!-- Custom Fonts -->
	    <link href="/resources/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
	    
	    <link rel="stylesheet" href="/resources/sb-admin/css/abn_tree.css">
	    
	    
	    <!-- jQuery -->
	    <script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
	    

		<decorator:head />
	</head>
	<body ng-controller="AbnTestController" >
		<!-- Head 영역 START-->
		
		<!-- Head 영역 START-->
		<div id="contnet">
			<div class="cont_wrap">
			
			
			
				<div id="wrapper">

			        <!-- Navigation -->
			        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			            <div class="navbar-header">
			                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			                    <span class="sr-only">Toggle navigation</span>
			                    <span class="icon-bar"></span>
			                    <span class="icon-bar"></span>
			                    <span class="icon-bar"></span>
			                </button>
			                <a class="navbar-brand" href="/"><spring:message code="tit.site.nm"/></a>
			            </div>
			            <!-- /.navbar-header -->
			            
			            <ul class="nav navbar-top-links navbar-right">
			            	<li class="dropdown">
			                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
			                        <i class="fa fa-tasks fa-fw"></i>  <i class="fa fa-caret-down"></i>
			                    </a>
			                    <ul class="dropdown-menu dropdown-user">
			                        <li><a id="configLeftMenu" href="#"><i class="fa fa-gear fa-fw"></i> Menu</a></li>
			                        <li class="divider"></li>
			                        <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
			                    </ul>
			                    <!-- /.dropdown-user -->
			                </li>
			            </ul>
			
						<p />
			            <!-- /.navbar-top-links -->
			            <div id="leftMenu" class="navbar-default sidebar" role="navigation" style="display: none">
							<div style="width:250px;margin-left:0px;background:whitesmoke;border:1px solid lightgray;border-radius:5px;">
								<span ng-if="doing_async">...loading...</span>
								<abn-tree tree-data="my_data" tree-control="my_tree" on-select="my_tree_handler(branch)" expand-level="2" initial-selection="Granny Smith"></abn-tree>
							</div>
			            </div>
			            <!-- /.navbar-static-side -->
			        </nav>
			
			        <div id="page-wrapper">
						<decorator:body />
			        </div>
			        <!-- /#wrapper -->
				</div>
			       
			</div>
		</div>
		
		
		
		
	    
	    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.js"></script>
	
 	    <!-- Bootstrap Core JavaScript -->
	    <script src="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<!--	
	    Metis Menu Plugin JavaScript
	    <script src="/resources/bower_components/metisMenu/dist/metisMenu.min.js"></script>
	
	    Morris Charts JavaScript
	    <script src="/resources/bower_components/raphael/raphael-min.js"></script>
	    <script src="/resources/bower_components/morrisjs/morris.min.js"></script>
	    <script src="../js/morris-data.js"></script>
 -->	
	    <!-- Custom Theme JavaScript -->
	    <script src="/resources/sb-admin/js/sb-admin-2.js"></script>
	    
	    <script src="/resources/sb-admin/js/abn_tree_directive.js"></script>
	    <script src="/resources/sb-admin/js/abn_tree_data.js"></script>
		
		<script src="/resources/js/vertx/sockjs-0.3.4.js"></script>
		<script src="/resources/js/vertx/vertx-eventbus.js"></script>
	    
		
	</body>
</html>