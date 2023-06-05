<#-- Default wrapper over pages -->
<#macro page>
    <!doctype html>
    <html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="icon" type="image/x-icon" href="https://media.discordapp.net/attachments/863720582783696917/1112406787547738243/Layer_1.png">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>GameCat</title>
        <style>
            .scroll-to-top {
                position: fixed;
                bottom: 50px;
                right: 20px;
                display: none;
                height: 40px;
                width: 40px;
                border-radius: 60px;
                font-size: 30px;
            }
        </style>
    </head>
    <body>
    <#include "navbar.ftlh">

    <div style="margin-bottom: 10vh" class="container mt-3">
        <#nested>
    </div>

    <button class=" btn-primary scroll-to-top" title="Go to top"><span style="margin-bottom: 10px">↑</span></button>
    <#include "footer.ftlh">


    <#-- Button to top smooth scroll -->
    <script>
        window.addEventListener('scroll', function () {
            let scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
            let scrollToTopButton = document.querySelector('.scroll-to-top');

            if (scrollPosition > 300) {
                scrollToTopButton.style.display = 'block';
            } else {
                scrollToTopButton.style.display = 'none';
            }
        });
        document.querySelector('.scroll-to-top').addEventListener('click', function () {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
            integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
            crossorigin="anonymous"></script>


    </body>
    </html>
</#macro>


