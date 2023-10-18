import os
from django.contrib.gis.utils import LayerMapping
from django.contrib.gis.gdal import DataSource

from facilities.models import HealthFacilites

healthfacilites_mapping = {
    "name": "name",
    "healthcare": "healthcare",
    "amenity": "amenity",
    "operatorty": "operatorty",
    "geom": "MULTIPOINT",
}


def import_data(verbose=True):
    file = os.getcwd() + "/data/health_facilities.gpkg"
    data_source = DataSource(file)
    facilites_layer = data_source[0].name

    facilites_layer_mapping = LayerMapping(
        HealthFacilites, file, healthfacilites_mapping, layer=facilites_layer
    )
    facilites_layer_mapping.save(strict=True, verbose=verbose)
