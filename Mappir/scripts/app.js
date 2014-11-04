var map, featureList = [], visibleFeatures = [], features = [], types = [], icons = {}, isNavBarOpened = false, isLogged = false, estadosSource, filterResult = [];
var container = document.getElementById('popup'), content = document.getElementById('popup-content'), closer = document.getElementById('popup-closer');

$(document).on("click", ".feature-row", function (e) {
    sidebarClick(parseInt($(this).attr('id')));
});

var colors = [
    { normal: 'rgba(225, 39, 22, 1)', high: 'rgba(190, 33, 19, 1)' },
    { normal: 'rgba(30, 136, 216, 1)', high: 'rgba(25, 115, 184, 1)' },
    { normal: 'rgba(65, 171, 22, 1)', high: 'rgba(54, 144, 19, 1)' },
    { normal: 'rgba(253, 220, 2, 1)', high: 'rgba(222, 193, 2, 1)' },
    { normal: '#A700AE', high: 'rgba(138, 0, 143, 1)' }
];
$(document).on("click", "#basemaps input[type='radio']", function (e) {
    var id = $(this).attr('id');
    var i, ii;
    var layers = map.getLayers().getArray();
    for (i = 0, ii = layers.length; i < ii; ++i) {
        if (layers[i].get('style'))
            layers[i].set('visible', (layers[i].get('style') == id));
    }
});

$(document).on("click", ".TOCVisible", function (e) {
    var id = $(this).attr('id');
    var checked = this.checked;
    var i, ii;
    var layers = map.getLayers().getArray();
    for (i = 0, ii = layers.length; i < ii; ++i) {
        if (layers[i].get('name') == id)
            layers[i].set('visible', checked);
    }
    if (id != 'heat') {
        if (!checked) {
            visibleFeatures = visibleFeatures.filter(function (d) {
                return d.Tipo != id;
            });
        }
        else {
            var array = featureList.filter(function (d) {
                return d.Tipo == id;
            });
            array.forEach(function (d) {
                visibleFeatures.push(d);
            });
        }
        filterChanged();
    }
});

$(document).on("click", ".feature-group", function (e) {
    if ($($(this).find('i')).hasClass('fa-chevron-up')) {
        $($(this).find('i')).removeClass('fa-chevron-up');
        $($(this).find('i')).addClass('fa-chevron-down');
        $('.' + $(this).attr('id')).hide();
    }
    else {
        $($(this).find('i')).removeClass('fa-chevron-down');
        $($(this).find('i')).addClass('fa-chevron-up');
        $('.' + $(this).attr('id')).show();
    }
});

$('#dateInicio').datetimepicker({
    dayOfWeekStart: 1,
    lang: 'es',
});

$('#dateFin').datetimepicker({
    dayOfWeekStart: 1,
    lang: 'es',
});

$("#filter-btn").on('input', function () {
    filterChanged();
});

$("#layers-btn").click(function () {
    $("#legend-control").toggle();
});

$('#clear-btn').click(function () {
    $('#filter-btn').val('');
    $('#comboEstados').val('');
    $('#dateInicio').val('');
    $('#dateFin').val('');
    filterChanged();
});

$("#search-btn").click(function () {
    $("#search-form").show();
    $("#search-btn").hide();
});

$("#disable-search-btn").click(function () {
    $("#search-form").hide();
    $("#search-btn").show();
});

$("#about-btn").click(function () {
    $("#aboutModal").modal("show");
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    return false;
});

$("#full-extent-btn").click(function () {
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    map.setView(new ol.View({
        center: ol.proj.transform([-101, 24], 'EPSG:4326', 'EPSG:3857'),
        zoom: 5
    }));
    return false;
});

$("#logout-btn").click(function () {
    if (confirm("\u00BFEst\u00e1 seguro que desea cerrar sesi\u00f3n?"))
        location.reload();
});

$("#legend-btn").click(function () {
    $('#legend-control').toggle();
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    return false;
});

$("#login-btn").click(function () {
    $("#loginModal").modal("show");
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    return false;
});

