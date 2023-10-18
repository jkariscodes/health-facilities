from rest_framework.routers import DefaultRouter

from .views import HealthFacilitiesViewSet

router = DefaultRouter()

router.register(
    prefix="api/v1/healthfacilities",
    viewset=HealthFacilitiesViewSet,
    basename="healthfacilities",
)

urlpatterns = router.urls
