from rest_framework import viewsets

from .serializers import HealthFacilitiesSerializer

from .models import HealthFacilites

class HealthFacilitiesViewSet(viewsets.ModelViewSet):
    queryset = HealthFacilites.objects.all()
    serializer_class= HealthFacilitiesSerializer
