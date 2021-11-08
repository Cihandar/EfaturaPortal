// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.



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