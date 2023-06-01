<#-- Navigation bar for all pages -->
<#include "principal.ftlh">
<#import "logout.ftlh" as l>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="/">GameCat</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <#if loggedIn>
            <li class="nav-item">
                <a class="nav-link" href="/user/profile/${user.id!}">My Profile</a>
            </li>
            </#if>
            <#if loggedIn>
            <li class="nav-item">
                <a class="nav-link" href="/game/add">Add game</a>
            </li>
            </#if>
            <#if isAdmin!>
            <li class="nav-item">
                <a class="nav-link" href="/admin/users">User List</a>
            </li>
            </#if>
        </ul>
        <div class="navbar-text mr-3">${username}</div>
            <#if loggedIn = true>
                <@l.logout/>
            </#if>
    </div>
</nav>