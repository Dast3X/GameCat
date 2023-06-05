<#-- logging out -->
<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-sm btn-secondary">Log out</button>
    </form>
</#macro>