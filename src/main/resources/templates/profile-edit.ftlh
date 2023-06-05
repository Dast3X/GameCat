<#import "blocks/default.ftlh" as c>
<#import "blocks/navbar.ftlh" as l>
<#include "blocks/noimage.ftlh">
<#include "blocks/principal.ftlh">

<@c.page>

<#-- Form of editing -->
    <form method="post">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card mt-5">
                    <div class="card-body">
                        <h3 class="card-title text-center">Edit Profile</h3>
                        <hr>
                        <div class="text-center">
                            <img src="${userInfo.avatar!}" onerror="${noimage!}" alt="Avatar"
                                 class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
                        </div>
                        <div class="form-group">
                            <label for="username">Avatar url:</label>
                            <input type="text" class="form-control mt" name="avatar" value="${userInfo.avatar!}">
                        </div>
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" class="form-control" name="username" value="${userInfo.username!}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" name="email" value="${userInfo.email!}">
                        </div>
                        <div class="form-group">
                            <label for="email">New Password:</label>
                            <input type="password" class="form-control" name="password" placeholder="New password">
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button class="btn btn-primary text-white mt-1">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</@c.page>