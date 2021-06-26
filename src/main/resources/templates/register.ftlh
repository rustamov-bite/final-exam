<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/styles.css" type="text/css">
</head>
<body>
    <div class="login-page">
        <div class="login-page">
            <div class="form">
                <form class="register-form d-block" action="/users/registration" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                    </#if>
                    <input type="text" name="name" value="${(form.name)!''}" placeholder="name"/>
                    <input type="password" name="password" value="" placeholder="password"/>
                    <input type="text" name="email" value="${(form.email)!''}" placeholder="email address"/>
                    <button class="register-user" type="submit">create</button>
                    <p class="message">Already registered? <a class="to-login" href="/users/login">Sign In</a></p>
                    <#if errors?? >
                        <p>Входные данные с ошибками!</p>
                        <#list errors as fieldError>
                            <p>${fieldError.field} - ${fieldError.defaultMessage!'-- no message --'}</p>
                        </#list>
                    </#if>
                </form>
            </div>
        </div>
    </div>
</body>
</html>