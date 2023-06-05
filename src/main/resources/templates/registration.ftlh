<#import "blocks/default.ftlh" as c>

<@c.page>
    <div class="form-group col-sm-2 h2">
        Registration
    </div>
    <form action="/registration" method="post">
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Email: </label>
            <div class="col-sm-6">
                <input type="email" name="email" placeholder="Enter your email" class="form-control"/>
                <span style="color: red">${existsEmail!}</span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Username: </label>
            <div class="col-sm-6">
                <input type="text" name="username" placeholder="Enter your username" class="form-control"/>
                <span style="color: red">${existsUsername!}</span>
                <span style="color: red">${usernameLength!}</span>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" placeholder="Enter your password" class="form-control"/>
            </div>
        </div>
        <div class="form-group mt-4">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary ml-3">Create</button>
            <a href="/login" class="col-sm-2">Log in</a>
        </div>
    </form>

    <script>

        const form = document.querySelector('form');
        const inputs = form.querySelectorAll('input[name]');
        function handleSubmit(event) {
            event.preventDefault();


            removeErrorMessages();

            let hasError = false;

            inputs.forEach(input => {
                if (input.value.trim() === '') {
                    displayErrorMessage(input, 'Please enter ' + input.name);
                    hasError = true;
                }
            });

            if (!hasError) {
                form.submit();
            }
        }


        function displayErrorMessage(input, errorMessage) {
            const errorSpan = document.createElement('span');
            errorSpan.style.color = 'red';
            errorSpan.innerText = errorMessage;
            input.parentNode.appendChild(errorSpan);
        }

        function removeErrorMessages() {
            const errorSpans = form.querySelectorAll('span');
            errorSpans.forEach(span => span.remove());
        }

        form.addEventListener('submit', handleSubmit);
    </script>
</@c.page>
