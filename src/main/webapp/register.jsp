<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <title>Registration page</title>
</head>
<body>
    <div class="container">
        <p id="response"></p>
        <div class="row">
            <div class="col-4 mx-auto">
                <div style="margin-top: 15vh;" class="d-flex justify-content-center">
                    <h2>Sign up</h2>
                </div>
                <form>
                    <div class="form-group mb-2">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password">
                    </div>
                    <p class="d-none alert alert-danger p-1 w-100 text-center" id="invalid_data"></p>
                    <button type="button" class="btn btn-primary w-100" id="btn_login">Register</button>
                </form>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#btn_login').click(function () {
                let name = $('#name').val();
                let password = $('#password').val();
                if (name.length === 0 || password.length === 0) {
                    $('#invalid_data').removeClass('d-none').text('Username or password empty')
                    return;
                }
                $.ajax({
                    url: "LoginServlet",
                    type: "post",
                    data: {action: 'register', name: name, password: password},
                    cache: false,
                    success: function (data) {
                        if (data === 'True')
                            location.href = 'userpage.jsp';
                        else {
                            $('#invalid_data').removeClass('d-none').text('Invalid username or password');
                            $('#name').val('');
                            $('#password').val('');
                        }
                    }
                })
            })
        })
    </script>
</body>
</html>