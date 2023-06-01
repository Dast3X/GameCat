<#import "blocks/default.ftlh" as c>
<#import "blocks/navbar.ftlh" as l>
<#include "blocks/noimage.ftlh">
<#include "blocks/principal.ftlh">

<@c.page>

<#-- Confirmation of deletion using modal pop-up window -->
    <div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog"
         aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete your account?
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <a href="/user/delete/${user.id!}" class="btn btn-primary text-white">Delete</a>
                </div>
            </div>
        </div>
    </div>

<#-- Displays data about current user -->
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card mt-5">
                <div class="card-body">
                    <h3 class="card-title text-center">User Profile</h3>
                    <hr>
                    <div class="text-center">
                        <img src="${userInfo.avatar!}" onerror="${noimage!}" alt="Avatar"
                             class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
                    </div>
                    <div class="form-group">
                        <label for="username">Avatar url:</label>
                        <input type="text" class="form-control mt" value="${userInfo.avatar!}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" value="${userInfo.username!}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" value="${userInfo.email!}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="registerDate">Register Date:</label>
                        <input type="text" class="form-control" value="${userInfo.formatDate("dd.MM.yyyy")!}" readonly>
                    </div>

                    <#-- Save and delete buttons -->
                    <#if user.getId() == userInfo.id>
                        <div class="form-group">
                            <a href="/user/edit/${user.id!}" class="btn btn-primary text-white mt-1">Edit</a>
                            <a class="btn btn-primary text-white mt-1" data-toggle="modal"
                               data-target="#deleteConfirmationModal">Delete account</a>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</@c.page>