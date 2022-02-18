// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
function ModalCallWithUrl(url, id, formId) {
    $.get(url, { id: id }, function (data, status) {
        $("body").append(data);
        $("#" + formId).modal("show");
        //$.validator.unobtrusive.parse('form');
    });

 
}


$(document).on("click", ".EfaturaPortalApp-datatables-create", function () {
    var element = $(this);
    ModalCallWithUrl(element.data("endpoint"), null, "crud-modal");

});

$(document).on("click", ".EfaturaPortalApp-datatables-update", function () {
    Notiflix.Block.Hourglass($(this).data("loading"), $(this).data("loadmsg"));
    var element = $(this);
    ModalCallWithUrl(element.data("endpoint"), $(this).data("id"), "crud-modal");

});

//$(document).on("click", ".EfaturaPortalApp-CariSec", function () {
//    var element = $(this);
//    ModalCallWithUrl(element.data("endpoint"), $(this).data("id"), "crud-modal");

//});

// Ajax Form OnBegin on
var EfaturaPortalAppOnBegin = function (message) {

    //Block işlemi modala uygulanacaksa prevent işlemi için 
    var selector = '#' + $(this).attr('id');
    if ($(selector + ' .modal-content').length > 0) {
        Notiflix.Block.Standard(selector + ' .modal-content');
    } else {
        Notiflix.Block.Standard('#' + $(this).attr('id'));
    }
};


// Ajax Form OnFailure on
var EfaturaPortalAppOnFailure = function (data) {
    var failMessage = "";
    if (data && data.responseJSON && data.responseJSON.message && data.responseJSON.message.length > 0) {
        failMessage = data.responseJSON.message;
    }
    Notiflix.Notify.Failure(failMessage);
};
// Ajax Form OnFailure off

// Ajax Form OnComplete on
var EfaturaPortalAppOnComplete = function (id, delay, callback) {

    Notiflix.Block.Remove("*", 0);

    if (callback && typeof callback === 'function') {
        callback();
    }



};

$(document).on('hide.bs.modal', '.EfaturaPortalApp-forms-modal', function () {
    $(this).remove();
});

var EfaturaPortalAppOnSuccess = function (data, callback) {
    
    if (data.success) { // api success
        Notiflix.Notify.Success(data.message);

        if (callback && typeof callback === 'function') {

            callback("", data); //first gridId, second data
        }

        // modal close on
        if ($('.EfaturaPortalApp-forms-modal').length > 0) {
            $('.EfaturaPortalApp-forms-modal').modal('hide');
        }
        // modal close off

        // success sonrasi redirectUrl varsa oraya git on
        //if (data.redirectUrl) {
        //    setTimeout(function () {
        //        window.location.href = data.redirectUrl;
        //    }, 1000);
        //}
        // success sonrasi redirectUrl varsa oraya git off
    }
    // api error
    else if (data.success !== undefined && !data.success) {


        Notiflix.Notify.Failure(data.message);

    } else { // api else
        Notiflix.Notify.Failure(data.message);
    }
};

var EfaturaPortalAppOnSuccessWithReport = function (data,callback) {

    if (data.success) { // api success
        Notiflix.Report.Success('Başarılı', data.message, 'Tamam', () => {

            if (callback && typeof callback === 'function') {

                callback("", data); //first gridId, second data
            }
        });

 

        // modal close on
        if ($('.EfaturaPortalApp-forms-modal').length > 0) {
            $('.EfaturaPortalApp-forms-modal').modal('hide');
        }
        // modal close off

        // success sonrasi redirectUrl varsa oraya git on
        //if (data.redirectUrl) {
        //    setTimeout(function () {
        //        window.location.href = data.redirectUrl;
        //    }, 1000);
        //}
        // success sonrasi redirectUrl varsa oraya git off
    }
    // api error
    else if (data.success !== undefined && !data.success) {


        Notiflix.Report.Failure('Hata',data.message,'Tamam');

    } else { // api else
        Notiflix.Report.Failure('Hata',data.message,'Tamam');
    }
};