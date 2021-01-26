<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
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
    <title>User page</title>
</head>
<body>
<%@include file="header.jsp"%>
<div class="container-fluid">
    <h1>Profile</h1>
    <div class="row">
        <div class="col-6">
            <div class="authorized">
                <h2 style="text-align: center">My posts</h2>
                <br/>
                <sql:query var="posts" dataSource="jdbc/SocialNet">
                    SELECT * FROM posts WHERE user_id = <%=session.getAttribute("user_id")%>
                </sql:query>
                <c:forEach var="post" items="${posts.rows}">
                    <div class="post" style="background-color: aqua">
                        <div class="jumbotron p-2" style="background-color: antiquewhite">
                            <h2 class="display-4"><c:out value="${post.title}"/></h2>
                            <hr class="my-4">
                            <p><c:out value="${post.content}"/></p>
                        </div>
                        <div class="mb-2">
                            <div>
                                <button class="open_form btn btn-success" onclick="document.getElementById('form<c:out
                                        value="${post.id}"/>').style.display = 'block'">Update
                                </button>
                                <button class="open_form btn btn-danger"
                                        onclick="document.getElementById('form<c:out
                                                value="${post.id}"/>').style.display = 'none'">
                                    None
                                </button>
                            </div>
                            <br>
                            <div>
                                <form id="form<c:out value="${post.id}"/>" action="UpdatePostServlet" method="post"
                                      style="display: none;">
                                    <label>Accessibility</label>
                                    <select name="access">
                                        <option value="all">whole internet</option>
                                        <option value="authorized">only authorized users</option>
                                        <option value="friends">only friends</option>
                                    </select>
                                    <label>Commenting</label>
                                    <select name="commenting">
                                        <option value="true">Enable</option>
                                        <option value="false">Disable</option>
                                    </select>
                                    <input type="submit" class="btn btn-primary">
                                    <input name="post_id" type="text" style="visibility: hidden;"
                                           value="<c:out value="${post.id}"/>">
                                </form>
                            </div>


                            <div>
                                <button class="close_form btn btn-success"
                                        onclick="document.getElementById('container<c:out
                                                value="${post.id}"/>').style.display = 'block'">Show
                                </button>
                                <button class="close_form btn btn-danger"
                                        onclick="document.getElementById('container<c:out
                                                value="${post.id}"/>').style.display = 'none'">Hide
                                </button>
                            </div>
                            <div class="container" id="container<c:out value="${post.id}"/>">
                                <c:forEach var="commentary" items="${comments.rows}">
                                    <div class="comment">
                                        <p><c:out value="${commentary.comment}"/> <sub><c:out
                                                value="${commentary.time}"/></sub></p>
                                    </div>
                                    <hr class="my-2">
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="col-3">
            <div class="content-panel">
                <h4>Search</h4>
                <input class="form-control" type="text" placeholder="username..." id="search-text">
                <button class="btn btn-primary" id="search-button">Search</button>
                <hr>
                <table id="table" class="table table-striped table-advance table-hover">
                    <tr>
                        <th>Username</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="id" items="${sessionScope.ids}">
                        <sql:query var="users" dataSource="jdbc/SocialNet">
                            SELECT username FROM users WHERE id=<c:out value="${id}"/>
                        </sql:query>
                        <c:forEach var="user" items="${users.rows}">
                            <tr>
                                <td><c:out value="${user.username}"/></td>
                                <td>
                                    <button class="btn-add" data-id="<c:out value="${id}"/>">Add to friends</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="col-3">
            <div class="friend-list">
                <h2>Requests</h2>
                <sql:query var="requests" dataSource="jdbc/SocialNet">
                    SELECT user_id FROM friends WHERE friend_id = <%=session.getAttribute("user_id")%> and status=0
                </sql:query>
                <c:forEach var="request" items="${requests.rows}">
                    <sql:query var="users" dataSource="jdbc/SocialNet">
                        SELECT * FROM users WHERE id=${request.user_id}
                    </sql:query>
                    <c:forEach var="user" items="${users.rows}">
                        <div class="friend">
                            <div class="jumbotron p-2">
                                <h2 class="display-4"><c:out value="${user.username}"/></h2>
                                <button id="accept" data-id="<c:out value="${user.id}"/>">Accept</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:forEach>
                <h2>Friend list</h2>
                <br/>
                <sql:query var="friends" dataSource="jdbc/SocialNet">
                    SELECT * FROM friends WHERE (user_id=${sessionScope.user_id} or friend_id=${sessionScope.user_id}) and status=1
                </sql:query>
                <c:forEach var="friend" items="${friends.rows}">
                    <sql:query var="users" dataSource="jdbc/SocialNet">
                        SELECT username FROM users WHERE (id=${friend.friend_id} or id=${friend.user_id}) and id != ${sessionScope.user_id}
                    </sql:query>
                    <c:forEach var="user" items="${users.rows}">
                        <div class="friend">
                            <div class="jumbotron p-2">
                                <h2 class="display-4"><c:out value="${user.username}"/></h2>
                            </div>
                        </div>
                    </c:forEach>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(".btn-add").click(function () {
            let id = $(this).data("id");
            $.ajax({
                url: "AddFriendServlet",
                type: "post",
                data: {action: "send", friend_id: id},
                cache: false,
                success: function (data) {
                    if (data === 'True') {
                        location.reload();
                    }
                }
            })
        });

        $("#search-button").click(function () {
            let username = $("#search-text").val();
            $.ajax({
                url: "SearchUserServlet",
                type: "post",
                data: {name: username},
                cache: false,
                success: function (data) {
                    if (data === 'True') {
                        location.reload();
                    }
                }
            })
        });

        $("#accept").click(function () {
            let id = $(this).data("id");
            $.ajax({
                url: "AddFriendServlet",
                type: "post",
                data: {action: "accept", friend_id: id},
                cache: false,
                success: function (data) {
                    if (data === 'True') {
                        location.reload();
                    }
                }
            })
        })
    });
</script>
</body>
</html>
