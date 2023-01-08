<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
	</head>

	<body>
		<div id="addAll">
			<div id="nav">
				<p>Products</p>
			</div>
			<script type="text/javascript">
				function fileChange(){

					$.ajaxFileUpload({
						url: '/prod/ajaxImg.action',
						secureuri: false,
						fileElementId: 'pimage',
						dataType: 'json',
						success: function(obj)
						{

							$("#imgDiv").empty();

							var imgObj = $("<img>");

							imgObj.attr("src","/image_big/"+obj.imgurl);
							imgObj.attr("width","100px");
							imgObj.attr("height","100px");

							$("#imgDiv").append(imgObj);
						},
						error: function (e)
						{
							alert(e.message);
						}
					});
				}
			</script>
<script type="text/javascript">
	function myclose(ispage) {
		window.location="${pageContext.request.contextPath}/admin/product?flag=split&ispage="+ispage;
	}
</script>
			<div id="table">
				<form action="${pageContext.request.contextPath}/prod/update.action" enctype="multipart/form-data" method="post" id="myform">
					<input type="hidden" value="${prod.pId}" name="pId">
					<input type="hidden" value="${prod.pImage}" name="pImage">
					<input type="hidden" value="${page}" name="page">
					<table>
						<tr>
							<td class="one">product name</td>
							<td><input type="text" name="pName" class="two" value="${prod.pName}"></td>
						</tr>
						<tr class="three">
							<td class="four"></td>
							<td><span id="pnameerr"></span></td>
						</tr>
						<tr>
							<td class="one">product description</td>
							<td><input type="text" name="pContent" class="two" value="${prod.pContent}"></td>
						</tr>

						<tr class="three">
							<td class="four"></td>
							<td><span id="pcontenterr"></span></td>
						</tr>
						<tr>
							<td class="one">price</td>
							<td><input type="number" name="pPrice" class="two" value="${prod.pPrice}"></td>
						</tr>

						<tr class="three">
							<td class="four"></td>
							<td><span id="priceerr"></span></td>
						</tr>
						
						<tr>
							<td class="one">image</td>
							<td> <br><div id="imgDiv" style="display:block; width: 40px; height: 50px;"><img src="/image_big/${prod.pImage}" width="100px" height="100px" ></div><br><br><br><br>
								<input type="file" id="pimage" name="pimage" onchange="fileChange()">
								<span id="imgName"></span><br>

							</td>
						</tr>
						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>
						
						<tr>
							<td class="one">number of products</td>
							<td><input type="number" name="pNumber" class="two"  value="${prod.pNumber}"></td>
						</tr>

						<tr class="three">
							<td class="four"></td>
							<td><span id="numerr"></span></td>
						</tr>
						
						
						<tr>
							<td class="one">type</td>
							<td>
								<select name="typeId">
									<c:forEach items="${typeList}" var="type">
										<option value="${type.typeId}"
												<c:if test="${type.typeId==prod.typeId}">
													selected="selected"
												</c:if>
										>${type.typeName}</option>

									</c:forEach>
								</select>
							</td>
						</tr>

						<tr class="three">
							<td class="four"></td>
							<td><span></span></td>
						</tr>

						<tr>
							<td>
								<input type="submit" value="submit" class="btn btn-success">
							</td>
							<td>
								<input type="reset" value="cancel" class="btn btn-default" onclick="myclose(1)">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

	</body>

</html>