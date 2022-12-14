<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.swing.plaf.nimbus.State" %><%--
  Created by IntelliJ IDEA.
  User: 정유리
  Date: 2022-11-27
  Time: 오후 4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
    <title>내일의집</title>
    <link rel="shortcut icon" href="fabicon/home.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function btn_click(){
            alert('로그인을 하셔야 이용하실 수 있습니다');
            location.href='login.jsp';
        }
    </script>
</head>
<body>
<% // 로그인이 되어있지 않은 사람들만 로그인 회원가입 보이게
    String userId_check = null;
    if(session.getAttribute("userId")	!= null){
        userId_check = (String)session.getAttribute("userId");%>
<%@include file="header_login.jsp"%>
<%}else{%>
<%@include file="header.jsp"%>
<% }%>
<%@ include file="dbconn.jsp"%>
<header class="container mt-3">
    <div class="p-5 mb-4 bg-white rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-start fst-italic">소품/가구 페이지</h1>
        </div>
    </div>
    <%

        Statement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT idx, title, userId, create_dt, hit_cnt, boardNum from board where deleted_yn= 'N' AND boardNum='3' order by idx desc " ;
    %>
    <main class="container mt-5">
        <div class="row">
            <div class="col-sm">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>등록날짜</th>
                        <th>조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try{
                            conn = DriverManager.getConnection(url,user,passwd);
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);

                            while(rs.next()){
                                int idx = rs.getInt("idx");
                                String title = rs.getString("title");
                                String userId = rs.getString("userId");
                                String createDt = rs.getString("create_dt");
                                int hitCnt = rs.getInt("hit_cnt");
                    %>
                    <tr>
                        <td><%=idx%></td>
                        <td><a class="text-decoration-none" href="boardDetail.jsp?idx=<%=idx%>"> <%=title%></a></td>
                        <td><%=userId%></td>
                        <td><%=createDt%></td>
                        <td><%=hitCnt%></td>
                    </tr>
                    <%
                            }
                        }
                        catch (SQLException e) {
                            out.print("SQLException :" +e.getMessage());
                        }
                        finally {
                            if (rs != null) {rs.close();}
                            if (conn != null) {conn.close();}
                            if (stmt != null) {stmt.close();}
                        }
                    %>
                    </tbody>
                </table>
                <% // 로그인이 되어있지 않은 사람들만 로그인 회원가입 보이게
                    userId_check = null;
                    if(session.getAttribute("userId")	!= null){%>
                <div class="d-flex justify-content-end">
                    <a href="boardWrite2.jsp" class="btn btn-primary">글쓰기</a>
                </div>
                <%}else{%>
                <div class="d-flex justify-content-end">
                    <a href="login.jsp" class="btn btn-primary" id="btn-write" onclick="btn_click();">글쓰기</a>
                </div>
                <% }%>
            </div>
        </div>
    </main>
    <%@ include file="footer.jsp"%>
</header>
</body>
</html>
