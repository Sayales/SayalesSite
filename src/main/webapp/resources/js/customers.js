/**
 * Created by Павел on 23.04.2016.
 */
function deleteMessage(id) {
    var ans = confirm('Are u sure `bout dis?');
    if (ans) {
        window.location.assign("/admin_message_delete?id=" + id);
    }
}
function logOut() {
    document.logOutForm.submit();
}
function showModal(id){
    var modal = $('#messageModal');
    $.ajax({
        type : "GET",
        contentType : "application/json",
        url : "/customers/show_message",
        data : ({
            id: id
        }),
        dataType : 'json',
        timeout : 100000,

        success : function(data) {
            modal.find('#message-text').text(data.text);
        }
    });
    modal.modal();
}