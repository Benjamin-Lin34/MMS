<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
		<title></title>

		<style type="text/css">
		
		</style>
	</head>

	<body>

		<div id="all">

			<div id="top">
				<div id="top1">
					<span>Merchandise Management System</span>
				</div>
				<div id="top2"></div>
				<div id="top3">
					<span>Welcome，${admin.aName}</span>
				</div>
			</div>

			<div id="bottom">

				<div id="bleft">
					<div id="ltop">
						<div id="lts">
							<img src="${pageContext.request.contextPath}/images/logo.jpg" /><br />
							<p style="text-align: center;">guest</p>
						</div>
					</div>
					<div id="lbottom">
						<ul>
							<a href="${pageContext.request.contextPath}/prod/split.action" target="myright" >
								<li class="two"><span class="glyphicon glyphicon-book" style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;Merchandise&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-play" style="color: white;"></span> </li>
							</a>
						</ul>
					</div>
				</div>

				<div id="bright">
					<iframe frameborder="0" scrolling="no" name="myright" width="1235px" height="700px" ></iframe>
				</div>
			</div>
		</div>
	</body>

</html>