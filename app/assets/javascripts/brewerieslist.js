var BREWERIES = {};

BREWERIES.show = function(){
    $("#brewery_table tr:gt(0)").remove();

    var table = $("#brewery_table");

    $.each(BREWERIES.list, function (index, brewery) {
        table.append('<tr>'
            +'<td>'+brewery['name']+'</td>'
            +'<td>'+brewery['year']+'</td>'
            +'<td>'+brewery['number_of_beers']+'</td>'
            +'</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        if (a.year > b.year) return 1;
        else if (a.year == b.year) return 0;
        else return -1;
    });
};

BREWERIES.sort_by_number_of_beers = function(){
    BREWERIES.list.sort( function(a,b){
        return b.number_of_beers - a.number_of_beers
    });
};

$(document).ready(function () {
    if ( $("#brewery_table").length>0 ) {

        $("#name").click(function (e) {
            BREWERIES.sort_by_name();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#year").click(function (e) {
            BREWERIES.sort_by_year();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#number_of_beers").click(function (e) {
            BREWERIES.sort_by_number_of_beers();
            BREWERIES.show();
            e.preventDefault();
        });


        $.getJSON('breweries.json', function (breweries) {
            BREWERIES.list = breweries;
            BREWERIES.sort_by_name;
            BREWERIES.show();
        });

    }
});