$("#list-btn").click(function () {
    $('#sidebar').toggle();
    map.updateSize();
    return false;
});

$("#brand-btn").click(function () {
    if (isLogged)
        $('#sidebar').toggle();
    map.updateSize();
    return false;
});

$("#nav-btn").click(function () {
    $(".navbar-collapse").collapse("toggle");
    isNavBarOpened = !isNavBarOpened;
    return false;
});

$("#sidebar-toggle-btn").click(function () {
    if (isLogged)
        $("#sidebar").toggle();
    map.updateSize();
    return false;
});

$("#sidebar-hide-btn").click(function () {
    $('#sidebar').hide();
    map.updateSize();
});

$("#gjson-btn").click(function () {
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    if (filterResult.length > 0) {
        var geojson = '{"type":"FeatureCollection","features":[';
        filterResult.forEach(function (data) {
            geojson += '{"type":"Feature","id":' + data.ID + ',"properties":{"name":"' + data.Nombre + '"},"geometry":{"type":"Point","coordinates":[' + data.Lon + ',' + data.Lat + ']}},';
        });
        geojson = geojson.substring(0, geojson.length - 1);
        geojson += ']}';
        saveAs(new Blob([geojson], { type: "data:application/json;charset=utf-8" }), "poi.geojson");
    }
    else
        alert('\u00A1No hay gr\u00e1ficos para exportar!');
});

$("#kml-btn").click(function () {
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    if (filterResult.length > 0) {
        var kmlstring = '<?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0" xmlns:atom="http://www.w3.org/2005/Atom"><Document><name>POI</name><atom:author><atom:name>Mapa Open Layer</atom:name></atom:author><Folder><name>Points Of Interest</name>';
        filterResult.forEach(function (data) {
            kmlstring += '<Placemark id="' + data.ID + '"><name>' + data.Nombre + '</name><type>' + data.Tipo + '</type><Point><coordinates>' + data.Lon + ',' + data.Lat + ',0</coordinates></Point></Placemark>'
        });
        kmlstring += '</Folder></Document></kml>';
        saveAs(new Blob([kmlstring], { type: "data:application/xml;charset=utf-8" }), "poi.kml");
    } else
        alert('\u00A1No hay gr\u00e1ficos para exportar!');
});

function validateForm() {
    $("#loginError").hide();

    $.ajax({
        url: 'http://<servidor>/info.php',
        type: 'GET',
        timeout: 12000,
        data: {
            user: loginform.username.value,
            pass: loginform.password.value
        },
        success: function (resp) {
            if (resp) {
                isLogged = true;
                $('#sidebar').toggle();
                $(".loggedUser").show();
                $("#loginModal").modal("hide");
                $(".login").hide();
                OnSuccess(resp);
            }
            else
                $("#loginError").show();
        },
        error: function (resp) {
            $("#loginError").show();
        }
    });
    return false;
}

function sidebarClick(id) {
    if (id) {
        featureList.forEach(function (o) {
            if (o.ID == id) {
                var coordinate = ol.proj.transform([o.Lon, o.Lat], 'EPSG:4326', 'EPSG:3857')
                var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326'));
                var text = '';
                text += '<img src="' + o.Icon + '"/>&nbsp;<p style="display:inline;vertical-align:middle;"><strong>Nombre:</strong> ' + o.Nombre + '</p><code style="display:block;">' + hdms + '</code>';
                overlay.setPosition(coordinate);
                content.innerHTML = text
                container.style.display = 'block';
                map.setView(new ol.View({
                    center: coordinate,
                    zoom: map.getView().getZoom()
                }));
            }
        });
    }
}

closer.onclick = function () {
    container.style.display = 'none';
    closer.blur();
    return false;
};

var overlay = new ol.Overlay({
    element: container
});

