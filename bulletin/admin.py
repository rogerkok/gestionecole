from django.contrib import admin
from .models import *
class AnneeAdmin(admin.ModelAdmin):
    pass
admin.site.register(Eleve, AnneeAdmin)
admin.site.register(Moyenne, AnneeAdmin)
admin.site.register(MoyenneMatiere, AnneeAdmin)

