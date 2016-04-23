/**
 * Created by Павел on 20.04.2016.
 */
function checkForm() {
    var inputEmail = document.getElementById('email').value;
    var msg = '405';
    $.ajax({
        type : "GET",
        contentType : "application/json",
        url : "/hello/is_valid",
        data : ({
            email:  inputEmail
        }),
        dataType : 'json',
        timeout : 100000,
        async : false,
        success : function(data) {
            msg = data.answer;
        }
    });
    if (msg != '200' || inputEmail == null || inputEmail == '') {
        $("#signform").append('<div class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
            ' <strong>Wrong nickname!</strong> Please try another one.</div>');
        return false;
    }
    var pwd = document.getElementById('pwd').value;
    if (pwd == null || pwd == '') {
        $("#signform").append('<div class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
            ' <strong>Wrong password!</strong> Password must not be empty.</div>');
        return false;
    }
}

