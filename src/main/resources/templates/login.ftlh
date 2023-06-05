<#import "blocks/default.ftlh" as c>
<#import "blocks/logout.ftlh" as l>

<@c.page>
    <form action="/login" method="post" xmlns="http://www.w3.org/1999/html">
        <div class="form-group col-sm-2 h2">
            Login
        </div>
        <div class="form-group">
            <div class="col-sm-6 text-danger">${errorMessage!}</div>
            <label class="col-sm-2 col-form-label"> Username: </label>
            <div class="col-sm-6">
                <input type="text" name="username" placeholder="Enter your username" class="form-control" required/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" placeholder="Enter your password" class="form-control" required/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div class="form-group mt-4">
            <button class="btn btn-primary ml-3">Log in</button>
            <a href="/registration" class="col-sm-2">Register</a>
        </div>
    </form>

</@c.page>