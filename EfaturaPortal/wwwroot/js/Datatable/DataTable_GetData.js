var GetData = function (url, create, update, clmns) {
    

    var buton = "";

    if (create == "") {
        buton = [

            { extend: 'print', text: 'Listeyi Yazdır' },
            //{ extend: 'copyHtml5', text: 'Kopyala' },
            { extend: 'excelHtml5', text: 'Excel' },
            { extend: 'csvHtml5', text: 'CSV' },
            { extend: 'pdfHtml5', text: 'PDF' },
            // { extend: 'colvis', text: 'Göster' }
        ];
    } else {
        buton = [
            {
                text: 'Yeni Ekle',
                className: 'btn-warning EfaturaPortalApp-datatables-create',
                attr: {
                    "data-endpoint": create,
                    title: "Yeni Ekle"
                },
            },

            { extend: 'print', text: 'Listeyi Yazdır' },
            //{ extend: 'copyHtml5', text: 'Kopyala' },
            { extend: 'excelHtml5', text: 'Excel' },
            { extend: 'csvHtml5', text: 'CSV' },
            { extend: 'pdfHtml5', text: 'PDF' },
            // { extend: 'colvis', text: 'Göster' }
        ];
    }


    $.ajax({
        url: url,
        type: "get",
        dataType: "json",
        complete: function () {

        },
        success: function (data) {
            var dataTable = $('#table').DataTable({
                destroy: true,
                responsive: true,
                dom: "<'row'<'col-sm-8 text-left'B><'col-sm-2 text-right'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'lp>>",
                lengthHappyHour: [[5, 10, 25, 50, -1], ["50 Kayıt", "100 Kayıt", "200 Kayıt", "250 Kayıt", "Hepsi"]],
                pageLength: 50,
                language: {
                    "emptyTable": "Kayıt bulunamadı",
                    "info": "_START_ - _END_ arası kayıtlar",
                    "infoEmpty": "Kayıt bulunamadı",
                    "infoFiltered": "(_MAX_ kayıt arasından filtrelendi)",
                    "lengthHappyHour": "_HappyHour_",
                    "search": "",
                    "searchPlaceholder": "Arama",
                    "zeroRecords": "Kayıt bulunamadı",
                    "lengthMenu": "Gösterilen _MENU_  Kayıt",
                },
                /*order: [[6, 'desc']],*/
                buttons: buton,
                columns: clmns,
                "createdRow": function (row, data, dataIndex) {
                    if (data.iade) {
                        $(row).css({ "background-color": "#FFCFCF" });
                    }
                },
                data: data
            });

            dataTable.on('order.dt search.dt', function () {
                dataTable.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
                    cell.innerHTML = i + 1;
                });
            }).draw();
        }
    });
};