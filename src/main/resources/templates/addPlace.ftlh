<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Place</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body>
    <div>
        <nav class="navbar navbar-light bg-light justify-content-between">
            <a class="navbar-brand">All Places</a>
            <form class="form-inline">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
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
                    <form action="/users/registration" method="post">
                        <button type="submit" class="btn btn-secondary">Sign Up</button>
                    </form>
                </div>
                <div class="m-auto">
                    <form action="/users/login" method="get">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </form>
                </div>
            </#if>
        </nav>
    </div>

    <div>
        <div class="main-text">
            <h3>Add New Place</h3>
        </div>
        <div>
            <form action="/places/addNewPlace" method="post" enctype="multipart/form-data">
                <input class="form-control form-control-lg" type="text" name="name" value="${(placeForm.name)!''}"
                       placeholder="name of the place">
                <input class="form-control form-control-lg" type="text" name="description"
                       value="${(placeForm.description)!''}"
                       placeholder="description">
                <label for="exampleFormControlFile1">Choose file</label>
                <input type="file" name="file" id="exampleFormControlFile1">
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <button type="submit" class="btn btn-success">Add new Place</button>
            </form>
        </div>
    </div>
</body>
</html>