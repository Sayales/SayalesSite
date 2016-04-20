/**
 * Created by Павел on 20.04.2016.
 */
function checkForm() {
    const FINE = 'all ok!';
    var email = document.getElementById('email').value;
    var msg = FINE;
    $.ajax({
        type : "POST",
        contentType : "application/json",
        url : "/hello/is_valid",
        data : JSON.stringify(email),
        dataType : 'json',
        timeout : 100000,
        error : function(e) {
            msg = e;
        }
    });
    if (msg != FINE) {
        $("#sickform").append('<div class="alert alert-danger"> <strong>Wrong username!</strong> Please try another one. </div>');
        return false;
    }
    var pwd = document.getElementById('pwd').value;
    if (pwd == null || pwd == '') {
        $("#sickform").append('<div class="alert alert-danger"> <strong>Wrong password!</strong> Password must not be empty. </div>');
        return false;
    }
}