# Generated by Django 4.0 on 2022-03-28 16:47

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        ('etablissements', '0014_inspection_ville'),
    ]

    operations = [
        migrations.AddField(
            model_name='enseignant',
            name='est_chef',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='enseignant',
            name='user',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='enseignant', to='auth.user'),
        ),
        migrations.AddField(
            model_name='etablissement',
            name='activation',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='dre',
            name='adresse',
            field=models.TextField(blank=True),
        ),
        migrations.AlterField(
            model_name='inspection',
            name='adresse',
            field=models.TextField(blank=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]