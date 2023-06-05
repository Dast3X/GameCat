<#-- Macro for searching -->
<#macro search endpoint filters>
    <div class="from-row mt-4">
        <div class="form-group">

            <form method="get" action="${endpoint}" class="form-inline d-flex justify-content-center">
                <input placeholder="<#nested>" type="text" name="filter" class="mt-3 form-control col-7"
                       value="${filter!}">
                <#list filters as currentFilter>

                <#-- Ban filter -->
                    <#if currentFilter == "ban">
                        <select name="filterBan" class="mt-3 form-control ml-2">
                            <option value="">None</option>
                            <option value="true">Banned</option>
                            <option value="false">Not Banned</option>
                        </select>
                    </#if>

                <#-- Role filter -->
                    <#if currentFilter == "role">
                        <select name="filterRole" class="mt-3 form-control ml-2">
                            <option value="">None</option>
                            <option value="ADMIN">Admin</option>
                            <option value="USER">User</option>
                        </select>
                    </#if>

                <#-- time filter -->
                    <#if currentFilter == "time">
                        <select name="filterTime" class="mt-3 form-control ml-2">
                            <option value="">None</option>
                            <option value="Last Hour">Last Hour</option>
                            <option value="Today">Today</option>
                            <option value="This Week">This Week</option>
                            <option value="This Month">This Month</option>
                            <option value="This Year">This Year</option>
                        </select>
                    </#if>

                <#-- has trailer filter -->
                    <#if currentFilter == "hasTrailer">
                        <select name="filterHasTrailer" class="mt-3 form-control ml-2">
                            <option value="">None</option>
                            <option value="true">With Trailer</option>
                            <option value="false">Without Trailer</option>
                        </select>
                    </#if>
                </#list>
                <button type="submit" class=" mt-3 btn btn-primary ml-2">Find</button>
            </form>
        </div>
    </div>

    <script>
        <#if filterBanMemorize??>
        document.querySelector('select[name="filterBan"]').value = '${filterBanMemorize!}';
        </#if>
        <#if filterRoleMemorize??>
        document.querySelector('select[name="filterRole"]').value = '${filterRoleMemorize!}';
        </#if>
        <#if filterTimeMemorize??>
        document.querySelector('select[name="filterTime"]').value = '${filterTimeMemorize!}';
        </#if>
        <#if filterHasTrailerMemorize??>
        document.querySelector('select[name="filterHasTrailer"]').value = '${filterHasTrailerMemorize!}';
        </#if>
    </script>
</#macro>