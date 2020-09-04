function checkName() {
  var name = document.getElementById("name");
  var nameOutput = document.getElementById("nameOutput");
  var nameRegex = /^(?![_. ])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_. ])$/
  var validName = name.value.trim().match(nameRegex);

  if(validName != null && name.value.length < 3  ){
    nameOutput.innerHTML = "Too short";
    name.style.backgroundColor= '#EF5761'
    name.style.color= '#FFFFFF'
    name.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (validName != null && name.value.length >= 3 && name.value.length <= 15) {
    name.style.backgroundColor= 'white';
    name.style.color= '#559E54';
    name.style.border= '3px solid #559E54';
    nameOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
  else if (validName != null && name.value.length > 16  ){
    nameOutput.innerHTML = "Too long";
    name.style.backgroundColor= '#EF5761'
    name.style.color= '#FFFFFF'
    name.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (validName == null && name.value.length != 0) {
    nameOutput.innerHTML = "letters and numbers";
    name.style.backgroundColor= '#EF5761'
    name.style.color= '#FFFFFF'
    name.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (name.value.length == 0){
    nameOutput.innerHTML = "";
    name.style.backgroundColor= 'white';
    name.style.color= '#559E54';
    document.getElementById("submit").removeAttribute("disabled")
  }
}

function checkEmail() {
  var email = document.getElementById("email");
  var emailOutput = document.getElementById("emailOutput");
  var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/i;
  var validEmail = email.value.trim().match(emailRegex);

  if(validEmail){
    email.style.backgroundColor= '#FFFFFF'
    email.style.color= '#559E54'
    email.style.border= '3px solid #559E54'
    emailOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
  else if (validEmail == null && email.value.length != 0){
    emailOutput.innerHTML = "Invalid format";
    email.style.backgroundColor= '#EF5761'
    email.style.color= '#FFFFFF'
    email.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (email.value.length == 0){
    emailOutput.innerHTML = "";
    email.style.backgroundColor= 'white';
    email.style.color= '#559E54';
    document.getElementById("submit").removeAttribute("disabled")
  }
}


function checkPassword() {
  var password = document.getElementById("password");
  var passwordOutput = document.getElementById("passwordOutput");

  if(password.value.length < 6 && password.value.length != 0){
    passwordOutput.innerHTML = "At least 6 digits";
    password.style.backgroundColor= '#EF5761'
    password.style.color= '#FFFFFF'
    password.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true");
    passwordConfirm.setAttribute("disabled", "true");
    passwordConfirmOutput.innerHTML = "";
    passwordConfirm.style.backgroundColor= '#e2e2e2'
    passwordConfirm.setAttribute("placeholder", "Enter valid password first") ;
  }
  else if (password.value.length == 0) {
    passwordOutput.innerHTML = "";
    password.style.backgroundColor= '#FFFFFF'
    password.style.color= '#559E54'
    document.getElementById("submit").removeAttribute("disabled");
    passwordConfirm.setAttribute("disabled", "true");
    passwordConfirmOutput.innerHTML = "";
    passwordConfirm.style.backgroundColor= '#e2e2e2'
    passwordConfirm.setAttribute("placeholder", "Enter valid password first") ;
  }
  else {
    passwordOutput.innerHTML = "";
    password.style.backgroundColor= '#FFFFFF'
    password.style.color= '#559E54'
    password.style.border= '3px solid #559E54'
    passwordOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled");
    passwordConfirm.removeAttribute("disabled");
    passwordConfirmOutput.innerHTML = "";
    passwordConfirm.style.backgroundColor= '#FFFFFF'
    passwordConfirm.setAttribute("placeholder", "Confirm Password") ;
  }

}

function checkPasswordConfirm() {
  var password = document.getElementById("password");
  var passwordConfirm = document.getElementById("passwordConfirm");
  var passwordConfirmOutput = document.getElementById("passwordConfirmOutput");

  if(passwordConfirm.value !== password.value && passwordConfirm.value.length != 0){
    passwordConfirmOutput.innerHTML = "Doesn't match";
    passwordConfirm.style.backgroundColor= '#EF5761'
    passwordConfirm.style.color= '#FFFFFF'
    passwordConfirm.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (passwordConfirm.value.length == 0){
    passwordConfirm.setAttribute("disabled", "true");
    passwordConfirmOutput.innerHTML = "";
    passwordConfirm.style.backgroundColor= '#e2e2e2'
    passwordConfirm.setAttribute("placeholder", "Enter valid password first") ;
  }
  else {
    passwordConfirm.style.backgroundColor= '#FFFFFF'
    passwordConfirm.style.color= '#559E54'
    passwordConfirm.style.border= '3px solid #559E54'
    passwordConfirmOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
}

function checkPhone() {
  var phone = document.getElementById("phone");
  var phoneOutput = document.getElementById("phoneOutput");
  var phoneRegex = /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i;
  var validPhone = phone.value.trim().match(phoneRegex);

  if(validPhone != null){
    phone.style.backgroundColor= '#FFFFFF'
    phone.style.color= '#559E54'
    phone.style.border= '3px solid #559E54'
    phoneOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")

  }
  else if (validPhone == null && phone.value.length != 0){
    phoneOutput.innerHTML = "Invalid format";
    phone.style.backgroundColor= '#EF5761'
    phone.style.color= '#FFFFFF'
    phone.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (phone.value.length == 0){
    phoneOutput.innerHTML = "";
    phone.style.backgroundColor= 'white';
    phone.style.color= '#559E54';
    document.getElementById("submit").removeAttribute("disabled")
  }
}

function checkMobile() {
  var mobile = document.getElementById("mobile");
  var mobileOutput = document.getElementById("mobileOutput");
  var mobileRegex = /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i;
  var validMobile = mobile.value.trim().match(mobileRegex);

  if(validMobile != null){
    mobile.style.backgroundColor= '#FFFFFF'
    mobile.style.color= '#559E54'
    mobile.style.border= '3px solid #559E54'
    mobileOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
  else if (validMobile == null && mobile.value.length != 0){
    mobileOutput.innerHTML = "Invalid format";
    mobile.style.backgroundColor= '#EF5761'
    mobile.style.color= '#FFFFFF'
    mobile.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else if (mobile.value.length == 0){
    mobileOutput.innerHTML = "";
    mobile.style.backgroundColor= 'white';
    mobile.style.color= '#559E54';
    document.getElementById("submit").removeAttribute("disabled")
  }

}

