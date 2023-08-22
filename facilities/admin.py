from django.contrib import admin
from leaflet.admin import LeafletGeoAdmin

from .models import HealthFacilites

class HealthFacilitiesAdmin(LeafletGeoAdmin):
    list_display = ("name", "healthcare")
    

admin.site.register(HealthFacilites, HealthFacilitiesAdmin)
