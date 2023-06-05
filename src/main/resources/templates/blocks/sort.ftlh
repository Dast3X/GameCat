<#-- Macro for sorting -->
<#macro sort endpoint>
    <span class="sort-label">Sort by:</span>

<#-- For sorting by date -->
    <#if sortedDateAsc=="none">
        <a href="${endpoint}/sortByDateAsc" class="sort-label ml-2">Date</a>
    <#else>
        <#if sortedDateAsc=="true">
            <a href="${endpoint}/sortByDateDesc" class="sort-label ml-2">Date ↓</a>
        <#else>
            <a href="${endpoint}/sortByDateAsc" class="sort-label ml-2">Date ↑</a>
        </#if>
    </#if>

<#-- For sorting by Alphabet-->
    <#if sortedAlphaAsc=="none">
        <a href="${endpoint}/sortByAlphabetAsc" class="sort-label ml-2">Alphabet</a>
    <#else>
        <#if sortedAlphaAsc=="true">
            <a href="${endpoint}/sortByAlphabetDesc" class="sort-label ml-2">Alphabet ↑</a>
        <#else>
            <a href="${endpoint}/sortByAlphabetAsc" class="sort-label ml-2">Alphabet ↓</a>
        </#if>
    </#if>
</#macro>