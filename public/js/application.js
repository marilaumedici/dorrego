$(document).ready(function(){
    $('#searchButton').click(search);
    $('#newButton').click(showNewForm);
    $('#saveButton').click(saveChanges);
});

function search(){
    var key = $('#searchBox').val();
    $.ajax({
        url:'/search',
        type:"GET",
        data:{key:key},
        success:function (data) {
            $('#key').val(data.key);
            $('#value').val(data.value);
            $('#noteModal').modal('show');
        },
        error:function (msg) {
            alert('Item not found');
        }
    });

}

function showNewForm(){
    $('#key').val('');
    $('#value').val('');
    $('#noteModal').modal('show');
}

function saveChanges(){
    var key = $('#key').val();
    var value = $('#value').val();
    $.ajax({
        url:'/new',
        type:"POST",
        data:{key:key, value:value},
        success:function (data) {
            if(data=='success') {
                showMessage('success', 'Changes successfully saved');
            }else {
                showMessage('error', data);
            }
        },
        error:function (msg) {
            showMessage('error', 'An error occur during the operation');
        }
    });
    $('#noteModal').modal('hide');
}

function showMessage (type, message) {
    $("#alert-area").append($("<div id='alert-message' class='alert alert-" + type + " fade in' data-alert><a class='close' data-dismiss='alert'>×</a><p> " + message + " </p></div>"));
    $("#alert-message").delay(2000).fadeOut("slow", function () { $(this).remove(); });
}