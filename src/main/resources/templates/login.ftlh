<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/styles.css" type="text/css">
</head>
<body>
    <div class="login-page">
        <div class="form">
            <form class="login-form" action="/users/login" method="post">
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                </#if>

                <input type="text" name="username" value="${(form.email)!''}" placeholder="email"/>
                <input type="password" name="password" value="" placeholder="password"/>
                <button class="login-user">login</button>
                <p class="message">Not registered? <a class="to-sign" href="/users/registration">Create an account</a></p>

            </form>
        </div>
    </div>
</body>