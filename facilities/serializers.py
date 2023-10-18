from rest_framework_gis.serializers import GeoFeatureModelSerializer, GeometryField
from .models import HealthFacilites


class HealthFacilitiesSerializer(GeoFeatureModelSerializer):
    geom = GeometryField()

    class Meta:
        model = HealthFacilites
        geo_field = "geom"
        fields = "__all__"
