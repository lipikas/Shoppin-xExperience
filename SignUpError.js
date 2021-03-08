const SignUpButton = document.getElementById("signUp-form-submit");
const SignUpErrorMsg = document.getElementById("SignUp-error-msg");
const SignUpForm = document.getElementById("SignUp-form");
SignUpButton.addEventListener("click", (e) => {
    e.preventDefault();
    const username = SignUpForm.username.value;
    const password = SignUpForm.password.value;
    const name = SignUpForm.name.value;
    const email = SignUpForm.email.value;
    const number = SignUpForm.number.value;

    if (username === "" || password === "" || name === "" || email === "" || number === "") {
        SignUpErrorMsg.style.opacity = 1;
    }
})