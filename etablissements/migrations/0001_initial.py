# Generated by Django 4.0 on 2022-02-02 16:38

from django.db import migrations, models
import django.db.models.deletion
import django_countries.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='AnneeScolaire',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=11)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name': 'Année scolaire',
                'verbose_name_plural': 'Années scolaires',
                'db_table': 'annee_scolaire',
            },
        ),
        migrations.CreateModel(
            name='Classe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('serie', models.CharField(choices=[('Col', 'Collège'), ('A4', 'A4'), ('S', 'S'), ('D', 'D'), ('C4', 'C'), ('E', 'E'), ('F2', 'F2'), ('F4', 'F4'), ('G1', 'G1'), ('G2', 'G2'), ('G3', 'G3')], max_length=256)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name': 'Classe',
                'verbose_name_plural': 'Classes',
                'db_table': 'classe',
            },
        ),
        migrations.CreateModel(
            name='Dre',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('ministere', models.TextField(blank=True)),
                ('rep', models.CharField(blank=True, max_length=256, null=True)),
                ('adresse', models.TextField(blank=True, null=True)),
                ('pays', django_countries.fields.CountryField(blank=True, help_text='Pays', max_length=2, null=True)),
                ('contact', models.BigIntegerField(blank=True, null=True)),
                ('email', models.EmailField(blank=True, max_length=50, null=True)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name': 'Direction Régionnale',
                'verbose_name_plural': 'Directions Régionnales',
                'db_table': 'dre',
            },
        ),
        migrations.CreateModel(
            name='Enseignant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('prenom', models.CharField(max_length=256)),
                ('sexe', models.CharField(choices=[('Masculin', 'Masculin'), ('Féminin', 'Féminin')], max_length=256)),
                ('grade', models.CharField(choices=[('PR', 'Professeur'), ('MCA', 'Maitre de conference A'), ('MCB', 'Maitre de conference B'), ('MAA', 'Maitre assistant A'), ('MAB', 'Maitre assistant B'), ('DR', 'Docteur'), ('M', 'Master'), ('M1', 'Master I'), ('L', 'Licence')], max_length=256)),
                ('nationalite', django_countries.fields.CountryField(blank=True, max_length=2, null=True)),
                ('adresse', models.TextField(blank=True, null=True)),
                ('contact', models.CharField(blank=True, max_length=40, null=True)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
                ('photo', models.CharField(blank=True, max_length=100, null=True)),
            ],
            options={
                'verbose_name': 'Enseignant',
                'verbose_name_plural': 'Enseignants',
                'db_table': 'enseignant',
            },
        ),
        migrations.CreateModel(
            name='Matiere',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name': 'Matière',
                'verbose_name_plural': 'Matières',
                'db_table': 'matiere',
            },
        ),
        migrations.CreateModel(
            name='MatiereClasse',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('coef', models.IntegerField(default=1)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
                ('classe', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='matieres', to='etablissements.classe')),
                ('enseigant', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='matieres', to='etablissements.enseignant')),
                ('matiere', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='matieres', to='etablissements.matiere')),
            ],
            options={
                'verbose_name': 'Matière de la classe',
                'verbose_name_plural': 'Matières de la classe',
                'db_table': 'matiere_classe',
            },
        ),
        migrations.CreateModel(
            name='Inspection',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('adresse', models.TextField(blank=True, null=True)),
                ('contact', models.BigIntegerField(blank=True, null=True)),
                ('email', models.EmailField(blank=True, max_length=50, null=True)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
                ('dre', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='inspections', to='etablissements.dre')),
            ],
            options={
                'verbose_name': 'Inspection',
                'verbose_name_plural': 'Inspections',
                'db_table': 'inspection',
            },
        ),
        migrations.CreateModel(
            name='Etablissement',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('adresse', models.TextField(blank=True, null=True)),
                ('contact', models.BigIntegerField(blank=True, null=True)),
                ('email', models.EmailField(blank=True, max_length=50, null=True)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
                ('chef', models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='chefetb', to='etablissements.enseignant')),
                ('inspection', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='etablissements', to='etablissements.inspection')),
            ],
            options={
                'verbose_name': 'Etablissement',
                'verbose_name_plural': 'Etablissements',
                'db_table': 'etablissement',
            },
        ),
        migrations.AddField(
            model_name='enseignant',
            name='etbs',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='enseignants', to='etablissements.etablissement'),
        ),
        migrations.CreateModel(
            name='Decoupage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=256)),
                ('type', models.CharField(blank=True, choices=[('trimestriel', 'Trimestriel'), ('semestriel', 'Semestriel')], max_length=256, null=True)),
                ('periode', models.CharField(max_length=256)),
                ('date_creation', models.DateTimeField(auto_now_add=True)),
                ('anneescolaire', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='decoupages', to='etablissements.anneescolaire')),
            ],
            options={
                'verbose_name': 'Découpage',
                'verbose_name_plural': 'Découpages',
                'db_table': 'decoupage',
            },
        ),
        migrations.AddField(
            model_name='classe',
            name='etbs',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='classes', to='etablissements.etablissement'),
        ),
    ]