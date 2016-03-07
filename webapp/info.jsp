<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.net.InetAddress"%>
<%
	String serverIP = "";
	try{
		serverIP = InetAddress.getLocalHost().getHostAddress();
		serverIP = serverIP.substring(serverIP.lastIndexOf(".")+1);
	}catch(Exception e){}

	String info = request.getServerName() + ", " + serverIP + ", " + System.getProperty("jvmRoute");

	out.print(info);// test
	//System.out.println(info);
%>