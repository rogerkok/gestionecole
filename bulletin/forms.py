from django import forms

from .models import *

class EleveForm(forms.ModelForm):
    class Meta:
        model = Eleve
        fields = ['nom', 'prenom', 'sexe','statut', 'classe']

class MoyenneForm(forms.ModelForm):
    class Meta:
        model = MoyenneMatiere
        fields = ['interro', 'devoir', 'compo']
class Moyenne1Form(forms.ModelForm):
    class Meta:
        model = MoyenneMatiere
        fields = ['interro', 'devoir', 'compo', 'eleve','matiere']
