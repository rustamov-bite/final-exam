<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Precise Page</title>
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
        <div class="card" style="width: 18rem;">
            <img class="card-img-top" src="data:image/jpeg;base64,${photos[0].imageEncoded64}" alt="Card image cap">
            <div class="card-body">
                <h2 class="card-title"><a href="">${place.name}</a></h2>
                <p class="card-text">${place.description}</p>
            </div>
        </div>
        <div class="d-flex flex-row">
            <#list photos as image>
                <div class="card" style="width: 18rem;">
                    <img class="card-img-top" src="data:image/jpeg;base64,${image.imageEncoded64}" alt="Card image cap">
                </div>
            </#list>
        </div>
    </div>
    <div>
        <h2>Reviews</h2>
        <#if reviews ??>
            <#list reviews as review>
                <div class="card" style="width: 18rem;">
                    <div class="card-body">
                        <h5 class="card-title">Author: ${review.user.name}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">Date: ${review.localDate}</h6>
                        <p class="card-text">${review.reviewDescription}</p>
                        <h6>Stars: ${review.stars}</h6>
                    </div>
                </div>
            </#list>
        </#if>
        <div>
            <h2>Add Review:</h2>
            <div>
                <form action="/reviews/add" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                    </#if>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">With textarea</span>
                        </div>
                        <textarea class="form-control" name="description" aria-label="With textarea"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlSelect2">Example multiple select</label>
                        <select multiple class="form-control" name="stars" id="exampleFormControlSelect2">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                    </div>
                    <input type="hidden" name="placeId" value="${place.id}">
                    <div>
                        <button class="button button-danger" type="submit">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div>
        <form action="/places/uploadPhoto" method="post" enctype="multipart/form-data">
            <label for="exampleFormControlFile1">Choose file</label>
            <input type="file" name="file" id="exampleFormControlFile1">
            <input type="hidden" name="id" value="${place.id}">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
            </#if>
            <button type="submit" class="btn btn-success">Add new Place</button>
        </form>
    </div>
</body>
</html>