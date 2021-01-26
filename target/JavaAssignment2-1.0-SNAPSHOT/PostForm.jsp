<%--
  Created by IntelliJ IDEA.
  User: arail
  Date: 23.01.2021
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <title>Post</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-4 mx-auto">
                <div style="margin-top: 15vh;" class="d-flex justify-content-center">
                    <h2>Post form</h2>
                </div>
                <form action="PostServlet" method="post">
                    <div class="form-group mb-2">
                        <label>Title</label>
                        <input name="title" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Content</label>
                        <input name="content" type="text" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Accessibility</label>
                        <select name="access" class="form-control">
                            <option value="all">whole internet</option>
                            <option value="authorized">only authorized users</option>
                            <option value="friends">only friends</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Commenting</label>
                        <select name="commenting" class="form-control">
                            <option value="true">Enable</option>
                            <option value="false">Disable</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Post</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
