<#import "blocks/default.ftlh" as c>
<#import "blocks/filter.ftlh" as s>
<#import "blocks/sort.ftlh" as sort>

<#include "blocks/noimage.ftlh">
<@c.page>
    <div class="h2">Games List</div>
    <hr>

<#-- Searching -->
    <#assign filters = ["time","hasTrailer"]>
    <@s.search "/filter" filters>Enter the title</@s.search>


    <div class="d-flex justify-content-center">
        <div class="h6 p-2 bg-light rounded p-2">
            Games found: ${games?size}
        </div>
        <div class="h6 p-2 bg-light rounded ml-2">
            Trailers: ${games?filter(game -> game.hasTrailer())?size}
        </div>
    </div>

<#-- Displays cards with the games -->
    <div class="card-columns">
        <#list games! as game>
            <div class="card my-3">
                <a href="/game/info/${game.id}">
                    <img alt="Preview image" style="object-fit: cover; height: 200px" class="card-img-top"
                         src="${game.previewImageUrl!}" onerror="${noimage}">
                    <div class="m-2">
                        <strong style="font-size: 18px" class="d-flex justify-content-center">${game.title}</strong>
                    </div>
                </a>
                <p style="font-size: 16px; color:grey; text-decoration: none;"
                   class="d-flex justify-content-center">${game.formatDate("dd.MM.yyyy")}</p>
            </div>
        <#else>
            <div class="my-4">
                <div class="h3 text-muted">No games</div>
            </div>
        </#list>
    </div>
</@c.page>