map = new ol.Map({
    target: 'map',
    overlays: [overlay],
    layers: [
        new ol.layer.Tile({
            style: 'Aerial',
            source: new ol.source.BingMaps({
                imagerySet: 'Aerial',
                key: 'Ak-dzM4wZjSqTlzveKz5u0d4IQ4bRzVI309GxmkgSVr1ewS6iPSrOvOKhA-CJlm3'
            })
        }),
      new ol.layer.Tile({
          style: 'Road',
          visible: false,
          source: new ol.source.MapQuest({ layer: 'osm' })
      }),
      new ol.layer.Tile({
          style: 'AerialWithLabels',
          visible: false,
          source: new ol.source.BingMaps({
              imagerySet: 'AerialWithLabels',
              key: 'Ak-dzM4wZjSqTlzveKz5u0d4IQ4bRzVI309GxmkgSVr1ewS6iPSrOvOKhA-CJlm3'
          })
      }),
      new ol.layer.Tile({
          style: 'Toner',
          source: new ol.source.Stamen({
              layer: 'toner'
          }),
          visible: false
      })
    ],
    view: new ol.View({
        center: ol.proj.transform([-101, 24], 'EPSG:4326', 'EPSG:3857'),
        zoom: 5
    })
});

map.addControl(new ol.control.ZoomSlider());

var styleFunction = function (feature, resolution) {
    return [new ol.style.Style({
        image: new ol.style.Icon(({
            anchor: [0.5, 0.5],
            anchorXUnits: 'fraction',
            anchorYUnits: 'fraction',
            opacity: 1,
            src: feature.attributes.icon
        }))
    })];
}

function OnSuccess(data) {
    estadosSource = new ol.source.KML({
        projection: 'EPSG:3857',
        url: 'data/estados.kml'
    });
    estadosSource.once('change', function () {
        var states = Enumerable.From(estadosSource.getFeatures()).OrderBy(function (d) {
            return d.get('name');
        }).ToArray();
        states.forEach(function (d) {
            var x = document.getElementById("comboEstados");
            var option = document.createElement("option");
            option.text = d.get('name');
            option.value = d.get('name');
            x.add(option);
        });
    });
    var sources = {};
    var heatsource = new ol.source.Vector();
    for (var i = 0; i < data.length; i++) {
        featureList.push(data[i]);
        var point = new ol.Feature({ geometry: new ol.geom.Point(ol.proj.transform([parseFloat(data[i].Lon), parseFloat(data[i].Lat)], 'EPSG:4326', 'EPSG:3857')) });
        point.attributes = {
            type: data[i].Tipo,
            nombre: data[i].Nombre,
            icon: data[i].Icon
        }
        if (sources[data[i].Tipo]) {
            sources[data[i].Tipo].addFeature(point);
        }
        else {
            sources[data[i].Tipo] = new ol.source.Vector();
            sources[data[i].Tipo].addFeature(point);
            icons[data[i].Tipo] = data[i].Icon;
            types.push(data[i].Tipo);
        }
        features.push(point);
        heatsource.addFeature(point);
    }
    visibleFeatures = featureList;
    filterResult = featureList;
    createRows(featureList);
    $("#layer-list tbody").append('<tr class="layer-row"><td style="vertical-align: middle; padding:4px;"><input id="heat" type="checkbox" class="leaflet-control-layers-selector TOCVisible"></td><td style="vertical-align: middle;  padding:0;"><img width="16" height="16" src="images/heatmap.png"></td><td class="feature-name" style="padding:0;vertical-align:middle;">Mapa de Calor</td></tr>');
    types.forEach(function (data) {
        $("#layer-list tbody").append('<tr class="layer-row"><td style="vertical-align: middle; padding:4px;"><input id="' + data + '" type="checkbox" class="leaflet-control-layers-selector TOCVisible" checked></td><td style="vertical-align: middle;  padding:0;"><img width="16" height="16" src="' + icons[data] + '"></td><td class="feature-name" style="padding:0;vertical-align:middle;">' + data + '</td></tr>');
        var vectorLayer = new ol.layer.Vector({
            source: sources[data],
            style: styleFunction,
            name: data
        });
        map.addLayer(vectorLayer);
    });
    var heatlayer = new ol.layer.Heatmap({
        source: heatsource,
        radius: 5,
        visible: false,
        name: 'heat'
    });
    map.addLayer(heatlayer);
}

