function checkName() {
  var name = document.getElementById("name");
  var nameOutput = document.getElementById("nameOutput");
  var nameRegex = /^(?![_. ])(?!.*[_.]{2})[a-zA-Z0-9 ]+(?<![_. ])$/
  var validName = name.value.match(nameRegex);

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
  else if (validName == null) {
    nameOutput.innerHTML = "letters and numbers";
    name.style.backgroundColor= '#EF5761'
    name.style.color= '#FFFFFF'
    name.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
}

function checkEmail() {
  var email = document.getElementById("email");
  var emailOutput = document.getElementById("emailOutput");
  var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/i;
  var validEmail = email.value.match(emailRegex);

  if(validEmail){
    email.style.backgroundColor= '#FFFFFF'
    email.style.color= '#559E54'
    email.style.border= '3px solid #559E54'
    emailOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
  else if (validEmail == null){
    emailOutput.innerHTML = "Invalid format";
    email.style.backgroundColor= '#EF5761'
    email.style.color= '#FFFFFF'
    email.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
}


function checkPassword() {
  var password = document.getElementById("password");
  var passwordOutput = document.getElementById("passwordOutput");

  if(password.value.length < 6){
    passwordOutput.innerHTML = "At least 6 digits";
    password.style.backgroundColor= '#EF5761'
    password.style.color= '#FFFFFF'
    password.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
  else {
    password.style.backgroundColor= '#FFFFFF'
    password.style.color= '#559E54'
    password.style.border= '3px solid #559E54'
    passwordOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
}

function checkPasswordConfirm() {
  var password = document.getElementById("password");
  var passwordConfirm = document.getElementById("passwordConfirm");
  var passwordConfirmOutput = document.getElementById("passwordConfirmOutput");

  if(passwordConfirm.value !== password.value){
    passwordConfirmOutput.innerHTML = "Doesn't match";
    passwordConfirm.style.backgroundColor= '#EF5761'
    passwordConfirm.style.color= '#FFFFFF'
    passwordConfirm.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
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
  var validPhone = phone.value.match(phoneRegex);

  if(validPhone != null){
    phone.style.backgroundColor= '#FFFFFF'
    phone.style.color= '#559E54'
    phone.style.border= '3px solid #559E54'
    phoneOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")

  }
  else if (validPhone == null){
    phoneOutput.innerHTML = "Invalid format";
    phone.style.backgroundColor= '#EF5761'
    phone.style.color= '#FFFFFF'
    phone.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }
}

function checkMobile() {
  var mobile = document.getElementById("mobile");
  var mobileOutput = document.getElementById("mobileOutput");
  var mobileRegex = /^\(?([0-9]{5})?\)?[-.●]?([0-9]{3,4})[-.●]?([0-9]{6,7})$/i;
  var validMobile = mobile.value.match(mobileRegex);

  if(validMobile != null){
    mobile.style.backgroundColor= '#FFFFFF'
    mobile.style.color= '#559E54'
    mobile.style.border= '3px solid #559E54'
    mobileOutput.innerHTML = "<i class='fa fa-check-circle'></i>";
    document.getElementById("submit").removeAttribute("disabled")
  }
  else if (validMobile == null){
    mobileOutput.innerHTML = "Invalid format";
    mobile.style.backgroundColor= '#EF5761'
    mobile.style.color= '#FFFFFF'
    mobile.style.border= '1px solid #ced4da';
    document.getElementById("submit").setAttribute("disabled", "true")
  }

}

