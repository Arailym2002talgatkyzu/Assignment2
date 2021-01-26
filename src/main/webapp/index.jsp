<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
            integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/bf20fcd267.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"
            integrity="sha256-1A78rJEdiWTzco6qdn3igTBv9VupN3Q1ozZNTR4WE/Y=" crossorigin="anonymous"></script>
    <title>Home page</title>
</head>
<body class="d-flex">
    <%@include file="header.jsp"%>
    <main style="width: 100vw; margin-bottom: 15vh;" role="main">
        <div class="jumbotron" style="background-color: lightskyblue; text-align: center">
            <div class="container">
                <h1 class="display-3">Posts</h1>
            </div>
        </div>
        <div class="container my-2">
            <sql:query var="posts" dataSource="jdbc/SocialNet">
                SELECT * FROM posts WHERE access='all'
            </sql:query>
            <c:forEach var="post" items="${posts.rows}">
                <div class="row">
                    <div class="col-md-8">
                        <h3 class="display-4"><c:out value="${post.title}"/></h3>
                        <p><c:out value="${post.content}"/></p>
                    </div>
                    <div class="col-md-4">
                        <c:if test="(${post.commenting == true}) && (${not empty sessionScope.user_id})">
                            <div>
                                <button class="open_form btn btn-success" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'block'">Comment</button>
                                <button class="open_form btn btn-danger" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'none'">Uncomment</button>
                            </div>
                            <br>
                            <div>
                                <form id="<c:out value="${post.id}"/>" action="CommentServlet" method="post" style="display: none;">
                                    <div class="form-group"><label>Comment</label><input class="form-control" name="comment" type="text"></div>
                                    <input type="submit" class="btn btn-primary">
                                    <input name="post_id" type="text" style="visibility: hidden;" value="<c:out value="${post.id}"/>">
                                </form>
                            </div>
                            <sql:query var="comments" dataSource="jdbc/SocialNet">
                                SELECT * FROM comments WHERE post_id=<c:out value="${post.id}"/>
                            </sql:query>
                        </c:if>
                        <c:if test="${post.commenting == true}">
                            <div>
                                <button class="close_form btn btn-success" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'block'">Open</button>
                                <button class="close_form btn btn-danger" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'none'">Close</button>
                            </div>
                            <div class="container" id="container<c:out value="${post.id}"/>">
                                <c:forEach var="commentary" items="${comments.rows}">
                                    <div class="comment">
                                        <p><c:out value="${commentary.comment}"/> <sub><c:out value="${commentary.time}"/></sub></p>
                                    </div>
                                    <hr class="my-2">
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </div>
        <hr>
        <c:if test="${not empty sessionScope.name}">
            <div class="container">
                <h2>Posts only for authorized users</h2>
                <sql:query var="posts" dataSource="jdbc/SocialNet">
                    SELECT * FROM posts WHERE access='authorized'
                </sql:query>
                <c:forEach var="post" items="${posts.rows}">
                    <div class="row">
                        <div class="col-md-8">
                            <h3 class="display-4"><c:out value="${post.title}"/></h3>
                            <p><c:out value="${post.content}"/></p>
                        </div>
                        <div class="col-md-4">
                            <c:if test="${post.commenting == true}">
                                <div>
                                    <button class="open_form btn btn-success" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'block'">Comment</button>
                                    <button class="open_form btn btn-danger" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'none'">Uncomment</button>
                                </div>
                                <br>
                                <div>
                                    <form id="<c:out value="${post.id}"/>" action="CommentServlet" method="post" style="display: none;">
                                        <div class="form-group"><label>Comment</label><input class="form-control" name="comment" type="text"></div>
                                        <input type="submit" class="btn btn-primary">
                                        <input name="post_id" type="text" style="visibility: hidden;" value="<c:out value="${post.id}"/>">
                                    </form>
                                </div>
                                <sql:query var="comments" dataSource="jdbc/SocialNet">
                                    SELECT * FROM comments WHERE post_id=<c:out value="${post.id}"/>
                                </sql:query>
                                <div>
                                    <button class="close_form btn btn-success" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'block'">Open</button>
                                    <button class="close_form btn btn-danger" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'none'">Close</button>
                                </div>
                                <div class="container" id="container<c:out value="${post.id}"/>">
                                    <c:forEach var="commentary" items="${comments.rows}">
                                        <div class="comment">
                                            <p><c:out value="${commentary.comment}"/> <sub><c:out value="${commentary.time}"/></sub></p>
                                        </div>
                                        <hr class="my-2">
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
            <hr>
            <div class="container">
                <h2>Posts only for friends</h2>
                <sql:query var="posts" dataSource="jdbc/SocialNet">
                    SELECT posts.* FROM posts,(SELECT friend_id FROM friends WHERE user_id='<c:out value="${sessionScope.user_id}"/>') friendsTable WHERE access='friends' and user_id = friend_id
                </sql:query>
                <c:forEach var="post" items="${posts.rows}">
                    <div class="row">
                        <div class="col-md-8">
                            <h3 class="display-4"><c:out value="${post.title}"/></h3>
                            <p><c:out value="${post.content}"/></p>
                        </div>
                        <div class="col-md-4">
                            <c:if test="${post.commenting == true}">
                                <div>
                                    <button class="open_form btn btn-success" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'block'">Comment</button>
                                    <button class="open_form btn btn-danger" onclick="document.getElementById('<c:out value="${post.id}"/>').style.display = 'none'">Uncomment</button>
                                </div>
                                <br>
                                <div>
                                    <form id="<c:out value="${post.id}"/>" action="CommentServlet" method="post" style="display: none;">
                                        <div class="form-group"><label>Comment</label><input class="form-control" name="comment" type="text"></div>
                                        <input type="submit" class="btn btn-primary">
                                        <input name="post_id" type="text" style="visibility: hidden;" value="<c:out value="${post.id}"/>">
                                    </form>
                                </div>
                                <sql:query var="comments" dataSource="jdbc/SocialNet">
                                    SELECT * FROM comments WHERE post_id=<c:out value="${post.id}"/>
                                </sql:query>
                                <div>
                                    <button class="close_form btn btn-success" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'block'">Open</button>
                                    <button class="close_form btn btn-danger" onclick="document.getElementById('container<c:out value="${post.id}"/>').style.display = 'none'">Close</button>
                                </div>
                                <div class="container" id="container<c:out value="${post.id}"/>">
                                    <c:forEach var="commentary" items="${comments.rows}">
                                        <div class="comment">
                                            <p><c:out value="${commentary.comment}"/> <sub><c:out value="${commentary.time}"/></sub></p>
                                        </div>
                                        <hr class="my-2">
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <hr>
                </c:forEach>
            </div>
        </c:if>
    </main>
    <%@include file="footer.jsp"%>
</body>
</html>