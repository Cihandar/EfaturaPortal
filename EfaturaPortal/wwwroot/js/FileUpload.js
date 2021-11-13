function GetFileBinary(file) {

    var reader = new FileReader();

    var arrayBuffer = reader.readAsArrayBuffer(file);
    
    array = new Uint8Array(arrayBuffer);

    binaryString = String.fromCharCode.apply(null, array);


    console.log(binaryString);




}
