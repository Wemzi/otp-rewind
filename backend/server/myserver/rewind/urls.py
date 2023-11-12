from django.urls import path, include

from .views import UserApiView, IsReadyView

urlpatterns = [
    path("<int:user_id>", UserApiView.as_view() ),
    path("isReady", IsReadyView.as_view() )
]