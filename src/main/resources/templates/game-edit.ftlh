<#import "blocks/default.ftlh" as c>

<@c.page>
    <div class="form-group">
        <div class="h2 mt-4 mb-4">Edit Game</div>
        <form method="post">
            <label class="mt-2">Game title:</label>
            <input class="form-control" type="text" name="title" value="${game.title!}" required/>

            <label class="mt-2">Game description:</label>
            <textarea class="form-control" name="description1" rows="3" required>${game.description1!}</textarea>

            <label class="mt-2">Game description2:</label>
            <textarea class="form-control" name="description2" rows="3" required>${game.description2!}</textarea>

            <label class="mt-2">Game main image:</label>
            <input class="form-control" type="text" name="previewImageUrl" value="${game.previewImageUrl!}" required/>

            <label class="mt-2">Game 1st image:</label>
            <input class="form-control" type="text" name="imageUrl2" value="${game.imageUrl2!}" required/>

            <label class="mt-2">Game 2nd image:</label>
            <input class="form-control" type="text" name="imageUrl3" value="${game.imageUrl3!}" required/>

            <label class="mt-2">Game trailer URL:</label>
            <input class="form-control" type="text" name="trailerUrl" value="${game.trailerUrl!}"/>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input class="btn btn-primary mt-3" type="submit" value="Save"/>
        </form>
    </div>

    <script>
        let description1 = document.querySelector('textarea[name="description1"]');
        let description2 = document.querySelector('textarea[name="description2"]');
        let submitButton = document.querySelector('input[type="submit"]');
        let errorText1 = document.createElement('div');
        let errorText2 = document.createElement('div');
        errorText1.classList.add('text-danger');
        errorText1.innerText = 'Description must be between 50 and 1000 characters long';
        errorText2.classList.add('text-danger');
        errorText2.innerText = 'Description must be between 50 and 1000 characters long';
        submitButton.disabled = false;
        description1.addEventListener('input', () => {
            if (description1.value.length < 50 || description1.value.length > 1000) {
                submitButton.disabled = true;
                if (description1.nextSibling !== null) {
                    description1.parentNode.insertBefore(errorText1, description1.nextSibling);
                }
            } else {
                if (errorText1.parentNode !== null) {
                    errorText1.remove();
                }
                enableSubmitButton();
            }
        });

        description2.addEventListener('input', () => {
            if (description2.value.length < 50 || description2.value.length > 1000) {
                submitButton.disabled = true;
                if (description2.nextSibling !== null) {
                    description2.parentNode.insertBefore(errorText2, description2.nextSibling);
                }
            } else {
                if (errorText2.parentNode !== null) {
                    errorText2.remove();
                }
                enableSubmitButton();
            }
        });

        function enableSubmitButton() {
            if (description1.value.length >= 50 && description1.value.length <= 1000 &&
                description2.value.length >= 50 && description2.value.length <= 1000) {
                submitButton.disabled = false;
            }
        }
    </script>
</@c.page>
