from django.db import models

class Moyenne(models.Model):


    moy = models.FloatField(blank=True, null=True)
    rang = models.IntegerField(blank=True, null=True)

    periode = models.ForeignKey('etablissements.Decoupage', related_name='moyennes',
                                      on_delete=models.CASCADE, null=True)
    date_creation = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.moy
    class Meta:
        db_table = "moyenne"
        verbose_name = "Moyenne"
        verbose_name_plural = "Moyennes"

class MoyenneMatiere(models.Model):

    interro = models.FloatField(blank=True, null=True)
    devoir = models.FloatField(blank=True, null=True)
    compo = models.FloatField( null=True)
    moycl = models.FloatField(blank=True, null=True)
    moymat = models.FloatField(blank=True, null=True)
    moycoef = models.FloatField(blank=True, null=True)
    rang= models.IntegerField(blank=True, null=True)
    matiere = models.ForeignKey('etablissements.MatiereClasse', related_name='moyennesclasse',
                                      on_delete=models.CASCADE, null=True)
    eleve = models.ForeignKey('bulletin.Eleve', related_name='moyennes',
                              on_delete=models.CASCADE, null=True)
    date_creation = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.interro.__str__()+""+self.devoir.__str__()+""+self.compo.__str__()+""+self.moycoef.__str__()
    def calcule_moy(self):
        self.moycl = float(round((self.interro+ self.devoir) / 2, 0))
        self.moymat = float(round((self.moycl + self.compo) / 2, 2))
        self.moycoef = round(self.moymat * self.matiere.coef, 2)
        self.save()


    class Meta:
        db_table = "moyenne_matiere"
        verbose_name = "Moyenne du Matière"
        verbose_name_plural = "Moyennes des Matières"
        ordering= ['-moymat']

class Eleve(models.Model):
    #user = models.OneToOneField('auth.User', related_name='enseignant')

    nom = models.CharField(max_length=256)
    prenom = models.CharField(max_length=256)
    sexe = models.CharField(choices=(('Masculin', 'Masculin'), ('Féminin', 'Féminin')), max_length=256, null=True)
    STATUT = (('Nouveau', 'Nouveau'),
             ('Nouvelle', 'Nouvelle'),
             ('Redoublant', 'Redoublant'),
             ('Redoublante', 'Redoublante'))
    statut = models.CharField(choices=STATUT, max_length=256, null=True)
    classe= models.ForeignKey('etablissements.Classe', related_name='eleves',
                            on_delete=models.CASCADE, null=True)
    photo = models.FileField(upload_to="eleves", blank=True, null=True)
    moy1 = models.FloatField(blank=True, null=True)
    tot1 = models.FloatField(blank=True, null=True)
    totcoef = models.IntegerField(blank=True, null=True)
    moy2 = models.FloatField(blank=True, null=True)
    moy3 = models.FloatField(blank=True, null=True)
    rang1 = models.IntegerField(blank=True, null=True)
    rang2 = models.IntegerField(blank=True, null=True)
    rang3 = models.IntegerField(blank=True, null=True)
    #nationalite = CountryField(blank=True, null=True)
    #adresse = models.TextField(blank=True, null=True)
    #contact = models.CharField(max_length=256, blank=True, null=True)
    date_creation = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.id.__str__() + " " + self.nom.upper() + " " + self.prenom

    class Meta:
        db_table = "eleve"
        verbose_name = "Elève"
        verbose_name_plural = "Elèves"
