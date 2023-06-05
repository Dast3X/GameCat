<#import "blocks/default.ftlh" as c>
<#include "blocks/noimage.ftlh">
<#include "blocks/principal.ftlh">
<@c.page>

<#-- Title -->
    <div class="h2 m-5 text-center display-1">
        ${game.title!}
    </div>

<#-- Line -->
    <div class="d-flex justify-content-center align-items-center">
        <img class="w-100"
             src="https://cdn.discordapp.com/attachments/863720582783696917/1109824216381001728/Layer_1.png"
             alt="">
    </div>

    <div class="h1 mt-5">Game description</div>

<#-- Shows 1st description -->
    <div class="mt-5 lead" style="font-weight: 400; overflow-wrap: break-word; text-align: justify">
        ${game.description1!}
    </div>

<#-- Shows 1st image-->
    <div class="d-flex align-items-center mt-3">
        <div class="flex-grow-1">
            <img class="rounded mt-3 w-100" src="${game.imageUrl2!}" onerror="${noimage}" alt="">
        </div>
    </div>

<#-- Shows 2nd description -->
    <div class="mt-5 mb-5 lead" style="font-weight: 400; overflow-wrap: break-word; text-align: justify">
        ${game.description2!}
    </div>

<#-- Shows 2nd image-->
    <div class="d-flex align-items-center mt-3">
        <div class="flex-grow-1">
            <img class="rounded mt-3 w-100" src="${game.imageUrl3!}" onerror="${noimage}" alt="">
        </div>
    </div>

<#-- Shows trialer if exists-->
    <#if game.hasTrailer()>
        <div class="mt-5 mb-5 lead" style="font-weight: 400; overflow-wrap: break-word; text-align: justify">
            Don't miss the chance to immerse yourself in this captivating adventure. Check out the trailer that speaks
            for itself.
        </div>
        <div class="h1 mt-5">Trailer</div>
        <div class="d-flex align-items-center mt-5">
            <div class="flex-grow-1">
                <div class="embed-responsive rounded embed-responsive-16by9">
                    <iframe src="${game.trailerUrl}" class="embed-responsive-item" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </#if>

<#-- Displays the author and date of posting-->
    <div class="pl-0 mt-4 text-start">
        <b>Posted by:</b><br>
        <div class="pl-0 card-body d-flex pb-0">
            <a href="/user/profile/${game.user.id?c}">
                <img src="${game.getAuthorAvatar()!}" onerror="${noimage!}" alt="Avatar"
                     style="width: 60px; height: 60px; border-radius: 50%; margin-right: 10px;">
            </a>
            <div>
                <div class="h5 card-title mb-0">${game.getAuthor()!}</div>
                <div class="card-text text-muted">${game.formatDate("dd.MM.YYYY")}</div>
            </div>
        </div>
    </div>

<#-- Edit and Delete button for author of the post and admin -->
    <#if isAdmin! || game.user.id?c == user.id?c>
        <div class="d-flex justify-content-start mt-5">
            <a href="/game/edit/${game.id?c}" class="btn btn-primary mr-2">Edit</a>
            <button class="btn btn-danger" data-toggle="modal" data-target="#deleteGameModal">Delete</button>
            <form action="/game/delete/${game.id?c}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <div class="modal fade" id="deleteGameModal" tabindex="-1" role="dialog"
                     aria-labelledby="deleteGameModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteGameModalLabel">Confirm Game Deletion</h5>
                                <button class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete this game?
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button class="btn btn-danger">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </#if>

<#-- Write Comment section -->
    <div class="h1 mt-5 mb-5">Comments</div>
    <form method="post">
        <div class="form-group">
            <input type="hidden" name="userId" value="${user.id?c!}">
            <label for="comment">Comment:</label>
            <textarea class="form-control" name="comment" rows="3" placeholder="Leave your comment" required></textarea>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

<#-- Shows comments -->
    <div class="mt-5">
        <#list comments as comment>
            <div class="card mt-3">
                <div class="card-body d-flex pb-0">
                    <a href="/user/profile/${comment.user.id?c}">
                        <img src="${comment.getAuthorAvatar()!}" onerror="${noimage!}" alt="Avatar"
                             style="width: 60px; height: 60px; border-radius: 50%; margin-right: 10px;">
                    </a>
                    <div>
                        <div class="h5 card-title mb-0">${comment.getAuthor()!}</div>
                        <div class="card-text text-muted">${comment.formatDate("dd.MM.YYYY")}</div>
                    </div>
                </div>

                <#if comment.user.id?c == user.id?c || isAdmin>
                    <div class="card-body pt-1 ml-5 pb-0">
                        <div class="card-text ml-4">${comment.text}</div>
                    </div>
                    <div class="card-body pt-1 d-flex">
                        <button class="btn btn-link text-muted" data-toggle="modal"
                                data-target="#editModal${comment.id?c!}">Edit
                        </button>
                        <button class="btn btn-link text-muted" data-toggle="modal"
                                data-target="#deleteModal${comment.id?c!}">Delete
                        </button>
                    </div>
                <#else>
                    <div class="card-body pt-1 ml-5 pb-4">
                        <div class="card-text ml-4">${comment.text}</div>
                    </div>
                </#if>

                <#-- Modal for Deletion -->
                <div class="modal fade" id="deleteModal${comment.id?c!}" tabindex="-1" role="dialog"
                     aria-labelledby="deleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete this comment?
                                <br><br>
                                Comment: ${comment.text}
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <form action="/comment/delete" method="post">
                                    <input type="hidden" name="gameId" value="${game.id?c}"/>
                                    <input type="hidden" name="commentId" value="${comment.id?c}"/>
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <#-- Modal for editing -->
                <div class="modal fade" id="editModal${comment.id?c!}" tabindex="-1" role="dialog"
                     aria-labelledby="editModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel">Edit Comment</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="/comment/edit" method="post">
                                <div class="modal-body">
                                    <textarea name="text" class="form-control">${comment.text}</textarea>
                                </div>

                                <div class="modal-footer">
                                    <button class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <input type="hidden" name="gameId" value="${game.id?c}"/>
                                    <input type="hidden" name="commentId" value="${comment.id?c}"/>
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </#list>
    </div>


</@c.page>
