from django.contrib.gis.db import models


class HealthFacilites(models.Model):
    name = models.CharField(max_length=80, null=True)
    healthcare = models.CharField(max_length=167, null=True)
    amenity = models.CharField(max_length=80, null=True)
    operatorty = models.CharField(max_length=80, null=True)
    geom = models.MultiPointField(srid=4326)

    class Meta:
        indexes = [models.Index(fields=["geom"], name="geom_index")]

    # def __str__(self):
    #     return self.name
