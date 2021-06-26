<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body>
    <div>
        <nav class="navbar navbar-light bg-light justify-content-between">
            <a class="navbar-brand">All Places</a>
            <form action="/places/addNewPlace" method="get">
                <button type="submit" class="btn btn-danger">Add new Place</button>
            </form>
            <form class="form-inline">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
            <div class="d-flex flex-row">
                <#if user ??>
                    <div class="mt-3">
                        <p>${user.name}</p>
                    </div>
                    <div class="m-auto">
                        <form action="/logout" method="post">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>
                            <button type="submit" class="btn btn-danger">Logout</button>
                        </form>
                    </div>
                <#else >
                    <div class="m-auto">
                        <form action="/users/registration" method="get">
                            <button type="submit" class="btn btn-secondary">Sign Up</button>
                        </form>
                    </div>
                    <div class="m-auto">
                        <form action="/users/login" method="get">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </form>
                    </div>
                </#if>
            </div>
        </nav>
    </div>
    <div class="container">
        <#if places ??>
            <#list places as p>
                <#if photos ??>
                    <#list photos as image>
                        <#if image.place == p>
                            <div class="card" style="width: 18rem;">
                                <img class="card-img-top" src="data:image/jpeg;base64,${image.imageEncoded64}" alt="Card image cap">
                                <div class="card-body">
                                    <h2 class="card-title">${p.name}</h2>
                                    <h6 class="text-muted">Stars: ${p.totalRating}</h6>
                                    <p class="card-text">${p.description}</p>
                                </div>
                                <div>
                                    <form action="/places/precise" method="get">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <#if _csrf??>
                                            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                                        </#if>
                                        <button class="button button-secondary">GO</button>
                                    </form>
                                </div>
                            </div>
                        </#if>
                    </#list>
                </#if>
            </#list>
        </#if>
    </div>
</body>
</html>