
from etablissements.views import *
from etablissements  import views
from django.conf.urls.static import static
from csi import settings
from django.urls import  path
from etablissements.views import *

urlpatterns=[
    #établissement
    path('nouveau/ets/', views.newets, name='new_ets'),
    #Direction Régionnale
    path('nouveau/', views.newdre, name='new_dre'),
    # Classe
    path('classe/nouveau/', ClasseCreateView.as_view(), name='classe_new'),
    path('classe/<str:pk>', ClasseDetailView.as_view(), name='classe_show'),
    path('classe/', ClasseIndexView.as_view(), name='classe_index'),
    # Enseignant
    path('enseignant/nouveau/', EnseignantCreateView.as_view(), name='enseignant_new'),
    path('enseignant/<str:pk>', EnseignantDetailView.as_view(), name='enseignant_show'),
    path('enseignant/', EnseignantIndexView.as_view(), name='enseignant_index'),
               #matieres classe
   path('matiere/nouveau/', MatiereCreateView.as_view(), name='matiere_new'),
   path('ematiere/<str:pk>', MatiereDetailView.as_view(), name='matiere_show'),
   path('matiere/', MatiereIndexView.as_view(), name='matiere_index'),
path('ematiere/<str:pk>/edit', MatiereUpdateView.as_view(), name='matiere_edit'),
    # les api
    path(r'^annee/$', views.anneeApi),
    path(r'^annee/([0-9]+)$', views.anneeApi),
    path(r'^matiere/$', views.matiereApi),
    path(r'^matiere/([0-9]+)$', views.matiereApi),
   path(r'^ens/$', views.ensApi),
    path(r'^ens/([0-9]+)$', views.ensApi),
   path(r'^savefile/$', views.savefile)
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)