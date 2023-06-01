<#-- Values to get authenticated user principals -->

<#if SPRING_SECURITY_CONTEXT??>
    <#assign
    user = SPRING_SECURITY_CONTEXT.authentication.principal
    username = user.getUsername()
    isAdmin = user.isAdmin()
    loggedIn = true
    />
<#else>
    <#assign
    username = "Guest"
    isAdmin = false
    loggedIn = false
    />
</#if>