function useFileLoad(inputfile, posturl,name) {


    debugger;
    var filename = name;

    var reader = new FileReader();
    reader.onload = fileLoaded;
    reader.readAsDataURL(inputfile.files[0]);


    function fileLoaded(file) {
    

        var formData = new FormData();

        formData.append("base64file", file.target.result);
        formData.append("fname", filename);

        $.ajax(
            {
                url: posturl,
                data: formData,
                processData: false,
                contentType: false,
                type: "POST",
                success: function (data) {
                    return (data);
                }
            }
        );

 


        // $('div.withBckImage').css({ 'background-image': "url(" + e.target.result + ")" });

    }
}