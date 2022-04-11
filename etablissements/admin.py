from django.contrib import admin
from .models import *
class AnneeAdmin(admin.ModelAdmin):
    pass
admin.site.register(AnneeScolaire, AnneeAdmin)
admin.site.register(Examen, AnneeAdmin)
admin.site.register(Facultative, AnneeAdmin)
@admin.register(Dre)
class DreAdmin(admin.ModelAdmin):
    list_display=('nom', 'ministere')

@admin.register(Decoupage)
class DecoupageAdmin(admin.ModelAdmin):
    pass
@admin.register(Inspection)
class InspectionAdmin(admin.ModelAdmin):
    list_display=('nom', 'dre')

@admin.register(Etablissement)
class EtablissementAdmin(admin.ModelAdmin):
    list_display=('nom', 'adresse', 'contact','email', 'inspection')

@admin.register(Enseignant)
class EnseignantAdmin(admin.ModelAdmin):
    list_display=('nom', 'prenom', 'etbs')
@admin.register(Classe)
class ClasseAdmin(admin.ModelAdmin):
    pass
admin.site.register(Matiere, AnneeAdmin)
admin.site.register(MatiereClasse, AnneeAdmin)
