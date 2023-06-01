<#import "blocks/default.ftlh" as c>

<@c.page>
    <div class="form-group">
        <div class="h2 mt-4 mb-4">Add Game</div>

        <#-- Add game form -->
        <form method="post">
            <label class="mt-2">Game title:</label>
            <input class="form-control" type="text" name="title" required/>

            <label class="mt-2">Game 1st description:</label>
            <textarea class="form-control" name="description1" rows="3" required></textarea>

            <label class="mt-2">Game 2nd description:</label>
            <textarea class="form-control" name="description2" rows="3" required></textarea>

            <label class="mt-2">Game preview image:</label>
            <input class="form-control" type="text" name="previewImageUrl" required/>

            <label class="mt-2">Game 1st image:</label>
            <input class="form-control" type="text" name="imageUrl2" required/>

            <label class="mt-2">Game 2nd image:</label>
            <input class="form-control" type="text" name="imageUrl3" required/>

            <label class="mt-2">Game trailer URL (optional):</label>
            <input class="form-control" type="text" name="trailerUrl"/>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input class="btn btn-primary mt-3" type="submit" value="Add"/>
        </form>
    </div>

    <#-- Script for validating descriptions -->
    <script>

        // Get elements from DOM
        let description1 = document.querySelector('textarea[name="description1"]');
        let description2 = document.querySelector('textarea[name="description2"]');
        let submitButton = document.querySelector('input[type="submit"]');
        let errorText1 = document.createElement('div');
        let errorText2 = document.createElement('div');

        // Set error text for descriptions
        errorText1.classList.add('text-danger');
        errorText1.innerText = 'Description must be between 50 and 1000 characters long';
        errorText2.classList.add('text-danger');
        errorText2.innerText = 'Description must be between 50 and 1000 characters long';
        submitButton.disabled = true;

        // Validate description 1
        description1.addEventListener('input', () => {
            if (description1.value.length < 50 || description1.value.length > 1000) {
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

        // Validate description 2
        description2.addEventListener('input', () => {
            if (description2.value.length < 50 || description2.value.length > 1000) {
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

        // Enable submit button if descriptions are valid
        function enableSubmitButton() {
            if (description1.value.length >= 50 && description1.value.length <= 1000 &&
                description2.value.length >= 50 && description2.value.length <= 1000) {
                submitButton.disabled = false;
            }
        }
    </script>
</@c.page>
