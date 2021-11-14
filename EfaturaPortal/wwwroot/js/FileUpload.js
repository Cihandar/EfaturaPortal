function useFileLoad(inputfile, posturl) {

 
    filename = inputfile.files[0].name;

    var reader = new FileReader();
    reader.onload = fileLoaded;
    reader.readAsDataURL(inputfile.files[0], filename, posturl);


    function fileLoaded(file, filename, posturl) {


        var formData = new FormData();

        formData.append("base64file", file.target.result);
        formData.append("Iname", filename);

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

        return null;


        // $('div.withBckImage').css({ 'background-image': "url(" + e.target.result + ")" });

    }
}