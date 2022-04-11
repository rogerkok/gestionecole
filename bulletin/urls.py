
from etablissements.views import *
from etablissements  import views
from django.conf.urls.static import static
from csi import settings
from django.urls import  path
from bulletin.views import *
from django.conf.urls.static import static

urlpatterns=[

   #matieres classe
   path('eleve/nouveau/', ELeveCreateView.as_view(), name='eleve_new'),
   path('eleve/<str:pk>', ELeveDetailView.as_view(), name='eleve_show'),
   path('eleve/', ELeveIndexView.as_view(), name='eleve_index'),
   path('eleve/<str:pk>/edit', ELeveUpdateView.as_view(), name='eleve_edit'),
   path('eleve/<str:pk>/matiere', liste_matieres_classe, name='matieres_classe'),
   path('eleves/<str:pk>/eleves', liste_eleves_classe, name='eleves_classe'),
   path('eleve/<str:pk>/eleves', liste_eleves_matiere, name='eleves_matiere'),
   path('notes/<str:pk>/<str:id>/', register_note, name='register_note'),
   path('eleve/<str:pk>/notes', liste_notes_matiere, name='notes_matiere'),
   path('moyenne/<str:pk>/edit', MoyenneUpdateView.as_view(), name='moyenne_edit'),
   path('eleve/<str:pk>/notepdf', notespdf, name='notepdf'),
   path('eleve/<str:pk>/elevebul', liste_notes_eleve, name='elevebul'),
   path('moyenne/<str:pk>/delete', MoyenneDeleteView.as_view(), name='moyenne_delete'),
   path('moyenne/<str:pk>/pdf', bulletins, name='pdf_bul'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
