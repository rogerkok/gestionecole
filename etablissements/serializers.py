from rest_framework import serializers
from etablissements.models import *
class AnneeScolaireSerializer(serializers.ModelSerializer):
    class Meta:
        model = AnneeScolaire
        fields = (
           'id',
            'nom',
            'date_creation'
        )
class MatiereSerializer(serializers.ModelSerializer):
    class Meta:
        model = Matiere
        fields = (
           'id',
            'nom',
            'date_creation'
        )
class EnseignantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Enseignant
        fields = (
           'id',
            'nom',
           'prenom',
           'sexe',
           'grade',
           'etbs',
           'nationalite',
           'adresse',
           'contact',
           'photo',
            'date_creation'
        )