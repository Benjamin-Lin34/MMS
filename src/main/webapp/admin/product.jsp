<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">

    function allClick() {

        var flag = $("#all").prop("checked");

        $("input[name='ck']").each(function (){
            this.checked = flag;
        });
    }

    function ckClick() {

        var length=$("input[name=ck]:checked").length;

        var len=$("input[name=ck]").length;

        if(len == length){
            $("#all").prop("checked",true);
        }else
        {
            $("#all").prop("checked",false);
        }
    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>Products</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            product name：<input name="pname" id="pname">&nbsp;&nbsp;&nbsp;
            type：<select name="typeid" id="typeid">
            <option value="-1">choose</option>
            <c:forEach items="${typeList}" var="pt">
                <option value="${pt.typeId}">${pt.typeName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            price：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="search" onclick="condition()">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="new product">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="batch delete" onclick="deleteBatch()">
                </div>

                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>product name</th>
                            <th>product description</th>
                            <th>price</th>
                            <th>image</th>
                            <th>number of products </th>
                            <th></th>
                        </tr>
                        <c:forEach items="${info.list}" var="p"><!--info.-->
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>

                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId})">edit
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId})">delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <li>

                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>

                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>

                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">Total&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;pages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            current&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${info.pageNum==0}">
                                            current&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">Your search did not match any product name</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    function deleteBatch() {

            var cks=$("input[name=ck]:checked");

            if(cks.length == 0){
                alert("Please select the item to be deleted");
            }else{
                var str = "";
                var id = "";

                if(confirm( "Are you sure to delete these" +cks.length+ "items?")){

                    $.each(cks,function (index,item) {
                        pid = $(this).val();

                        if(pid != null){
                            str += pid+",";
                        }
                    });

                   $.ajax({
                       url:"${pageContext.request.contextPath}/prod/deleteBatch.action",
                       data:{"pids":str},
                       type:"post",
                       dataType: "text",
                       success:function (msg){
                           alert(msg);

                           $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table")
                       }
                   })

                }
        }
    }

    function del(pid) {
        if (confirm("confirm to delete?")) {

            $.ajax({
                url:"${pageContext.request.contextPath}/prod/delete.action",
                data:{"pid":pid},
                type: "post",
                dataType:"text",
                success:function (msg){
                    alert(msg);
                    $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table");
                }
            });
        }
    }

    function one(pid, ispage) {
        location.href = "${pageContext.request.contextPath}/prod/one.action?pid=" + pid;
    }
</script>

<script type="text/javascript">
    function ajaxsplit(page) {

        $.ajax({
            url:"${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data:{"page":page},
            type:"post",
            success:function () {

                $("#table").load("http://localhost:8080/admin/product.jsp #table");
            }
        })
    };
    function condition(){
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data:{"pname":pname, "typeid":typeid, "lprice":lprice, "hprice":hprice},
            success:function (){

                $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table")
            }

        })
    }

</script>

</html>