var displayFeatureInfo = function (pixel) {
    var feature = map.forEachFeatureAtPixel(pixel, function (feature, layer) {
        return feature;
    });

    if (feature) {
        var coordinate = feature.getGeometry().getCoordinates();
        var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(
            coordinate, 'EPSG:3857', 'EPSG:4326'));
        var text = '<img src="' + feature.attributes.icon + '"/>&nbsp;<p style="display:inline;vertical-align:middle;"><strong>Nombre:</strong> ' + feature.attributes.nombre + '</p><code style="display:block;">' + hdms + '</code>';
        overlay.setPosition(coordinate);
        content.innerHTML = text;
        container.style.display = 'block';
    } else {
        container.style.display = 'none';
    }
};

map.on('click', function (evt) {
    if (isNavBarOpened) {
        $(".navbar-collapse").collapse("toggle");
        isNavBarOpened = false;
    }
    displayFeatureInfo(evt.pixel);
});

if (document.body.clientWidth <= 767) {
    var isCollapsed = true;
} else {
    var isCollapsed = false;
}

$("#searchbox").click(function () {
    $(this).select();
});

$(document).one("ajaxStop", function () {
    var bloodhound = new Bloodhound({
        name: "Resultados",
        datumTokenizer: function (d) {
            return Bloodhound.tokenizers.whitespace(d.Nombre);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        local: featureList,
        limit: 10
    });
    bloodhound.initialize();

    $("#searchbox").typeahead({
        minLength: 3,
        highlight: true,
        hint: false
    }, {
        name: 'Resultados',
        displayKey: 'Nombre',
        source: bloodhound.ttAdapter(),
        templates: {
            header: "<h4 class='typeahead-header'><img src='images/match.png' width='24' height='28'>&nbsp;Resultados</h4>",
            suggestion: Handlebars.compile(["<img src='{{Icon}}' width='18' height='18'/>&nbsp;{{Nombre}}"].join(""))
        }
    }).on("typeahead:selected", function (obj, datum) {
        sidebarClick(datum.ID);
        if ($(".navbar-collapse").height() > 50) {
            $(".navbar-collapse").collapse("hide");
        }
    }).on("typeahead:opened", function () {
        $(".navbar-collapse.in").css("max-height", $(document).height() - $(".navbar-header").height());
        $(".navbar-collapse.in").css("height", $(document).height() - $(".navbar-header").height());
    }).on("typeahead:closed", function () {
        $(".navbar-collapse.in").css("max-height", "");
        $(".navbar-collapse.in").css("height", "");
    });
    $(".twitter-typeahead").css("position", "static");
    $(".twitter-typeahead").css("display", "block");
});

function filterChanged() {
    $('#NoMatches').hide();
    filterResult = visibleFeatures;
    var filter = $('#filter-btn').val();
    var estado = $('#comboEstados').val();
    var fechaIni = $('#dateInicio').val();
    var fechaFin = $('#dateFin').val();
    if (estado != '' && estado != undefined && estado != null) {
        filterResult = filterResult.filter(function (data) {
            return (data.Estado == estado);
        })
    }
    if (fechaIni != '' && fechaIni != undefined && fechaIni != null) {
        filterResult = filterResult.filter(function (data) {
            return (Date.parse(data.Fecha) >= Date.parse(fechaIni));
        })
    }
    if (fechaFin != '' && fechaFin != undefined && fechaFin != null) {
        filterResult = filterResult.filter(function (data) {
            return (Date.parse(data.Fecha) <= Date.parse(fechaFin));
        })
    }
    if (filter != '' && filter != undefined && filter != null) {
        filterResult = filterResult.filter(function (data) {
            return (data.Nombre.toLowerCase().indexOf(filter.toLowerCase()) != -1);
        })
    }
    var old_tbody = document.getElementById('features-tbody');
    var new_tbody = document.createElement('tbody');
    new_tbody.className = 'list';
    new_tbody.id = 'features-tbody';
    old_tbody.parentNode.replaceChild(new_tbody, old_tbody);
    createRows(filterResult);
    setLayers(filterResult);
}

function createRows(data) {
    if (data.length > 0) {
        var tipos = Enumerable.From(data).GroupBy(function (x) { return x.Tipo; }).ToArray();
        tipos.forEach(function (j) {
            var tag = j.source[0].Tipo;
            var icon = j.source[0].Icon;
            $("#feature-list tbody").append('<tr id="' + tag + 'Type" class="feature-group"><td style="vertical-align: middle;"><img width="16" height="18" src="' + icon + '"></td><td><strong>' + tag + '</strong></td><td style="vertical-align: middle;"><i class="fa fa-chevron-up pull-right white"></i></td></tr>');
            j.source.forEach(function (i) {
                $("#feature-list tbody").append('<tr class="feature-row ' + i.Tipo + 'Type" id="' + i.ID + '"><td style="vertical-align: middle;"><img width="16" height="18" src="' + i.Icon + '"></td><td class="feature-name">' + i.Nombre + '</td><td style="vertical-align: middle;"><i class="fa fa-chevron-right pull-right green"></i></td></tr>');
            });
        });
    }
    else {
        $('#NoMatches').show();
    }
}

function setLayers(data) {
    var heatSource = new ol.source.Vector();
    var vis;
    types.forEach(function (type) {
        var source = new ol.source.Vector();
        var features = data.filter(function (d) {
            return d.Tipo == type;
        });
        var layers = map.getLayers().getArray();
        for (i = 0, ii = layers.length; i < ii; ++i) {
            if (layers[i].get('name') == type) {
                map.removeLayer(layers[i]);
                features.forEach(function (d) {
                    var point = new ol.Feature({ geometry: new ol.geom.Point(ol.proj.transform([parseFloat(d.Lon), parseFloat(d.Lat)], 'EPSG:4326', 'EPSG:3857')) });
                    point.attributes = {
                        type: d.Tipo,
                        nombre: d.Nombre,
                        icon: d.Icon
                    }
                    source.addFeature(point);
                    heatSource.addFeature(point);
                });

                var vectorLayer = new ol.layer.Vector({
                    source: source,
                    style: styleFunction,
                    name: type
                });
                map.addLayer(vectorLayer);
            }
        }
    });
    map.getLayers().forEach(function (layer) {
        if (layer.get('name') == 'heat') {
            vis = layer.get('visible');
            map.removeLayer(layer);
            var heatlayer = new ol.layer.Heatmap({
                source: heatSource,
                radius: 5,
                visible: vis,
                name: 'heat'
            });
            map.addLayer(heatlayer);
        }
    });
}

$('#chart-btn').click(function () {
    if (filterResult.length > 0) {
        $("#chartModal").modal("show");
        var ctx = document.getElementById('chartCanvas').getContext('2d');
        var divLegend = document.getElementById("legendChart");
        var data = [];
        var i = 0;
        var tipos = Enumerable.From(filterResult).GroupBy(function (x) { return x.Tipo; }).ToArray();
        tipos.forEach(function (j) {
            var tag = j.source[0].Tipo;
            data.push({
                value: j.source.length,
                color: colors[i].normal,
                highlight: colors[i].high,
                label: tag
            });
            i++;
            if (i == 5)
                i = 0;
        });
        var chart = new Chart(ctx).Doughnut(data, {
            scaleShowLabels: true,
            segmentShowStroke: true,
            segmentStrokeColor: "#fff",
            segmentStrokeWidth: 2,
            percentageInnerCutout: 0,
            animationSteps: 100,
            animationEasing: "easeOutBounce",
            animateRotate: true,
            animateScale: true,
            legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"display:inline-block;width:15px;height:15px;background-color:<%=segments[i].fillColor%>;\"></span><%if(segments[i].label){%><%=segments[i].label%> (<%=segments[i].value%>) <%}%></li><%}%></ul>"
        });
        divLegend.innerHTML = chart.generateLegend();
    }
    else {
        alert("No hay nada para gr\u00e1ficar.")
    }
});

$('#sidebar').toggle();
$(".loggedUser").hide();