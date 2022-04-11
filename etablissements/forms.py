from django import forms

from .models import *

class AnneeForm(forms.ModelForm):
    class Meta:
        model = AnneeScolaire
        fields = ['nom']
class DreForm(forms.ModelForm):
    class Meta:
        model = Dre
        fields = ['nom', 'ministere']
class DecoupageForm(forms.ModelForm):
    class Meta:
        model = Decoupage
        fields = ['periode', 'anneescolaire']
class InspectionForm(forms.ModelForm):
    class Meta:
        model = Inspection
        fields = ['nom', 'dre']
class EtablissementForm(forms.ModelForm):
    class Meta:
        model = Etablissement
        fields = ['nom', 'adresse', 'contact','email', 'inspection']

class EnseignantForm(forms.ModelForm):
    class Meta:
        model = Enseignant
        fields = ['nom', 'prenom', 'etbs']

class ClasseForm(forms.ModelForm):
    class Meta:
        model = Classe
        fields = ['nom', 'serie', 'etbs']
class MatiereClasseForm(forms.ModelForm):
    class Meta:
        model = MatiereClasse
        fields = ['matiere', 'classe', 'enseignant', 'coef']