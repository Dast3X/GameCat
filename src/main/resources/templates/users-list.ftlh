<#import "blocks/default.ftlh" as c>
<#include "blocks/noimage.ftlh">
<#include "blocks/principal.ftlh">
<#import "blocks/filter.ftlh" as s>
<#import "blocks/sort.ftlh" as sort>

<@c.page>
    <div class="h2">Users List</div>
    <hr>

<#-- To filter user -->
    <#assign filters = ["ban", "role"]>
    <@s.search "/admin/users/filter" filters>Enter the username</@s.search>

<#-- To sort user -->
    <@sort.sort "/admin/users"></@sort.sort>

<#-- Get the total count of users and admins -->
    <hr>
    <div class="d-flex justify-content-center">
        <div class="h6 p-2 bg-light rounded p-2">
            Users found: ${users?size}
        </div>
        <div class="h6 p-2 bg-light rounded ml-2">
            Admins: ${users?filter(u -> u.isAdmin())?size}
        </div>
    </div>

<#-- User list table -->
    <table class="table table-bordered mt-2">

        <#-- Table headers -->
        <thead>
        <tr>
            <th>Avatar</th>
            <th>ID</th>
            <th>Date</th>
            <th>Username</th>
            <th>Role</th>
            <th>Action</th>
            <th>Active</th>
            <th></th>
        </tr>
        </thead>

        <#-- List users from DB -->
        <tbody>
        <#list users as usr>
            <tr>

                <#-- Avatar Link -->
                <td>
                    <a href="/user/profile/${usr.id?c!}">
                        <img src="${usr.avatar!}" onerror="${noimage}" alt="Avatar" class="img-fluid rounded-circle"
                             style="width: 50px; height: 50px;">
                    </a>
                </td>

                <td>${usr.id?c!}</td>
                <td>${usr.formatDate("dd.MM.yyyy")}</td>
                <td>${usr.username!}</td>

                <#-- Display role -->
                <td>
                    <#if usr.isAdmin()>
                        Admin
                    <#else>
                        User
                    </#if>
                </td>

                <#-- Give admin permission -->
                <td>
                    <#if usr.isActive()>
                        <#if usr.id?c != user.getId()?c>
                            <#if usr.isAdmin()>
                                <form action="/admin/users/revokeAdmin" method="post"
                                      class="mt-2 d-flex justify-content-center">
                                    <input type="hidden" name="userId" value="${usr.id?c!}">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-danger btn-sm">Revoke Admin</button>
                                </form>
                            <#else>
                                <form action="/admin/users/grantAdmin" method="post"
                                      class="mt-2 d-flex justify-content-center">
                                    <input type="hidden" name="userId" value="${usr.id?c!}">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-primary btn-sm">Grant Admin</button>
                                </form>
                            </#if>
                        <#else>
                            <div class="mt-2 d-flex justify-content-center">
                                <div class="btn btn-success btn-sm">
                                    You
                                </div>
                            </div>
                        </#if>
                    </#if>
                </td>

                <#-- Ban or unban user -->
                <td>
                    <#if !usr.isAdmin()>
                        <#if usr.active>
                            <form action="/admin/users/ban" method="post"
                                  class="mt-2 d-flex justify-content-center">
                                <input type="hidden" name="userId" value="${usr.id?c!}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger btn-sm">Ban</button>
                            </form>
                        <#else>
                            <form action="/admin/users/unban" method="post"
                                  class="mt-2 d-flex justify-content-center">
                                <input type="hidden" name="userId" value="${usr.id?c!}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-warning btn-sm">Unban</button>
                            </form>
                        </#if>
                    <#else>
                        <div class="mt-2 d-flex justify-content-center ">
                            <div class="btn btn-sm" style="background-color: #7351ee; color: #fff;">
                                Immunity
                            </div>
                        </div>
                    </#if>
                </td>

                <#-- User deletion with confirmation -->
                <td>
                    <#if !usr.isAdmin()>
                        <form action="/admin/users/delete" method="post" class="mt-2 d-flex justify-content-center">
                            <input type="hidden" name="userId" value="${usr.id?c!}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="button" class="btn font-weight-bold btn-light text-danger btn-sm"
                                    data-toggle="modal" data-target="#deleteUserModal-${usr.id?c!}">X
                            </button>
                            <div class="modal fade" id="deleteUserModal-${usr.id?c!}" tabindex="-1" role="dialog"
                                 aria-labelledby="deleteUserModalLabel-${usr.id?c!}" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="deleteUserModalLabel-${usr.id?c!}">Confirm User
                                                Deletion</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure you want to delete the user "${usr.username}"?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel
                                            </button>
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </#if>
                </td>
            </tr>
        <#else>
            <div class="my-4">
                <div class="h3 text-muted">No user</div>
            </div>
        </#list>
        </tbody>
    </table>

</@c.page>