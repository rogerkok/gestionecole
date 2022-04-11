BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "annee_scolaire" (
	"id"	integer NOT NULL,
	"nom"	varchar(11) NOT NULL,
	"date_creation"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "matiere" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"date_creation"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "matiere_classe" (
	"id"	integer NOT NULL,
	"coef"	integer NOT NULL,
	"date_creation"	datetime NOT NULL,
	"classe_id"	bigint,
	"matiere_id"	bigint,
	"enseignant_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("classe_id") REFERENCES "classe"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("matiere_id") REFERENCES "matiere"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("enseignant_id") REFERENCES "enseignant"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "decoupage" (
	"id"	integer NOT NULL,
	"type"	varchar(256),
	"periode"	varchar(256) NOT NULL,
	"date_creation"	datetime NOT NULL,
	"anneescolaire_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("anneescolaire_id") REFERENCES "annee_scolaire"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "moyenne" (
	"id"	integer NOT NULL,
	"moy"	real,
	"rang"	integer,
	"date_creation"	datetime NOT NULL,
	"periode_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("periode_id") REFERENCES "decoupage"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "moyenne_matiere" (
	"id"	integer NOT NULL,
	"interro"	real,
	"devoir"	real,
	"compo"	real,
	"moycl"	real,
	"moymat"	real,
	"moycoef"	real,
	"date_creation"	datetime NOT NULL,
	"matiere_id"	bigint,
	"eleve_id"	bigint,
	"rang"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("eleve_id") REFERENCES "eleve"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("matiere_id") REFERENCES "matiere_classe"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "classe" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"serie"	varchar(256) NOT NULL,
	"date_creation"	datetime NOT NULL,
	"etbs_id"	bigint,
	"titulaire_id"	bigint UNIQUE,
	"eff"	integer,
	"moygen"	real,
	"moygen1"	real,
	"moygen2"	real,
	"moygen3"	real,
	"max"	real,
	"max1"	real,
	"max2"	real,
	"max3"	real,
	"min"	real,
	"min1"	real,
	"min2"	real,
	"min3"	real,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("titulaire_id") REFERENCES "enseignant"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("etbs_id") REFERENCES "etablissement"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "eleve" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"prenom"	varchar(256) NOT NULL,
	"sexe"	varchar(256),
	"statut"	varchar(256),
	"date_creation"	datetime NOT NULL,
	"classe_id"	bigint,
	"moy1"	real,
	"moy2"	real,
	"moy3"	real,
	"rang1"	integer,
	"rang3"	integer,
	"rang2"	integer,
	"tot1"	real,
	"totcoef"	integer,
	"photo"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("classe_id") REFERENCES "classe"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "examen" (
	"id"	integer NOT NULL,
	"date_creation"	datetime NOT NULL,
	"periode_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("periode_id") REFERENCES "decoupage"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "examen_classe" (
	"id"	integer NOT NULL,
	"examen_id"	bigint NOT NULL,
	"classe_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("classe_id") REFERENCES "classe"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("examen_id") REFERENCES "examen"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "facultative" (
	"id"	integer NOT NULL,
	"iscomp"	bool NOT NULL,
	"coef"	integer NOT NULL,
	"date_creation"	datetime NOT NULL,
	"matiere_id"	bigint,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("matiere_id") REFERENCES "matiere"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "facultative_classe" (
	"id"	integer NOT NULL,
	"facultative_id"	bigint NOT NULL,
	"classe_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("facultative_id") REFERENCES "facultative"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("classe_id") REFERENCES "classe"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "enseignant" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"prenom"	varchar(256) NOT NULL,
	"sexe"	varchar(256) NOT NULL,
	"grade"	varchar(256) NOT NULL,
	"nationalite"	varchar(2),
	"adresse"	text,
	"contact"	varchar(40),
	"date_creation"	datetime NOT NULL,
	"photo"	varchar(100),
	"etbs_id"	bigint,
	"est_chef"	bool NOT NULL,
	"user_id"	integer UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("etbs_id") REFERENCES "etablissement"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "etablissement" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"adresse"	text,
	"contact"	bigint,
	"email"	varchar(50),
	"date_creation"	datetime NOT NULL,
	"chef_id"	bigint UNIQUE,
	"inspection_id"	bigint,
	"logo"	varchar(100),
	"plan"	varchar(100),
	"bp"	varchar(20),
	"activation"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("inspection_id") REFERENCES "inspection"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("chef_id") REFERENCES "enseignant"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "dre" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"ministere"	text NOT NULL,
	"rep"	varchar(256),
	"pays"	varchar(2),
	"contact"	bigint,
	"email"	varchar(50),
	"date_creation"	datetime NOT NULL,
	"drapeau"	varchar(100),
	"adresse"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "inspection" (
	"id"	integer NOT NULL,
	"nom"	varchar(256) NOT NULL,
	"contact"	bigint,
	"email"	varchar(50),
	"date_creation"	datetime NOT NULL,
	"dre_id"	bigint,
	"ville"	varchar(50),
	"adresse"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("dre_id") REFERENCES "dre"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-02-02 17:06:39.339716');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2022-02-02 17:06:39.455719');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2022-02-02 17:06:39.514715');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2022-02-02 17:06:39.583309');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2022-02-02 17:06:39.642309');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2022-02-02 17:06:39.738309');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2022-02-02 17:06:39.806308');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2022-02-02 17:06:39.853311');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2022-02-02 17:06:39.880302');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2022-02-02 17:06:39.920303');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2022-02-02 17:06:39.935303');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2022-02-02 17:06:39.977317');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2022-02-02 17:06:40.043310');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2022-02-02 17:06:40.088306');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2022-02-02 17:06:40.139312');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2022-02-02 17:06:40.181324');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2022-02-02 17:06:40.227311');
INSERT INTO "django_migrations" VALUES (18,'etablissements','0001_initial','2022-02-02 17:06:40.634306');
INSERT INTO "django_migrations" VALUES (19,'bulletin','0001_initial','2022-02-02 17:06:40.825050');
INSERT INTO "django_migrations" VALUES (20,'sessions','0001_initial','2022-02-02 17:06:40.883039');
INSERT INTO "django_migrations" VALUES (21,'etablissements','0002_rename_enseigant_matiereclasse_enseignant_and_more','2022-02-03 09:01:08.414993');
INSERT INTO "django_migrations" VALUES (22,'etablissements','0003_remove_decoupage_nom','2022-02-03 13:20:07.752113');
INSERT INTO "django_migrations" VALUES (23,'etablissements','0004_alter_etablissement_contact','2022-02-03 13:33:43.634497');
INSERT INTO "django_migrations" VALUES (24,'bulletin','0002_alter_moyenne_moy_alter_moyennematiere_compo_and_more','2022-02-08 07:28:07.821745');
INSERT INTO "django_migrations" VALUES (25,'bulletin','0003_remove_moyennematiere_moy','2022-02-08 07:38:58.528077');
INSERT INTO "django_migrations" VALUES (26,'bulletin','0004_eleve_moy1_eleve_moy2_eleve_moy3','2022-02-08 07:42:06.847515');
INSERT INTO "django_migrations" VALUES (27,'bulletin','0005_remove_moyenne_eleve_moyennematiere_eleve_and_more','2022-02-09 15:12:39.956865');
INSERT INTO "django_migrations" VALUES (28,'bulletin','0006_eleve_rang1_eleve_rang3_moyennematiere_rang','2022-02-17 16:38:42.208748');
INSERT INTO "django_migrations" VALUES (29,'bulletin','0007_eleve_rang2','2022-02-17 16:38:42.275744');
INSERT INTO "django_migrations" VALUES (30,'bulletin','0008_alter_moyennematiere_options_eleve_tot1_and_more','2022-02-20 07:31:50.680280');
INSERT INTO "django_migrations" VALUES (31,'etablissements','0005_classe_titulaire_dre_drapeau_etablissement_logo','2022-03-01 06:55:32.834514');
INSERT INTO "django_migrations" VALUES (32,'etablissements','0006_classe_eff_classe_moygen_classe_moygen1_and_more','2022-03-03 14:52:52.147723');
INSERT INTO "django_migrations" VALUES (33,'etablissements','0007_classe_max_classe_max1_classe_max2_classe_max3_and_more','2022-03-03 17:04:08.389529');
INSERT INTO "django_migrations" VALUES (34,'bulletin','0009_alter_eleve_photo','2022-03-04 05:50:43.911713');
INSERT INTO "django_migrations" VALUES (35,'etablissements','0008_etablissement_plan_alter_enseignant_photo','2022-03-04 05:50:44.031708');
INSERT INTO "django_migrations" VALUES (36,'etablissements','0009_alter_dre_drapeau_alter_etablissement_logo_and_more','2022-03-04 13:41:24.720530');
INSERT INTO "django_migrations" VALUES (37,'etablissements','0010_examen','2022-03-04 17:21:42.217367');
INSERT INTO "django_migrations" VALUES (38,'etablissements','0011_alter_examen_classe','2022-03-04 17:21:42.288367');
INSERT INTO "django_migrations" VALUES (39,'etablissements','0012_alter_examen_classe','2022-03-04 17:23:44.319072');
INSERT INTO "django_migrations" VALUES (40,'etablissements','0013_etablissement_bp_facultative','2022-03-07 04:32:40.052430');
INSERT INTO "django_migrations" VALUES (41,'etablissements','0014_inspection_ville','2022-03-07 05:46:48.723535');
INSERT INTO "django_migrations" VALUES (42,'etablissements','0015_enseignant_est_chef_enseignant_user_and_more','2022-03-28 16:47:39.701279');
INSERT INTO "auth_group_permissions" VALUES (1,1,1);
INSERT INTO "auth_group_permissions" VALUES (2,1,2);
INSERT INTO "auth_group_permissions" VALUES (3,1,3);
INSERT INTO "auth_group_permissions" VALUES (4,1,4);
INSERT INTO "auth_group_permissions" VALUES (5,1,5);
INSERT INTO "auth_group_permissions" VALUES (6,1,6);
INSERT INTO "auth_group_permissions" VALUES (7,1,7);
INSERT INTO "auth_group_permissions" VALUES (8,1,8);
INSERT INTO "auth_group_permissions" VALUES (9,1,9);
INSERT INTO "auth_group_permissions" VALUES (10,1,10);
INSERT INTO "auth_group_permissions" VALUES (11,1,11);
INSERT INTO "auth_group_permissions" VALUES (12,1,12);
INSERT INTO "auth_group_permissions" VALUES (13,1,13);
INSERT INTO "auth_group_permissions" VALUES (14,1,14);
INSERT INTO "auth_group_permissions" VALUES (15,1,15);
INSERT INTO "auth_group_permissions" VALUES (16,1,16);
INSERT INTO "auth_group_permissions" VALUES (17,1,17);
INSERT INTO "auth_group_permissions" VALUES (18,1,18);
INSERT INTO "auth_group_permissions" VALUES (19,1,19);
INSERT INTO "auth_group_permissions" VALUES (20,1,20);
INSERT INTO "auth_group_permissions" VALUES (21,1,21);
INSERT INTO "auth_group_permissions" VALUES (22,1,22);
INSERT INTO "auth_group_permissions" VALUES (23,1,23);
INSERT INTO "auth_group_permissions" VALUES (24,1,24);
INSERT INTO "auth_group_permissions" VALUES (25,1,25);
INSERT INTO "auth_group_permissions" VALUES (26,1,26);
INSERT INTO "auth_group_permissions" VALUES (27,1,27);
INSERT INTO "auth_group_permissions" VALUES (28,1,28);
INSERT INTO "auth_group_permissions" VALUES (29,1,29);
INSERT INTO "auth_group_permissions" VALUES (30,1,30);
INSERT INTO "auth_group_permissions" VALUES (31,1,31);
INSERT INTO "auth_group_permissions" VALUES (32,1,32);
INSERT INTO "auth_group_permissions" VALUES (33,1,33);
INSERT INTO "auth_group_permissions" VALUES (34,1,34);
INSERT INTO "auth_group_permissions" VALUES (35,1,35);
INSERT INTO "auth_group_permissions" VALUES (36,1,36);
INSERT INTO "auth_group_permissions" VALUES (37,1,37);
INSERT INTO "auth_group_permissions" VALUES (38,1,38);
INSERT INTO "auth_group_permissions" VALUES (39,1,39);
INSERT INTO "auth_group_permissions" VALUES (40,1,40);
INSERT INTO "auth_group_permissions" VALUES (41,1,41);
INSERT INTO "auth_group_permissions" VALUES (42,1,42);
INSERT INTO "auth_group_permissions" VALUES (43,1,43);
INSERT INTO "auth_group_permissions" VALUES (44,1,44);
INSERT INTO "auth_group_permissions" VALUES (45,1,45);
INSERT INTO "auth_group_permissions" VALUES (46,1,46);
INSERT INTO "auth_group_permissions" VALUES (47,1,47);
INSERT INTO "auth_group_permissions" VALUES (48,1,48);
INSERT INTO "auth_group_permissions" VALUES (49,1,49);
INSERT INTO "auth_group_permissions" VALUES (50,1,50);
INSERT INTO "auth_group_permissions" VALUES (51,1,51);
INSERT INTO "auth_group_permissions" VALUES (52,1,52);
INSERT INTO "auth_group_permissions" VALUES (53,1,53);
INSERT INTO "auth_group_permissions" VALUES (54,1,54);
INSERT INTO "auth_group_permissions" VALUES (55,1,55);
INSERT INTO "auth_group_permissions" VALUES (56,1,56);
INSERT INTO "auth_group_permissions" VALUES (57,1,57);
INSERT INTO "auth_group_permissions" VALUES (58,1,58);
INSERT INTO "auth_group_permissions" VALUES (59,1,59);
INSERT INTO "auth_group_permissions" VALUES (60,1,60);
INSERT INTO "auth_group_permissions" VALUES (61,1,61);
INSERT INTO "auth_group_permissions" VALUES (62,1,62);
INSERT INTO "auth_group_permissions" VALUES (63,1,63);
INSERT INTO "auth_group_permissions" VALUES (64,1,64);
INSERT INTO "auth_group_permissions" VALUES (65,1,65);
INSERT INTO "auth_group_permissions" VALUES (66,1,66);
INSERT INTO "auth_group_permissions" VALUES (67,1,67);
INSERT INTO "auth_group_permissions" VALUES (68,1,68);
INSERT INTO "auth_group_permissions" VALUES (69,1,69);
INSERT INTO "auth_group_permissions" VALUES (70,1,70);
INSERT INTO "auth_group_permissions" VALUES (71,1,71);
INSERT INTO "auth_group_permissions" VALUES (72,1,72);
INSERT INTO "auth_group_permissions" VALUES (73,2,25);
INSERT INTO "auth_group_permissions" VALUES (74,2,26);
INSERT INTO "auth_group_permissions" VALUES (75,2,27);
INSERT INTO "auth_group_permissions" VALUES (76,2,28);
INSERT INTO "auth_group_permissions" VALUES (77,2,29);
INSERT INTO "auth_group_permissions" VALUES (78,2,30);
INSERT INTO "auth_group_permissions" VALUES (79,2,31);
INSERT INTO "auth_group_permissions" VALUES (80,2,32);
INSERT INTO "auth_group_permissions" VALUES (81,2,35);
INSERT INTO "auth_group_permissions" VALUES (82,2,37);
INSERT INTO "auth_group_permissions" VALUES (83,2,38);
INSERT INTO "auth_group_permissions" VALUES (84,2,39);
INSERT INTO "auth_group_permissions" VALUES (85,2,45);
INSERT INTO "auth_group_permissions" VALUES (86,2,46);
INSERT INTO "auth_group_permissions" VALUES (87,2,47);
INSERT INTO "auth_group_permissions" VALUES (88,2,48);
INSERT INTO "auth_group_permissions" VALUES (89,2,57);
INSERT INTO "auth_group_permissions" VALUES (90,2,58);
INSERT INTO "auth_group_permissions" VALUES (91,2,59);
INSERT INTO "auth_group_permissions" VALUES (92,2,60);
INSERT INTO "auth_group_permissions" VALUES (93,2,61);
INSERT INTO "auth_group_permissions" VALUES (94,2,62);
INSERT INTO "auth_group_permissions" VALUES (95,2,63);
INSERT INTO "auth_group_permissions" VALUES (96,2,64);
INSERT INTO "auth_group_permissions" VALUES (97,2,65);
INSERT INTO "auth_group_permissions" VALUES (98,2,66);
INSERT INTO "auth_group_permissions" VALUES (99,2,67);
INSERT INTO "auth_group_permissions" VALUES (100,2,68);
INSERT INTO "auth_group_permissions" VALUES (101,2,69);
INSERT INTO "auth_group_permissions" VALUES (102,2,70);
INSERT INTO "auth_group_permissions" VALUES (103,2,71);
INSERT INTO "auth_group_permissions" VALUES (104,2,72);
INSERT INTO "auth_group_permissions" VALUES (105,3,68);
INSERT INTO "auth_group_permissions" VALUES (106,3,69);
INSERT INTO "auth_group_permissions" VALUES (107,3,70);
INSERT INTO "auth_group_permissions" VALUES (108,3,71);
INSERT INTO "auth_group_permissions" VALUES (109,3,72);
INSERT INTO "auth_group_permissions" VALUES (110,4,64);
INSERT INTO "auth_group_permissions" VALUES (111,4,68);
INSERT INTO "auth_group_permissions" VALUES (112,4,72);
INSERT INTO "auth_group_permissions" VALUES (113,4,52);
INSERT INTO "auth_group_permissions" VALUES (114,4,61);
INSERT INTO "auth_group_permissions" VALUES (115,4,62);
INSERT INTO "auth_group_permissions" VALUES (116,4,63);
INSERT INTO "auth_user_groups" VALUES (1,3,3);
INSERT INTO "django_admin_log" VALUES (1,'2022-02-02 17:19:28.605842','1','1 FRANÇAIS','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2022-02-02 17:19:37.673258','2','2 ANGLAIS','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (3,'2022-02-02 17:19:45.959316','3','3 ALLEMAND','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2022-02-02 17:20:02.974723','4','4 HISTO-GEO','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (5,'2022-02-02 17:20:23.226131','5','5 SVT','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2022-02-02 17:20:33.360929','6','6 PHYSIQUE CHIMIE TECHNOLOGIE','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2022-02-02 17:21:01.938997','7','7 MATHÉMATIQUE','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (8,'2022-02-02 17:21:17.156253','8','8 ECM','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (9,'2022-02-02 17:21:24.160529','9','9 EPS','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (10,'2022-02-02 17:22:00.877815','10','10 SCIENCES-PHYSIQUES','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (11,'2022-02-03 10:59:26.900721','1','drr','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (12,'2022-02-03 10:59:55.172635','1','drr','',9,1,3);
INSERT INTO "django_admin_log" VALUES (13,'2022-02-03 11:00:48.072822','2','ssd','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (14,'2022-02-03 12:28:21.241986','2','Grand Lomé','[{"changed": {"fields": ["Nom", "Ministere"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (15,'2022-02-03 13:13:58.221967','1','Golfe Est','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (16,'2022-02-03 13:15:52.734842','1','2021-2022','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (17,'2022-02-03 13:23:47.805219','1','Premier Trimestre','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" VALUES (18,'2022-02-03 22:56:04.445024','1','1 6ÈME Col','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (19,'2022-02-03 22:56:47.095944','2','2 5ÈME Col','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (20,'2022-02-03 22:57:19.164552','3','3 4ÈME Col','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (21,'2022-02-03 22:57:51.420403','4','4 3ÈME Col','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (22,'2022-02-08 10:26:32.354717','15','15 NOUTOHOU Kossi Elom','',16,1,3);
INSERT INTO "django_admin_log" VALUES (23,'2022-02-08 10:53:38.608964','1','Administrateur','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" VALUES (24,'2022-02-08 10:58:58.945454','2','Chef','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" VALUES (25,'2022-02-08 11:00:44.898884','3','Enseignant','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" VALUES (26,'2022-02-08 11:04:46.752068','4','Eleve','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" VALUES (27,'2022-02-08 11:05:56.824210','1','roger','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (28,'2022-02-09 07:18:14.661350','17','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (29,'2022-02-09 07:18:14.678348','16','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (30,'2022-02-09 07:18:14.695352','15','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (31,'2022-02-09 07:18:14.713353','14','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (32,'2022-02-09 07:18:14.732348','13','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (33,'2022-02-09 07:18:14.749348','12','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (34,'2022-02-09 07:18:14.764344','11','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (35,'2022-02-09 07:18:14.782343','10','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (36,'2022-02-09 07:18:14.815343','9','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (37,'2022-02-09 07:18:14.832350','8','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (38,'2022-02-09 07:18:14.851347','7','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (39,'2022-02-09 07:18:14.869358','6','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (40,'2022-02-09 07:18:14.893357','5','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (41,'2022-02-09 07:18:14.915362','4','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (42,'2022-02-09 07:18:14.936350','3','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (43,'2022-02-09 07:18:14.954350','2','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (44,'2022-02-09 07:18:14.970351','1','11.012.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (45,'2022-02-09 07:42:47.110117','19','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (46,'2022-02-09 07:42:47.128120','18','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (47,'2022-02-09 08:03:48.562939','20','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (48,'2022-02-09 09:43:07.027960','32','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (49,'2022-02-09 09:43:07.062959','31','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (50,'2022-02-09 09:43:07.088957','30','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (51,'2022-02-09 09:43:07.105957','29','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (52,'2022-02-09 09:43:07.122960','28','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (53,'2022-02-09 09:43:07.157957','27','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (54,'2022-02-09 09:43:07.205960','26','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (55,'2022-02-09 09:43:07.222958','25','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (56,'2022-02-09 09:43:07.238961','24','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (57,'2022-02-09 09:43:07.268957','23','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (58,'2022-02-09 09:43:07.292958','22','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (59,'2022-02-09 09:43:07.335957','21','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (60,'2022-02-09 10:12:32.083258','39','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (61,'2022-02-09 10:12:32.104260','38','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (62,'2022-02-09 10:12:32.121261','37','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (63,'2022-02-09 10:12:32.138262','36','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (64,'2022-02-09 10:12:32.153256','35','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (65,'2022-02-09 10:12:32.167257','34','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (66,'2022-02-09 10:12:32.183259','33','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (67,'2022-02-09 10:13:00.641671','40','5.010.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (68,'2022-02-09 20:51:32.100757','72','6.011.0','[{"added": {}}]',18,1,1);
INSERT INTO "django_admin_log" VALUES (69,'2022-02-09 20:52:00.138648','72','6.011.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (70,'2022-02-10 11:16:21.739312','190','6.04.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (71,'2022-02-10 12:00:31.634420','212','7.08.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (72,'2022-02-10 12:00:31.652417','211','2.05.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (73,'2022-02-14 06:21:47.831849','173','12.07.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (74,'2022-02-23 00:00:09.810783','210','78.014.010.056.0','',18,1,3);
INSERT INTO "django_admin_log" VALUES (75,'2022-03-01 07:15:44.810150','2','Grand Lomé','[{"changed": {"fields": ["Pays", "Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (76,'2022-03-01 07:40:43.002436','1','EPL Ivoire','[{"changed": {"fields": ["Logo", "Chef"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (77,'2022-03-03 18:26:06.888747','4','4 3ÈME Col','[{"changed": {"fields": ["Titulaire"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (78,'2022-03-03 18:26:27.615698','3','3 4ÈME Col','[{"changed": {"fields": ["Titulaire"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (79,'2022-03-03 18:26:47.296388','2','2 5ÈME Col','[{"changed": {"fields": ["Titulaire"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (80,'2022-03-03 18:27:17.299249','1','1 6ÈME Col','[{"changed": {"fields": ["Titulaire"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (81,'2022-03-03 18:28:28.730382','1','CPL Ivoire','[{"changed": {"fields": ["Nom", "Email"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (82,'2022-03-04 06:01:18.161919','1','CPL Ivoire','[{"changed": {"fields": ["Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (83,'2022-03-04 13:01:01.974934','2','Grand Lomé','[{"changed": {"fields": ["Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (84,'2022-03-04 13:02:32.859070','2','Grand Lomé','[{"changed": {"fields": ["Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (85,'2022-03-04 13:02:48.390957','2','Grand Lomé','[{"changed": {"fields": ["Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (86,'2022-03-04 13:03:38.527592','1','CPL Ivoire','[{"changed": {"fields": ["Logo", "Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (87,'2022-03-04 13:04:52.944232','1','CPL Ivoire','[{"changed": {"fields": ["Logo", "Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (88,'2022-03-04 13:26:21.615898','1','CPL Ivoire','[{"changed": {"fields": ["Logo", "Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (89,'2022-03-04 13:42:59.575626','1','CPL Ivoire','[{"changed": {"fields": ["Logo", "Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (90,'2022-03-04 13:44:05.107032','2','Grand Lomé','[{"changed": {"fields": ["Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (91,'2022-03-04 13:46:48.532678','2','Grand Lomé','[{"changed": {"fields": ["Drapeau"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (92,'2022-03-04 13:48:33.174310','1','CPL Ivoire','[{"changed": {"fields": ["Logo"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (93,'2022-03-04 13:49:22.567893','1','CPL Ivoire','[{"changed": {"fields": ["Logo"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (94,'2022-03-04 15:00:43.682768','2','Grand Lomé','[{"changed": {"fields": ["Rep"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (95,'2022-03-04 16:04:24.429891','1','COMPLEXE SCOLAIRE IVOIRE','[{"changed": {"fields": ["Nom"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (96,'2022-03-04 17:26:27.246127','1','1 PREMIER TRIMESTRE','[{"added": {}}]',19,1,1);
INSERT INTO "django_admin_log" VALUES (97,'2022-03-07 04:34:31.932598','1','Grand Lomé Est','[{"changed": {"fields": ["Nom", "Adresse"]}}]',13,1,2);
INSERT INTO "django_admin_log" VALUES (98,'2022-03-07 04:36:39.349225','1','COMPLEXE SCOLAIRE IVOIRE','[{"changed": {"fields": ["Bp", "Email"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (99,'2022-03-07 04:37:16.311175','1','COMPLEXE SCOLAIRE IVOIRE','[{"changed": {"fields": ["Adresse"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (100,'2022-03-07 04:38:23.925399','11','11 PHILOSOPHIE','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (101,'2022-03-07 04:39:28.131557','12','12 AGRICULTURE','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (102,'2022-03-07 04:39:48.111852','13','13 EWÉ','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (103,'2022-03-07 04:40:14.311437','14','14 DESSIN','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (104,'2022-03-07 04:40:25.620118','15','15 MUSIC','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (105,'2022-03-07 04:40:45.242995','16','16 ENSEIGNEMENT MÉNAGER','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (106,'2022-03-07 04:41:58.629318','1','1 EWÉ1','[{"added": {}}]',20,1,1);
INSERT INTO "django_admin_log" VALUES (107,'2022-03-07 04:42:20.516156','2','2 DESSIN1','[{"added": {}}]',20,1,1);
INSERT INTO "django_admin_log" VALUES (108,'2022-03-07 04:42:46.442494','3','3 ENSEIGNEMENT MÉNAGER1','[{"added": {}}]',20,1,1);
INSERT INTO "django_admin_log" VALUES (109,'2022-03-07 05:47:23.915552','1','Grand Lomé Est','[{"changed": {"fields": ["Ville"]}}]',13,1,2);
INSERT INTO "django_admin_log" VALUES (110,'2022-03-07 06:35:36.511446','1','COMPLEXE SCOLAIRE IVOIRE','[{"changed": {"fields": ["Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (111,'2022-03-07 06:36:41.869479','1','COMPLEXE SCOLAIRE IVOIRE','[{"changed": {"fields": ["Plan"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (112,'2022-03-28 14:31:04.908395','3','rogerkok','[{"added": {}}]',4,2,1);
INSERT INTO "django_admin_log" VALUES (113,'2022-03-28 14:33:08.470943','3','rogerkok','[{"changed": {"fields": ["Groups"]}}]',4,2,2);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'etablissements','anneescolaire');
INSERT INTO "django_content_type" VALUES (8,'etablissements','classe');
INSERT INTO "django_content_type" VALUES (9,'etablissements','dre');
INSERT INTO "django_content_type" VALUES (10,'etablissements','enseignant');
INSERT INTO "django_content_type" VALUES (11,'etablissements','matiere');
INSERT INTO "django_content_type" VALUES (12,'etablissements','matiereclasse');
INSERT INTO "django_content_type" VALUES (13,'etablissements','inspection');
INSERT INTO "django_content_type" VALUES (14,'etablissements','etablissement');
INSERT INTO "django_content_type" VALUES (15,'etablissements','decoupage');
INSERT INTO "django_content_type" VALUES (16,'bulletin','eleve');
INSERT INTO "django_content_type" VALUES (17,'bulletin','moyenne');
INSERT INTO "django_content_type" VALUES (18,'bulletin','moyennematiere');
INSERT INTO "django_content_type" VALUES (19,'etablissements','examen');
INSERT INTO "django_content_type" VALUES (20,'etablissements','facultative');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_anneescolaire','Can add Année scolaire');
INSERT INTO "auth_permission" VALUES (26,7,'change_anneescolaire','Can change Année scolaire');
INSERT INTO "auth_permission" VALUES (27,7,'delete_anneescolaire','Can delete Année scolaire');
INSERT INTO "auth_permission" VALUES (28,7,'view_anneescolaire','Can view Année scolaire');
INSERT INTO "auth_permission" VALUES (29,8,'add_classe','Can add Classe');
INSERT INTO "auth_permission" VALUES (30,8,'change_classe','Can change Classe');
INSERT INTO "auth_permission" VALUES (31,8,'delete_classe','Can delete Classe');
INSERT INTO "auth_permission" VALUES (32,8,'view_classe','Can view Classe');
INSERT INTO "auth_permission" VALUES (33,9,'add_dre','Can add Direction Régionnale');
INSERT INTO "auth_permission" VALUES (34,9,'change_dre','Can change Direction Régionnale');
INSERT INTO "auth_permission" VALUES (35,9,'delete_dre','Can delete Direction Régionnale');
INSERT INTO "auth_permission" VALUES (36,9,'view_dre','Can view Direction Régionnale');
INSERT INTO "auth_permission" VALUES (37,10,'add_enseignant','Can add Enseignant');
INSERT INTO "auth_permission" VALUES (38,10,'change_enseignant','Can change Enseignant');
INSERT INTO "auth_permission" VALUES (39,10,'delete_enseignant','Can delete Enseignant');
INSERT INTO "auth_permission" VALUES (40,10,'view_enseignant','Can view Enseignant');
INSERT INTO "auth_permission" VALUES (41,11,'add_matiere','Can add Matière');
INSERT INTO "auth_permission" VALUES (42,11,'change_matiere','Can change Matière');
INSERT INTO "auth_permission" VALUES (43,11,'delete_matiere','Can delete Matière');
INSERT INTO "auth_permission" VALUES (44,11,'view_matiere','Can view Matière');
INSERT INTO "auth_permission" VALUES (45,12,'add_matiereclasse','Can add Matière de la classe');
INSERT INTO "auth_permission" VALUES (46,12,'change_matiereclasse','Can change Matière de la classe');
INSERT INTO "auth_permission" VALUES (47,12,'delete_matiereclasse','Can delete Matière de la classe');
INSERT INTO "auth_permission" VALUES (48,12,'view_matiereclasse','Can view Matière de la classe');
INSERT INTO "auth_permission" VALUES (49,13,'add_inspection','Can add Inspection');
INSERT INTO "auth_permission" VALUES (50,13,'change_inspection','Can change Inspection');
INSERT INTO "auth_permission" VALUES (51,13,'delete_inspection','Can delete Inspection');
INSERT INTO "auth_permission" VALUES (52,13,'view_inspection','Can view Inspection');
INSERT INTO "auth_permission" VALUES (53,14,'add_etablissement','Can add Etablissement');
INSERT INTO "auth_permission" VALUES (54,14,'change_etablissement','Can change Etablissement');
INSERT INTO "auth_permission" VALUES (55,14,'delete_etablissement','Can delete Etablissement');
INSERT INTO "auth_permission" VALUES (56,14,'view_etablissement','Can view Etablissement');
INSERT INTO "auth_permission" VALUES (57,15,'add_decoupage','Can add Découpage');
INSERT INTO "auth_permission" VALUES (58,15,'change_decoupage','Can change Découpage');
INSERT INTO "auth_permission" VALUES (59,15,'delete_decoupage','Can delete Découpage');
INSERT INTO "auth_permission" VALUES (60,15,'view_decoupage','Can view Découpage');
INSERT INTO "auth_permission" VALUES (61,16,'add_eleve','Can add Elève');
INSERT INTO "auth_permission" VALUES (62,16,'change_eleve','Can change Elève');
INSERT INTO "auth_permission" VALUES (63,16,'delete_eleve','Can delete Elève');
INSERT INTO "auth_permission" VALUES (64,16,'view_eleve','Can view Elève');
INSERT INTO "auth_permission" VALUES (65,17,'add_moyenne','Can add Moyenne');
INSERT INTO "auth_permission" VALUES (66,17,'change_moyenne','Can change Moyenne');
INSERT INTO "auth_permission" VALUES (67,17,'delete_moyenne','Can delete Moyenne');
INSERT INTO "auth_permission" VALUES (68,17,'view_moyenne','Can view Moyenne');
INSERT INTO "auth_permission" VALUES (69,18,'add_moyennematiere','Can add Moyenne du Matière');
INSERT INTO "auth_permission" VALUES (70,18,'change_moyennematiere','Can change Moyenne du Matière');
INSERT INTO "auth_permission" VALUES (71,18,'delete_moyennematiere','Can delete Moyenne du Matière');
INSERT INTO "auth_permission" VALUES (72,18,'view_moyennematiere','Can view Moyenne du Matière');
INSERT INTO "auth_permission" VALUES (73,19,'add_examen','Can add Examen');
INSERT INTO "auth_permission" VALUES (74,19,'change_examen','Can change Examen');
INSERT INTO "auth_permission" VALUES (75,19,'delete_examen','Can delete Examen');
INSERT INTO "auth_permission" VALUES (76,19,'view_examen','Can view Examen');
INSERT INTO "auth_permission" VALUES (77,20,'add_facultative','Can add Matière Facultative');
INSERT INTO "auth_permission" VALUES (78,20,'change_facultative','Can change Matière Facultative');
INSERT INTO "auth_permission" VALUES (79,20,'delete_facultative','Can delete Matière Facultative');
INSERT INTO "auth_permission" VALUES (80,20,'view_facultative','Can view Matière Facultative');
INSERT INTO "auth_group" VALUES (1,'Administrateur');
INSERT INTO "auth_group" VALUES (2,'Chef');
INSERT INTO "auth_group" VALUES (3,'Enseignant');
INSERT INTO "auth_group" VALUES (4,'Eleve');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$320000$PKcw8m8WKm2UBGhHWHpepe$9ncIXwoEakhh5iEQcv06dkVA8AdaHLMYdyooBd9EN8w=','2022-02-22 23:59:10.603186',1,'roger','','rogerkok007@gmail.com',1,1,'2022-02-02 17:18:21','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$320000$2lNqrD7ASkFDVo3sM8FT91$27f2stiIEgcK+iD1ME5NrQ1d+2HOrt64A5+0UKAPi7c=','2022-03-28 16:13:55.473340',1,'rogerson','','digitcont@gmail.com',1,1,'2022-03-10 11:49:03.606482','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$320000$T2pUlGcZOjwJ5O9FhXst4U$e+J/yb8+oDBatgMnAT9KA3ARrur6SgpBzZ8SX4SSAno=',NULL,0,'rogerkok','','',0,1,'2022-03-28 14:31:04','');
INSERT INTO "annee_scolaire" VALUES (1,'2021-2022','2022-02-03 13:15:52.730838');
INSERT INTO "matiere" VALUES (1,'Français','2022-02-02 17:19:28.599842');
INSERT INTO "matiere" VALUES (2,'Anglais','2022-02-02 17:19:37.669241');
INSERT INTO "matiere" VALUES (3,'Allemand','2022-02-02 17:19:45.954321');
INSERT INTO "matiere" VALUES (4,'Histo-Geo','2022-02-02 17:20:02.971724');
INSERT INTO "matiere" VALUES (5,'SVT','2022-02-02 17:20:23.222129');
INSERT INTO "matiere" VALUES (6,'Physique Chimie Technologie','2022-02-02 17:20:33.356930');
INSERT INTO "matiere" VALUES (7,'Mathématique','2022-02-02 17:21:01.932996');
INSERT INTO "matiere" VALUES (8,'ECM','2022-02-02 17:21:17.153245');
INSERT INTO "matiere" VALUES (9,'EPS','2022-02-02 17:21:24.157516');
INSERT INTO "matiere" VALUES (10,'Sciences-Physiques','2022-02-02 17:22:00.872825');
INSERT INTO "matiere" VALUES (11,'Philosophie','2022-03-07 04:38:23.920401');
INSERT INTO "matiere" VALUES (12,'Agriculture','2022-03-07 04:39:28.127549');
INSERT INTO "matiere" VALUES (13,'Ewé','2022-03-07 04:39:48.107854');
INSERT INTO "matiere" VALUES (14,'Dessin','2022-03-07 04:40:14.307432');
INSERT INTO "matiere" VALUES (15,'Music','2022-03-07 04:40:25.616114');
INSERT INTO "matiere" VALUES (16,'Enseignement Ménager','2022-03-07 04:40:45.238995');
INSERT INTO "django_session" VALUES ('cyjgnc9jdfkzehcpzvvk4jj5hs5trjpd','.eJxVjDEOwjAMRe-SGUU2SYPDyM4ZIqd2SAG1UtNOiLtDpQ6w_vfef5nE61LT2nROg5izQXP43TL3Dx03IHceb5Ptp3GZh2w3xe602esk-rzs7t9B5Va_NQGpoCIHKRA6BQzRSRECYeqdQMlcikcn6I8xeugyIZ-IgldwnM37A-_3N_k:1nFJHH:PzCUc1B5sDW9hRO_K-sTd1DYJ7eYAJV928yX0NJbe8Q','2022-02-16 17:18:43.663964');
INSERT INTO "django_session" VALUES ('dt37vnn8v87s554fddr87r3rhs89zaed','.eJxVjDEOwjAMRe-SGUU2SYPDyM4ZIqd2SAG1UtNOiLtDpQ6w_vfef5nE61LT2nROg5izQXP43TL3Dx03IHceb5Ptp3GZh2w3xe602esk-rzs7t9B5Va_NQGpoCIHKRA6BQzRSRECYeqdQMlcikcn6I8xeugyIZ-IgldwnM37A-_3N_k:1nMf3m:qQ-MldfVUfMoExxGGRyiuHcGjnHf5sIezlkwZJh7zmo','2022-03-08 23:59:10.621696');
INSERT INTO "django_session" VALUES ('i8y5qrr81fnzdgptiv4wgsjm997fxq85','.eJxVjDsOwjAQBe_iGlnrLzYlfc5grbNrHEC2lE-FuDtESgHtm5n3Egm3taZt4TlNJC5Ci9PvlnF8cNsB3bHduhx7W-cpy12RB13k0Imf18P9O6i41G9djA85RHKgIIA5awOe0VJw0bH17G0AgmLZUjaaCEtBB3lERKUwavH-AMfzN_E:1nSHKv:VngfWSlHUmyDMiNlGU0cRFEZS6aSuWmM0aTB3Dh2ylw','2022-03-24 11:52:05.265142');
INSERT INTO "django_session" VALUES ('96q1nv13982qykh0v5ci2zy1ml6chvp1','.eJxVjDsOwjAQBe_iGlnrLzYlfc5grbNrHEC2lE-FuDtESgHtm5n3Egm3taZt4TlNJC5Ci9PvlnF8cNsB3bHduhx7W-cpy12RB13k0Imf18P9O6i41G9djA85RHKgIIA5awOe0VJw0bH17G0AgmLZUjaaCEtBB3lERKUwavH-AMfzN_E:1nYs0B:iEl_GTDdVmJPv_2h1AxQHUQ_mlIAl-hbhMjzg_SheiU','2022-04-11 16:13:55.500885');
INSERT INTO "matiere_classe" VALUES (1,2,'2022-02-08 01:38:23.255566',1,1,1);
INSERT INTO "matiere_classe" VALUES (2,2,'2022-02-08 01:44:25.897970',2,1,1);
INSERT INTO "matiere_classe" VALUES (3,1,'2022-02-08 01:45:10.684835',1,2,3);
INSERT INTO "matiere_classe" VALUES (4,1,'2022-02-08 01:45:44.588077',2,2,3);
INSERT INTO "matiere_classe" VALUES (5,3,'2022-02-08 01:46:09.764201',3,1,1);
INSERT INTO "matiere_classe" VALUES (6,3,'2022-02-08 01:46:28.066263',4,1,1);
INSERT INTO "matiere_classe" VALUES (7,2,'2022-02-08 01:47:20.747246',3,2,3);
INSERT INTO "matiere_classe" VALUES (8,2,'2022-02-08 01:48:01.874106',4,2,9);
INSERT INTO "matiere_classe" VALUES (9,1,'2022-02-08 01:52:28.437092',1,4,5);
INSERT INTO "matiere_classe" VALUES (10,1,'2022-02-08 01:52:49.224685',2,4,5);
INSERT INTO "matiere_classe" VALUES (11,2,'2022-02-08 01:53:15.397168',3,4,5);
INSERT INTO "matiere_classe" VALUES (12,2,'2022-02-08 01:53:47.182050',4,4,10);
INSERT INTO "matiere_classe" VALUES (13,1,'2022-02-08 01:54:24.933951',1,7,6);
INSERT INTO "matiere_classe" VALUES (14,1,'2022-02-08 01:54:46.315777',2,7,6);
INSERT INTO "matiere_classe" VALUES (15,2,'2022-02-08 01:55:21.148774',3,7,6);
INSERT INTO "matiere_classe" VALUES (16,2,'2022-02-08 01:55:57.547883',4,7,12);
INSERT INTO "matiere_classe" VALUES (17,1,'2022-02-08 01:56:38.635728',1,5,7);
INSERT INTO "matiere_classe" VALUES (18,1,'2022-02-08 01:57:12.816721',2,5,7);
INSERT INTO "matiere_classe" VALUES (19,2,'2022-02-08 01:57:37.974392',3,5,7);
INSERT INTO "matiere_classe" VALUES (20,2,'2022-02-08 01:58:44.771106',4,5,11);
INSERT INTO "matiere_classe" VALUES (21,1,'2022-02-08 02:00:43.904659',1,6,7);
INSERT INTO "matiere_classe" VALUES (22,1,'2022-02-08 02:01:12.032445',2,6,7);
INSERT INTO "matiere_classe" VALUES (23,2,'2022-02-08 02:01:48.424760',3,6,7);
INSERT INTO "matiere_classe" VALUES (24,2,'2022-02-08 02:02:30.458625',4,6,12);
INSERT INTO "matiere_classe" VALUES (25,1,'2022-02-08 02:40:09.078511',1,8,5);
INSERT INTO "matiere_classe" VALUES (26,1,'2022-02-08 02:40:27.846870',2,8,5);
INSERT INTO "matiere_classe" VALUES (27,2,'2022-02-08 02:40:54.929244',3,8,5);
INSERT INTO "matiere_classe" VALUES (28,2,'2022-02-08 02:41:24.006302',4,8,5);
INSERT INTO "matiere_classe" VALUES (29,1,'2022-02-08 02:41:48.560224',1,9,8);
INSERT INTO "matiere_classe" VALUES (30,1,'2022-02-08 02:42:14.490509',2,9,8);
INSERT INTO "matiere_classe" VALUES (31,1,'2022-02-08 02:42:34.556701',3,9,8);
INSERT INTO "matiere_classe" VALUES (32,1,'2022-02-08 02:42:58.163147',4,9,8);
INSERT INTO "decoupage" VALUES (1,'trimestriel','Premier Trimestre','2022-02-03 13:23:47.799221',1);
INSERT INTO "moyenne_matiere" VALUES (41,5.0,10.0,11.0,8.0,9.5,19.0,'2022-02-09 10:13:58.780741',1,1,6);
INSERT INTO "moyenne_matiere" VALUES (42,6.0,5.0,5.0,6.0,5.5,11.0,'2022-02-09 14:01:21.803742',1,2,12);
INSERT INTO "moyenne_matiere" VALUES (43,8.0,11.0,6.0,10.0,8.0,16.0,'2022-02-09 14:02:57.959387',1,3,9);
INSERT INTO "moyenne_matiere" VALUES (44,12.0,12.0,9.0,12.0,10.5,21.0,'2022-02-09 14:12:33.822952',1,4,4);
INSERT INTO "moyenne_matiere" VALUES (45,4.0,5.0,2.0,4.0,3.0,6.0,'2022-02-09 14:29:02.760745',1,5,15);
INSERT INTO "moyenne_matiere" VALUES (46,9.0,6.0,6.0,8.0,7.0,14.0,'2022-02-09 14:29:35.956503',1,6,11);
INSERT INTO "moyenne_matiere" VALUES (47,7.0,14.0,8.0,10.0,9.0,18.0,'2022-02-09 14:30:17.993842',1,7,7);
INSERT INTO "moyenne_matiere" VALUES (48,15.0,18.0,14.0,16.0,15.0,30.0,'2022-02-09 14:31:07.831483',1,8,1);
INSERT INTO "moyenne_matiere" VALUES (49,10.0,9.0,5.0,10.0,7.5,15.0,'2022-02-09 14:31:53.993911',1,9,10);
INSERT INTO "moyenne_matiere" VALUES (50,8.0,9.0,9.0,8.0,8.5,17.0,'2022-02-09 14:33:00.127957',1,10,8);
INSERT INTO "moyenne_matiere" VALUES (51,6.0,3.0,3.0,4.0,3.5,7.0,'2022-02-09 14:33:24.351754',1,11,14);
INSERT INTO "moyenne_matiere" VALUES (52,15.0,12.0,6.0,14.0,10.0,20.0,'2022-02-09 14:34:00.103677',1,12,5);
INSERT INTO "moyenne_matiere" VALUES (53,6.0,5.0,5.0,6.0,5.5,11.0,'2022-02-09 14:34:30.308992',1,13,13);
INSERT INTO "moyenne_matiere" VALUES (54,10.0,14.0,14.0,12.0,13.0,26.0,'2022-02-09 14:35:37.049452',1,14,2);
INSERT INTO "moyenne_matiere" VALUES (55,11.0,12.0,13.0,12.0,12.5,25.0,'2022-02-09 14:35:57.148919',1,16,3);
INSERT INTO "moyenne_matiere" VALUES (56,9.0,10.0,7.0,10.0,8.5,8.5,'2022-02-09 17:01:22.522304',3,1,12);
INSERT INTO "moyenne_matiere" VALUES (57,8.0,7.0,9.0,8.0,8.5,8.5,'2022-02-09 17:06:41.184479',3,2,13);
INSERT INTO "moyenne_matiere" VALUES (58,11.0,11.0,12.0,11.0,11.5,11.5,'2022-02-09 17:08:38.262832',3,3,4);
INSERT INTO "moyenne_matiere" VALUES (60,8.0,3.0,9.0,6.0,7.5,7.5,'2022-02-09 17:10:20.557343',3,4,15);
INSERT INTO "moyenne_matiere" VALUES (61,11.0,8.0,8.0,10.0,9.0,9.0,'2022-02-09 17:10:59.855363',3,5,9);
INSERT INTO "moyenne_matiere" VALUES (62,11.0,8.0,8.0,10.0,9.0,9.0,'2022-02-09 17:44:32.794329',3,6,10);
INSERT INTO "moyenne_matiere" VALUES (63,5.0,4.0,9.0,4.0,6.5,6.5,'2022-02-09 17:45:45.715107',3,7,16);
INSERT INTO "moyenne_matiere" VALUES (64,15.0,7.0,15.0,11.0,13.0,13.0,'2022-02-09 20:06:06.432580',3,8,1);
INSERT INTO "moyenne_matiere" VALUES (65,8.0,7.0,16.0,8.0,12.0,12.0,'2022-02-09 20:06:40.952254',3,9,3);
INSERT INTO "moyenne_matiere" VALUES (66,16.0,9.0,7.0,12.0,9.5,9.5,'2022-02-09 20:07:15.815366',3,10,6);
INSERT INTO "moyenne_matiere" VALUES (67,8.0,8.0,9.0,8.0,8.5,8.5,'2022-02-09 20:07:45.592943',3,11,14);
INSERT INTO "moyenne_matiere" VALUES (68,12.0,8.0,9.0,10.0,9.5,9.5,'2022-02-09 20:08:14.366592',3,12,7);
INSERT INTO "moyenne_matiere" VALUES (69,12.0,8.0,8.0,10.0,9.0,9.0,'2022-02-09 20:08:43.104440',3,13,11);
INSERT INTO "moyenne_matiere" VALUES (70,9.0,11.0,9.0,10.0,9.5,9.5,'2022-02-09 20:09:14.285794',3,14,8);
INSERT INTO "moyenne_matiere" VALUES (71,15.0,11.0,13.0,13.0,13.0,13.0,'2022-02-09 20:09:39.756085',3,16,2);
INSERT INTO "moyenne_matiere" VALUES (73,5.0,13.0,13.0,9.0,11.0,11.0,'2022-02-09 21:22:39.654132',9,1,8);
INSERT INTO "moyenne_matiere" VALUES (74,9.5,10.0,14.0,10.0,12.0,12.0,'2022-02-09 21:23:27.607950',9,2,5);
INSERT INTO "moyenne_matiere" VALUES (75,12.0,13.0,14.0,12.0,13.0,13.0,'2022-02-09 21:23:47.277426',9,3,3);
INSERT INTO "moyenne_matiere" VALUES (76,13.0,10.0,16.5,12.0,14.25,14.25,'2022-02-09 21:24:08.103673',9,4,1);
INSERT INTO "moyenne_matiere" VALUES (77,4.0,7.0,6.5,6.0,6.25,6.25,'2022-02-09 21:24:42.945837',9,5,15);
INSERT INTO "moyenne_matiere" VALUES (78,11.0,8.0,8.0,10.0,9.0,9.0,'2022-02-09 21:25:22.809280',9,6,10);
INSERT INTO "moyenne_matiere" VALUES (79,9.5,11.0,12.0,10.0,11.0,11.0,'2022-02-09 21:26:00.077299',9,7,9);
INSERT INTO "moyenne_matiere" VALUES (80,13.0,14.5,14.5,14.0,14.25,14.25,'2022-02-09 21:27:00.587206',9,8,2);
INSERT INTO "moyenne_matiere" VALUES (81,11.0,8.0,8.0,10.0,9.0,9.0,'2022-02-09 21:27:40.580375',9,9,11);
INSERT INTO "moyenne_matiere" VALUES (82,9.5,8.0,8.0,9.0,8.5,8.5,'2022-02-09 21:28:14.775750',9,10,13);
INSERT INTO "moyenne_matiere" VALUES (83,8.5,9.0,8.5,9.0,8.75,8.75,'2022-02-09 21:29:39.401925',9,11,12);
INSERT INTO "moyenne_matiere" VALUES (84,10.5,13.0,13.0,12.0,12.5,12.5,'2022-02-09 21:30:15.733140',9,12,4);
INSERT INTO "moyenne_matiere" VALUES (85,6.0,9.0,9.0,8.0,8.5,8.5,'2022-02-09 21:30:56.248716',9,13,14);
INSERT INTO "moyenne_matiere" VALUES (86,12.5,11.0,11.0,12.0,11.5,11.5,'2022-02-09 21:32:21.099014',9,14,6);
INSERT INTO "moyenne_matiere" VALUES (87,12.0,11.0,11.0,12.0,11.5,11.5,'2022-02-09 21:32:47.514742',9,16,7);
INSERT INTO "moyenne_matiere" VALUES (88,10.0,12.0,7.0,11.0,9.0,9.0,'2022-02-09 21:34:11.356754',25,1,10);
INSERT INTO "moyenne_matiere" VALUES (89,11.0,8.5,5.0,10.0,7.5,7.5,'2022-02-09 21:36:04.739065',25,2,13);
INSERT INTO "moyenne_matiere" VALUES (90,11.0,8.0,10.5,10.0,10.25,10.25,'2022-02-09 21:36:40.687105',25,3,8);
INSERT INTO "moyenne_matiere" VALUES (91,12.0,11.0,13.5,12.0,12.75,12.75,'2022-02-09 21:40:15.344157',25,4,2);
INSERT INTO "moyenne_matiere" VALUES (92,8.0,9.5,4.0,9.0,6.5,6.5,'2022-02-10 04:17:09.960415',25,5,14);
INSERT INTO "moyenne_matiere" VALUES (93,12.0,8.0,8.0,10.0,9.0,9.0,'2022-02-10 04:17:54.653553',25,6,11);
INSERT INTO "moyenne_matiere" VALUES (94,13.5,9.5,12.5,12.0,12.25,12.25,'2022-02-10 04:19:16.650995',25,7,4);
INSERT INTO "moyenne_matiere" VALUES (95,16.5,11.0,11.5,14.0,12.75,12.75,'2022-02-10 04:20:18.647127',25,8,3);
INSERT INTO "moyenne_matiere" VALUES (96,12.0,6.0,12.5,9.0,10.75,10.75,'2022-02-10 04:21:26.352684',25,9,7);
INSERT INTO "moyenne_matiere" VALUES (97,11.0,7.5,11.0,9.0,10.0,10.0,'2022-02-10 04:22:21.189510',25,10,9);
INSERT INTO "moyenne_matiere" VALUES (98,10.0,7.0,5.0,8.0,6.5,6.5,'2022-02-10 04:22:54.503940',25,11,15);
INSERT INTO "moyenne_matiere" VALUES (99,15.5,10.0,14.0,13.0,13.5,13.5,'2022-02-10 04:23:26.047019',25,12,1);
INSERT INTO "moyenne_matiere" VALUES (100,12.0,6.0,9.0,9.0,9.0,9.0,'2022-02-10 04:24:17.940977',25,13,12);
INSERT INTO "moyenne_matiere" VALUES (101,14.0,8.0,13.5,11.0,12.25,12.25,'2022-02-10 04:25:07.023328',25,14,5);
INSERT INTO "moyenne_matiere" VALUES (102,13.5,8.0,13.5,11.0,12.25,12.25,'2022-02-10 04:25:38.851077',25,16,6);
INSERT INTO "moyenne_matiere" VALUES (103,14.0,14.0,8.0,14.0,11.0,11.0,'2022-02-10 04:26:42.037540',21,1,9);
INSERT INTO "moyenne_matiere" VALUES (104,14.0,12.0,9.0,13.0,11.0,11.0,'2022-02-10 04:31:00.824027',21,2,10);
INSERT INTO "moyenne_matiere" VALUES (105,15.0,14.0,9.0,14.0,11.5,11.5,'2022-02-10 04:31:39.695844',21,3,7);
INSERT INTO "moyenne_matiere" VALUES (106,14.0,14.0,6.0,14.0,10.0,10.0,'2022-02-10 04:32:03.335422',21,4,12);
INSERT INTO "moyenne_matiere" VALUES (107,13.0,8.0,7.0,10.0,8.5,8.5,'2022-02-10 04:33:52.266974',21,5,15);
INSERT INTO "moyenne_matiere" VALUES (108,13.0,10.0,8.0,12.0,10.0,10.0,'2022-02-10 04:34:18.429711',21,6,13);
INSERT INTO "moyenne_matiere" VALUES (109,13.0,14.0,11.0,14.0,12.5,12.5,'2022-02-10 04:35:19.113317',21,7,4);
INSERT INTO "moyenne_matiere" VALUES (110,15.0,16.0,14.0,16.0,15.0,15.0,'2022-02-10 04:35:55.076629',21,8,1);
INSERT INTO "moyenne_matiere" VALUES (111,15.0,12.0,13.0,14.0,13.5,13.5,'2022-02-10 04:36:21.932987',21,9,2);
INSERT INTO "moyenne_matiere" VALUES (112,13.0,13.0,11.0,13.0,12.0,12.0,'2022-02-10 04:36:51.359682',21,10,6);
INSERT INTO "moyenne_matiere" VALUES (113,13.0,9.0,7.0,11.0,9.0,9.0,'2022-02-10 04:37:19.012473',21,11,14);
INSERT INTO "moyenne_matiere" VALUES (114,16.5,17.0,9.0,17.0,13.0,13.0,'2022-02-10 04:37:57.925823',21,12,3);
INSERT INTO "moyenne_matiere" VALUES (115,12.0,8.0,11.0,10.0,10.5,10.5,'2022-02-10 04:38:18.104131',21,13,11);
INSERT INTO "moyenne_matiere" VALUES (116,13.0,12.0,11.0,12.0,11.5,11.5,'2022-02-10 04:38:44.563156',21,14,8);
INSERT INTO "moyenne_matiere" VALUES (117,14.0,13.0,11.0,14.0,12.5,12.5,'2022-02-10 04:39:18.058078',21,16,5);
INSERT INTO "moyenne_matiere" VALUES (118,12.0,11.0,15.0,12.0,13.5,13.5,'2022-02-10 04:40:02.287077',17,1,5);
INSERT INTO "moyenne_matiere" VALUES (119,9.0,7.0,5.0,8.0,6.5,6.5,'2022-02-10 04:40:21.523721',17,2,14);
INSERT INTO "moyenne_matiere" VALUES (120,14.0,16.0,11.0,15.0,13.0,13.0,'2022-02-10 04:40:56.057960',17,3,7);
INSERT INTO "moyenne_matiere" VALUES (121,11.0,13.0,15.0,12.0,13.5,13.5,'2022-02-10 04:41:41.884932',17,4,6);
INSERT INTO "moyenne_matiere" VALUES (122,7.0,6.0,4.0,6.0,5.0,5.0,'2022-02-10 04:42:17.929149',17,5,15);
INSERT INTO "moyenne_matiere" VALUES (123,12.0,7.0,13.0,10.0,11.5,11.5,'2022-02-10 04:42:52.822945',17,6,8);
INSERT INTO "moyenne_matiere" VALUES (124,12.0,11.0,10.0,12.0,11.0,11.0,'2022-02-10 04:43:40.228890',17,7,10);
INSERT INTO "moyenne_matiere" VALUES (125,13.0,14.0,16.0,14.0,15.0,15.0,'2022-02-10 04:44:10.126112',17,8,1);
INSERT INTO "moyenne_matiere" VALUES (126,15.0,16.0,13.0,16.0,14.5,14.5,'2022-02-10 04:44:57.899816',17,9,2);
INSERT INTO "moyenne_matiere" VALUES (127,12.0,16.0,7.0,14.0,10.5,10.5,'2022-02-10 04:45:39.851266',17,10,12);
INSERT INTO "moyenne_matiere" VALUES (128,12.0,7.0,12.0,10.0,11.0,11.0,'2022-02-10 04:46:04.077055',17,11,11);
INSERT INTO "moyenne_matiere" VALUES (129,13.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 04:46:37.999019',17,12,4);
INSERT INTO "moyenne_matiere" VALUES (130,10.0,9.0,7.0,10.0,8.5,8.5,'2022-02-10 04:47:08.044007',17,13,13);
INSERT INTO "moyenne_matiere" VALUES (131,12.0,8.0,13.0,10.0,11.5,11.5,'2022-02-10 04:47:29.565231',17,14,9);
INSERT INTO "moyenne_matiere" VALUES (132,14.0,17.0,13.0,16.0,14.5,14.5,'2022-02-10 04:47:50.835154',17,16,3);
INSERT INTO "moyenne_matiere" VALUES (133,8.0,10.0,10.0,9.0,9.5,9.5,'2022-02-10 04:49:16.774185',13,1,9);
INSERT INTO "moyenne_matiere" VALUES (134,11.0,10.0,8.0,10.0,9.0,9.0,'2022-02-10 04:49:38.005703',13,2,10);
INSERT INTO "moyenne_matiere" VALUES (135,13.0,11.0,12.0,12.0,12.0,12.0,'2022-02-10 04:49:56.125887',13,3,4);
INSERT INTO "moyenne_matiere" VALUES (136,7.0,11.0,6.0,9.0,7.5,7.5,'2022-02-10 04:50:17.680949',13,4,13);
INSERT INTO "moyenne_matiere" VALUES (137,3.0,4.0,5.0,4.0,4.5,4.5,'2022-02-10 04:50:59.411801',13,5,15);
INSERT INTO "moyenne_matiere" VALUES (138,9.0,9.0,12.0,9.0,10.5,10.5,'2022-02-10 04:51:17.129794',13,6,7);
INSERT INTO "moyenne_matiere" VALUES (139,7.0,13.0,8.0,10.0,9.0,9.0,'2022-02-10 04:51:56.074324',13,7,11);
INSERT INTO "moyenne_matiere" VALUES (140,17.0,17.0,17.0,17.0,17.0,17.0,'2022-02-10 04:52:20.063392',13,8,1);
INSERT INTO "moyenne_matiere" VALUES (141,10.0,9.0,10.0,10.0,10.0,10.0,'2022-02-10 04:54:06.309274',13,9,8);
INSERT INTO "moyenne_matiere" VALUES (142,17.0,15.0,14.0,16.0,15.0,15.0,'2022-02-10 04:54:38.396863',13,10,2);
INSERT INTO "moyenne_matiere" VALUES (143,10.0,8.0,8.0,9.0,8.5,8.5,'2022-02-10 04:55:02.785672',13,11,12);
INSERT INTO "moyenne_matiere" VALUES (144,14.0,9.0,16.0,12.0,14.0,14.0,'2022-02-10 04:55:28.136928',13,12,3);
INSERT INTO "moyenne_matiere" VALUES (145,7.0,7.0,5.0,7.0,6.0,6.0,'2022-02-10 04:55:52.749078',13,13,14);
INSERT INTO "moyenne_matiere" VALUES (146,13.0,7.0,14.0,10.0,12.0,12.0,'2022-02-10 04:56:43.132406',13,14,5);
INSERT INTO "moyenne_matiere" VALUES (147,10.0,13.0,10.0,12.0,11.0,11.0,'2022-02-10 04:57:04.659749',13,16,6);
INSERT INTO "moyenne_matiere" VALUES (148,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-10 06:02:26.754591',29,1,11);
INSERT INTO "moyenne_matiere" VALUES (149,11.0,13.0,12.0,12.0,12.0,12.0,'2022-02-10 06:02:53.448801',29,2,7);
INSERT INTO "moyenne_matiere" VALUES (150,7.0,7.0,7.0,7.0,7.0,7.0,'2022-02-10 06:03:05.557438',29,3,14);
INSERT INTO "moyenne_matiere" VALUES (151,12.0,12.0,12.0,12.0,12.0,12.0,'2022-02-10 06:03:30.160427',29,4,8);
INSERT INTO "moyenne_matiere" VALUES (152,8.0,10.0,9.0,9.0,9.0,9.0,'2022-02-10 06:03:55.982185',29,6,13);
INSERT INTO "moyenne_matiere" VALUES (153,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 06:04:31.249437',29,6,1);
INSERT INTO "moyenne_matiere" VALUES (154,12.0,10.0,11.0,11.0,11.0,11.0,'2022-02-10 06:05:01.782718',29,7,9);
INSERT INTO "moyenne_matiere" VALUES (155,15.0,13.0,14.0,14.0,14.0,14.0,'2022-02-10 06:05:35.936095',29,8,2);
INSERT INTO "moyenne_matiere" VALUES (156,12.0,10.0,11.0,11.0,11.0,11.0,'2022-02-10 06:06:02.986419',29,9,10);
INSERT INTO "moyenne_matiere" VALUES (157,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-10 06:06:22.573466',29,10,5);
INSERT INTO "moyenne_matiere" VALUES (158,5.0,5.0,5.0,5.0,5.0,5.0,'2022-02-10 06:06:55.678125',29,11,15);
INSERT INTO "moyenne_matiere" VALUES (159,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 06:07:30.085931',29,12,3);
INSERT INTO "moyenne_matiere" VALUES (160,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-10 06:07:52.612692',29,13,6);
INSERT INTO "moyenne_matiere" VALUES (161,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-10 06:08:19.023911',29,14,12);
INSERT INTO "moyenne_matiere" VALUES (162,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 06:08:43.700023',29,16,4);
INSERT INTO "moyenne_matiere" VALUES (163,5.0,5.0,6.0,5.0,5.5,16.5,'2022-02-10 10:36:50.480621',5,27,11);
INSERT INTO "moyenne_matiere" VALUES (164,7.0,11.0,8.0,9.0,8.5,25.5,'2022-02-10 10:37:26.633960',5,28,4);
INSERT INTO "moyenne_matiere" VALUES (165,3.0,8.0,8.0,6.0,7.0,21.0,'2022-02-10 10:38:16.879342',5,29,7);
INSERT INTO "moyenne_matiere" VALUES (166,6.0,11.0,6.0,8.0,7.0,21.0,'2022-02-10 10:39:19.621930',5,30,8);
INSERT INTO "moyenne_matiere" VALUES (167,11.0,14.0,7.0,12.0,9.5,28.5,'2022-02-10 10:40:30.407492',5,31,2);
INSERT INTO "moyenne_matiere" VALUES (168,7.0,5.0,3.0,6.0,4.5,13.5,'2022-02-10 10:41:53.961992',5,32,12);
INSERT INTO "moyenne_matiere" VALUES (169,5.0,5.0,4.0,5.0,4.5,13.5,'2022-02-10 10:43:11.622326',5,33,13);
INSERT INTO "moyenne_matiere" VALUES (170,4.0,4.0,5.0,4.0,4.5,13.5,'2022-02-10 10:44:31.206735',5,34,14);
INSERT INTO "moyenne_matiere" VALUES (171,10.0,5.0,7.0,8.0,7.5,22.5,'2022-02-10 10:45:25.109986',5,35,6);
INSERT INTO "moyenne_matiere" VALUES (172,12.0,7.0,6.0,10.0,8.0,24.0,'2022-02-10 10:46:13.467417',5,36,5);
INSERT INTO "moyenne_matiere" VALUES (174,10.0,13.0,11.0,12.0,11.5,34.5,'2022-02-10 10:48:10.917121',5,37,1);
INSERT INTO "moyenne_matiere" VALUES (175,5.0,8.0,7.0,6.0,6.5,19.5,'2022-02-10 10:48:51.206054',5,38,10);
INSERT INTO "moyenne_matiere" VALUES (176,7.0,11.0,10.0,9.0,9.5,28.5,'2022-02-10 10:49:33.213337',5,39,3);
INSERT INTO "moyenne_matiere" VALUES (177,5.0,12.0,6.0,8.0,7.0,21.0,'2022-02-10 10:50:21.537256',5,40,9);
INSERT INTO "moyenne_matiere" VALUES (178,8.0,5.0,6.0,6.0,6.0,12.0,'2022-02-10 10:54:24.800867',7,27,9);
INSERT INTO "moyenne_matiere" VALUES (179,17.0,11.0,12.0,14.0,13.0,26.0,'2022-02-10 10:55:47.494641',7,28,1);
INSERT INTO "moyenne_matiere" VALUES (180,16.0,13.0,12.0,14.0,13.0,26.0,'2022-02-10 10:57:11.119907',7,29,2);
INSERT INTO "moyenne_matiere" VALUES (181,10.0,3.0,12.0,6.0,9.0,18.0,'2022-02-10 10:58:15.334006',7,30,5);
INSERT INTO "moyenne_matiere" VALUES (182,9.0,4.0,13.0,6.0,9.5,19.0,'2022-02-10 10:59:58.399422',7,31,4);
INSERT INTO "moyenne_matiere" VALUES (183,9.0,4.0,3.0,6.0,4.5,9.0,'2022-02-10 11:00:57.055799',7,32,12);
INSERT INTO "moyenne_matiere" VALUES (184,7.0,6.0,2.0,6.0,4.0,8.0,'2022-02-10 11:01:52.505360',7,33,13);
INSERT INTO "moyenne_matiere" VALUES (185,4.0,3.0,8.0,4.0,6.0,12.0,'2022-02-10 11:03:15.107998',7,34,10);
INSERT INTO "moyenne_matiere" VALUES (186,7.0,3.0,7.0,5.0,6.0,12.0,'2022-02-10 11:04:32.534724',7,35,11);
INSERT INTO "moyenne_matiere" VALUES (187,10.0,6.0,7.0,8.0,7.5,15.0,'2022-02-10 11:06:11.333841',7,36,7);
INSERT INTO "moyenne_matiere" VALUES (188,11.0,8.0,5.0,10.0,7.5,15.0,'2022-02-10 11:07:49.811171',7,37,8);
INSERT INTO "moyenne_matiere" VALUES (189,6.0,4.0,3.0,5.0,4.0,8.0,'2022-02-10 11:08:31.492978',7,38,14);
INSERT INTO "moyenne_matiere" VALUES (191,12.0,4.0,9.0,8.0,8.5,17.0,'2022-02-10 11:11:03.278712',7,39,6);
INSERT INTO "moyenne_matiere" VALUES (192,14.0,4.0,11.0,9.0,10.0,20.0,'2022-02-10 11:11:52.609694',7,40,3);
INSERT INTO "moyenne_matiere" VALUES (193,11.0,11.0,11.0,11.0,11.0,22.0,'2022-02-10 11:25:47.321524',11,27,8);
INSERT INTO "moyenne_matiere" VALUES (194,10.0,13.0,10.0,12.0,11.0,22.0,'2022-02-10 11:27:11.744850',11,28,9);
INSERT INTO "moyenne_matiere" VALUES (195,13.0,14.0,13.0,14.0,13.5,27.0,'2022-02-10 11:30:29.860031',11,29,3);
INSERT INTO "moyenne_matiere" VALUES (196,11.0,15.0,11.0,13.0,12.0,24.0,'2022-02-10 11:31:15.084684',11,30,6);
INSERT INTO "moyenne_matiere" VALUES (197,13.0,11.0,13.0,12.0,12.5,25.0,'2022-02-10 11:31:48.720830',11,31,5);
INSERT INTO "moyenne_matiere" VALUES (198,9.0,10.0,9.0,10.0,9.5,19.0,'2022-02-10 11:32:55.573597',11,32,10);
INSERT INTO "moyenne_matiere" VALUES (199,9.0,12.0,9.0,10.0,9.5,19.0,'2022-02-10 11:34:09.906759',11,33,11);
INSERT INTO "moyenne_matiere" VALUES (200,8.0,8.0,8.0,8.0,8.0,16.0,'2022-02-10 11:34:56.712697',11,34,13);
INSERT INTO "moyenne_matiere" VALUES (201,12.0,12.0,12.0,12.0,12.0,24.0,'2022-02-10 11:35:39.850419',11,35,7);
INSERT INTO "moyenne_matiere" VALUES (202,9.0,10.0,9.0,10.0,9.5,19.0,'2022-02-10 11:36:27.091552',11,36,12);
INSERT INTO "moyenne_matiere" VALUES (203,14.0,13.0,14.0,14.0,14.0,28.0,'2022-02-10 11:37:33.497459',11,37,2);
INSERT INTO "moyenne_matiere" VALUES (204,7.0,8.0,7.0,8.0,7.5,15.0,'2022-02-10 11:38:18.819139',11,38,14);
INSERT INTO "moyenne_matiere" VALUES (205,13.0,14.0,13.0,14.0,13.5,27.0,'2022-02-10 11:39:07.157013',11,39,4);
INSERT INTO "moyenne_matiere" VALUES (206,15.0,14.0,15.0,14.0,14.5,29.0,'2022-02-10 11:39:55.046778',11,40,1);
INSERT INTO "moyenne_matiere" VALUES (207,6.0,10.0,9.0,8.0,8.5,17.0,'2022-02-10 11:44:11.597357',15,27,8);
INSERT INTO "moyenne_matiere" VALUES (208,6.0,14.0,9.0,10.0,9.5,19.0,'2022-02-10 11:45:00.243563',15,28,5);
INSERT INTO "moyenne_matiere" VALUES (209,12.0,14.0,13.0,13.0,13.0,26.0,'2022-02-10 11:45:40.340302',15,29,1);
INSERT INTO "moyenne_matiere" VALUES (213,5.0,10.0,8.0,8.0,8.0,16.0,'2022-02-10 11:49:43.846155',15,31,10);
INSERT INTO "moyenne_matiere" VALUES (214,5.5,8.0,9.0,7.0,8.0,16.0,'2022-02-10 11:50:56.345358',15,32,11);
INSERT INTO "moyenne_matiere" VALUES (215,6.0,8.0,8.0,7.0,7.5,15.0,'2022-02-10 11:51:45.639525',15,33,12);
INSERT INTO "moyenne_matiere" VALUES (216,6.0,7.5,6.0,7.0,6.5,13.0,'2022-02-10 11:52:36.350273',15,34,13);
INSERT INTO "moyenne_matiere" VALUES (217,9.0,13.0,11.0,11.0,11.0,22.0,'2022-02-10 11:53:36.929042',15,35,3);
INSERT INTO "moyenne_matiere" VALUES (218,4.0,8.0,12.0,6.0,9.0,18.0,'2022-02-10 11:54:30.528620',15,36,6);
INSERT INTO "moyenne_matiere" VALUES (219,9.0,10.0,8.0,10.0,9.0,18.0,'2022-02-10 11:55:52.058008',15,37,7);
INSERT INTO "moyenne_matiere" VALUES (220,7.0,9.0,9.0,8.0,8.5,17.0,'2022-02-10 11:56:29.801461',15,38,9);
INSERT INTO "moyenne_matiere" VALUES (221,9.0,12.5,11.0,11.0,11.0,22.0,'2022-02-10 11:58:16.395188',15,39,4);
INSERT INTO "moyenne_matiere" VALUES (222,9.0,12.5,12.0,11.0,11.5,23.0,'2022-02-10 11:58:43.697347',15,40,2);
INSERT INTO "moyenne_matiere" VALUES (223,14.0,10.0,7.0,12.0,9.5,19.0,'2022-02-10 12:03:10.036973',19,27,12);
INSERT INTO "moyenne_matiere" VALUES (224,14.0,14.0,12.0,14.0,13.0,26.0,'2022-02-10 12:03:42.738256',19,28,1);
INSERT INTO "moyenne_matiere" VALUES (225,15.0,15.0,9.0,15.0,12.0,24.0,'2022-02-10 12:04:16.588781',19,29,6);
INSERT INTO "moyenne_matiere" VALUES (226,12.0,16.0,11.0,14.0,12.5,25.0,'2022-02-10 12:05:41.303889',19,30,4);
INSERT INTO "moyenne_matiere" VALUES (227,14.0,13.0,9.0,14.0,11.5,23.0,'2022-02-10 12:06:13.919605',19,31,8);
INSERT INTO "moyenne_matiere" VALUES (228,17.0,15.0,8.0,16.0,12.0,24.0,'2022-02-10 12:06:51.892665',19,32,7);
INSERT INTO "moyenne_matiere" VALUES (229,17.0,14.0,7.0,16.0,11.5,23.0,'2022-02-10 12:07:38.961077',19,33,9);
INSERT INTO "moyenne_matiere" VALUES (230,8.0,6.0,6.0,7.0,6.5,13.0,'2022-02-10 12:08:50.082529',19,34,14);
INSERT INTO "moyenne_matiere" VALUES (231,11.0,13.0,8.0,12.0,10.0,20.0,'2022-02-10 12:10:36.803224',19,35,11);
INSERT INTO "moyenne_matiere" VALUES (232,16.0,15.0,7.0,16.0,11.5,23.0,'2022-02-10 12:11:30.620505',19,36,10);
INSERT INTO "moyenne_matiere" VALUES (233,14.25,15.0,11.0,15.0,13.0,26.0,'2022-02-10 12:13:18.195624',19,37,2);
INSERT INTO "moyenne_matiere" VALUES (234,9.0,8.0,8.0,8.0,8.0,16.0,'2022-02-10 12:14:25.078831',19,38,13);
INSERT INTO "moyenne_matiere" VALUES (235,12.0,12.0,13.0,12.0,12.5,25.0,'2022-02-10 12:15:12.069540',19,39,5);
INSERT INTO "moyenne_matiere" VALUES (236,15.0,12.0,12.0,14.0,13.0,26.0,'2022-02-10 12:15:53.243935',19,40,3);
INSERT INTO "moyenne_matiere" VALUES (237,11.0,6.0,6.0,8.0,7.0,14.0,'2022-02-10 12:19:34.734119',23,27,10);
INSERT INTO "moyenne_matiere" VALUES (238,15.0,11.0,7.0,13.0,10.0,20.0,'2022-02-10 12:20:09.040109',23,28,2);
INSERT INTO "moyenne_matiere" VALUES (239,15.0,11.0,13.0,13.0,13.0,26.0,'2022-02-10 12:20:33.397760',23,29,1);
INSERT INTO "moyenne_matiere" VALUES (240,14.0,10.0,4.0,12.0,8.0,16.0,'2022-02-10 12:21:02.703221',23,30,8);
INSERT INTO "moyenne_matiere" VALUES (241,15.0,11.0,6.0,13.0,9.5,19.0,'2022-02-10 12:21:52.453058',23,31,3);
INSERT INTO "moyenne_matiere" VALUES (242,10.0,12.0,7.0,11.0,9.0,18.0,'2022-02-10 12:22:24.699983',23,32,4);
INSERT INTO "moyenne_matiere" VALUES (243,10.0,10.0,6.0,10.0,8.0,16.0,'2022-02-10 12:22:50.372009',23,33,9);
INSERT INTO "moyenne_matiere" VALUES (244,10.0,6.0,5.0,8.0,6.5,13.0,'2022-02-10 12:23:36.487598',23,34,13);
INSERT INTO "moyenne_matiere" VALUES (245,9.0,9.0,5.0,9.0,7.0,14.0,'2022-02-10 12:24:18.089337',23,35,11);
INSERT INTO "moyenne_matiere" VALUES (246,7.0,10.0,4.0,8.0,6.0,12.0,'2022-02-10 12:24:59.188700',23,36,14);
INSERT INTO "moyenne_matiere" VALUES (247,11.0,12.0,6.0,12.0,9.0,18.0,'2022-02-10 12:25:43.699508',23,37,5);
INSERT INTO "moyenne_matiere" VALUES (248,11.0,4.0,6.0,8.0,7.0,14.0,'2022-02-10 12:26:48.619784',23,38,12);
INSERT INTO "moyenne_matiere" VALUES (249,15.0,12.0,4.0,14.0,9.0,18.0,'2022-02-10 12:27:40.929495',23,39,6);
INSERT INTO "moyenne_matiere" VALUES (250,15.0,6.0,7.0,10.0,8.5,17.0,'2022-02-10 12:28:16.032029',23,40,7);
INSERT INTO "moyenne_matiere" VALUES (251,12.0,13.0,13.0,12.0,12.5,25.0,'2022-02-10 12:29:34.790194',27,27,5);
INSERT INTO "moyenne_matiere" VALUES (252,16.0,15.0,15.0,16.0,15.5,31.0,'2022-02-10 12:29:58.719499',27,28,1);
INSERT INTO "moyenne_matiere" VALUES (253,13.0,13.0,13.0,13.0,13.0,26.0,'2022-02-10 12:30:29.944231',27,29,4);
INSERT INTO "moyenne_matiere" VALUES (254,15.0,13.0,13.0,14.0,13.5,27.0,'2022-02-10 12:30:59.300900',27,30,3);
INSERT INTO "moyenne_matiere" VALUES (255,12.0,11.0,11.0,12.0,11.5,23.0,'2022-02-10 12:31:29.968706',27,31,10);
INSERT INTO "moyenne_matiere" VALUES (256,12.0,10.0,10.0,11.0,10.5,21.0,'2022-02-10 12:31:55.713924',27,32,13);
INSERT INTO "moyenne_matiere" VALUES (257,12.0,13.0,13.0,12.0,12.5,25.0,'2022-02-10 12:32:52.176781',27,33,6);
INSERT INTO "moyenne_matiere" VALUES (258,7.0,10.0,10.0,8.0,9.0,18.0,'2022-02-10 12:33:45.231964',27,34,14);
INSERT INTO "moyenne_matiere" VALUES (259,13.0,10.0,10.0,12.0,11.0,22.0,'2022-02-10 12:34:15.692637',27,35,12);
INSERT INTO "moyenne_matiere" VALUES (260,10.0,13.0,13.0,12.0,12.5,25.0,'2022-02-10 12:34:55.177539',27,36,7);
INSERT INTO "moyenne_matiere" VALUES (261,15.0,14.0,14.0,14.0,14.0,28.0,'2022-02-10 12:35:41.291276',27,37,2);
INSERT INTO "moyenne_matiere" VALUES (262,12.0,12.0,12.0,12.0,12.0,24.0,'2022-02-10 12:38:31.336775',27,38,9);
INSERT INTO "moyenne_matiere" VALUES (263,10.0,12.0,12.0,11.0,11.5,23.0,'2022-02-10 12:39:24.713715',27,39,11);
INSERT INTO "moyenne_matiere" VALUES (264,14.0,12.0,12.0,13.0,12.5,25.0,'2022-02-10 12:39:49.846325',27,40,8);
INSERT INTO "moyenne_matiere" VALUES (265,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 12:41:02.876083',31,27,2);
INSERT INTO "moyenne_matiere" VALUES (266,13.0,11.0,12.0,12.0,12.0,12.0,'2022-02-10 12:42:17.347496',31,28,7);
INSERT INTO "moyenne_matiere" VALUES (267,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-10 12:44:42.189538',31,29,4);
INSERT INTO "moyenne_matiere" VALUES (268,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-10 12:45:56.124903',31,30,10);
INSERT INTO "moyenne_matiere" VALUES (269,15.0,15.0,15.0,15.0,15.0,15.0,'2022-02-10 12:46:35.907064',31,31,1);
INSERT INTO "moyenne_matiere" VALUES (270,13.0,11.0,12.0,12.0,12.0,12.0,'2022-02-10 12:47:25.094942',31,32,8);
INSERT INTO "moyenne_matiere" VALUES (271,8.0,8.0,8.0,8.0,8.0,8.0,'2022-02-10 12:47:51.204753',31,33,12);
INSERT INTO "moyenne_matiere" VALUES (272,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-10 12:50:04.782063',31,34,5);
INSERT INTO "moyenne_matiere" VALUES (273,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-10 12:50:54.350800',31,35,6);
INSERT INTO "moyenne_matiere" VALUES (274,5.0,5.0,5.0,5.0,5.0,5.0,'2022-02-10 12:51:41.098778',31,36,14);
INSERT INTO "moyenne_matiere" VALUES (275,7.0,7.0,7.0,7.0,7.0,7.0,'2022-02-10 12:52:20.395272',31,37,13);
INSERT INTO "moyenne_matiere" VALUES (276,12.0,12.0,12.0,12.0,12.0,12.0,'2022-02-10 12:52:46.622880',31,38,9);
INSERT INTO "moyenne_matiere" VALUES (277,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-10 12:53:12.620756',31,39,11);
INSERT INTO "moyenne_matiere" VALUES (278,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-10 12:53:44.477861',31,40,3);
INSERT INTO "moyenne_matiere" VALUES (279,6.0,11.0,7.0,8.0,7.5,15.0,'2022-02-12 08:24:43.327844',2,17,10);
INSERT INTO "moyenne_matiere" VALUES (280,12.0,12.0,16.0,12.0,14.0,28.0,'2022-02-12 08:25:45.145897',2,18,3);
INSERT INTO "moyenne_matiere" VALUES (281,10.0,17.0,16.0,14.0,15.0,30.0,'2022-02-12 08:26:24.672637',2,19,1);
INSERT INTO "moyenne_matiere" VALUES (282,13.0,12.0,18.0,12.0,15.0,30.0,'2022-02-12 08:27:24.723948',2,20,2);
INSERT INTO "moyenne_matiere" VALUES (283,5.0,12.0,8.0,8.0,8.0,16.0,'2022-02-12 08:28:00.753875',2,21,9);
INSERT INTO "moyenne_matiere" VALUES (284,13.0,12.0,14.0,12.0,13.0,26.0,'2022-02-12 08:29:04.285824',2,22,4);
INSERT INTO "moyenne_matiere" VALUES (285,10.0,14.0,12.0,12.0,12.0,24.0,'2022-02-12 08:29:30.442453',2,23,5);
INSERT INTO "moyenne_matiere" VALUES (286,9.0,12.0,9.0,10.0,9.5,19.0,'2022-02-12 08:30:15.245211',2,24,7);
INSERT INTO "moyenne_matiere" VALUES (287,9.0,17.0,11.0,13.0,12.0,24.0,'2022-02-12 08:31:02.421515',2,25,6);
INSERT INTO "moyenne_matiere" VALUES (288,8.0,14.0,6.0,11.0,8.5,17.0,'2022-02-12 08:32:45.113114',2,26,8);
INSERT INTO "moyenne_matiere" VALUES (289,3.0,13.0,12.0,8.0,10.0,10.0,'2022-02-12 08:33:53.589968',4,17,6);
INSERT INTO "moyenne_matiere" VALUES (290,13.5,16.0,5.0,15.0,10.0,10.0,'2022-02-12 08:34:48.541475',4,18,7);
INSERT INTO "moyenne_matiere" VALUES (291,10.0,17.0,9.0,14.0,11.5,11.5,'2022-02-12 08:37:19.479067',4,19,3);
INSERT INTO "moyenne_matiere" VALUES (292,14.0,12.0,12.0,13.0,12.5,12.5,'2022-02-12 08:38:08.662559',4,20,2);
INSERT INTO "moyenne_matiere" VALUES (293,6.0,12.0,7.0,9.0,8.0,8.0,'2022-02-12 08:38:47.426276',4,21,10);
INSERT INTO "moyenne_matiere" VALUES (294,12.0,12.0,11.0,12.0,11.5,11.5,'2022-02-12 08:39:09.602999',4,22,4);
INSERT INTO "moyenne_matiere" VALUES (295,9.0,14.0,9.0,12.0,10.5,10.5,'2022-02-12 08:39:35.484209',4,23,5);
INSERT INTO "moyenne_matiere" VALUES (296,8.0,12.0,10.0,10.0,10.0,10.0,'2022-02-12 08:40:56.087063',4,24,8);
INSERT INTO "moyenne_matiere" VALUES (297,16.5,17.0,18.0,17.0,17.5,17.5,'2022-02-12 08:42:14.066828',4,25,1);
INSERT INTO "moyenne_matiere" VALUES (298,4.0,14.0,10.0,9.0,9.5,9.5,'2022-02-12 08:42:58.173547',4,26,9);
INSERT INTO "moyenne_matiere" VALUES (299,8.5,11.5,13.0,10.0,11.5,11.5,'2022-02-12 08:49:57.503835',10,17,5);
INSERT INTO "moyenne_matiere" VALUES (300,9.0,11.0,14.0,10.0,12.0,12.0,'2022-02-12 08:50:30.147774',10,18,4);
INSERT INTO "moyenne_matiere" VALUES (301,16.5,13.5,14.5,15.0,14.75,14.75,'2022-02-12 08:51:56.499859',10,19,1);
INSERT INTO "moyenne_matiere" VALUES (302,15.0,12.0,13.5,14.0,13.75,13.75,'2022-02-12 08:54:25.398964',10,20,3);
INSERT INTO "moyenne_matiere" VALUES (303,13.0,7.0,7.0,10.0,8.5,8.5,'2022-02-12 08:55:19.393876',10,21,8);
INSERT INTO "moyenne_matiere" VALUES (304,13.5,12.0,15.5,13.0,14.25,14.25,'2022-02-12 08:56:37.141347',10,22,2);
INSERT INTO "moyenne_matiere" VALUES (305,10.5,7.0,6.5,9.0,7.75,7.75,'2022-02-12 08:59:34.171739',10,23,9);
INSERT INTO "moyenne_matiere" VALUES (306,13.0,11.0,10.0,12.0,11.0,11.0,'2022-02-12 09:01:42.921447',10,24,7);
INSERT INTO "moyenne_matiere" VALUES (307,13.25,12.0,10.0,13.0,11.5,11.5,'2022-02-12 09:04:31.214007',10,25,6);
INSERT INTO "moyenne_matiere" VALUES (308,9.0,10.5,5.5,10.0,7.75,7.75,'2022-02-12 09:06:37.779712',10,26,10);
INSERT INTO "moyenne_matiere" VALUES (309,10.25,9.0,8.0,10.0,9.0,9.0,'2022-02-12 09:10:55.145895',26,17,10);
INSERT INTO "moyenne_matiere" VALUES (310,14.5,11.0,14.5,13.0,13.75,13.75,'2022-02-12 09:11:44.385086',26,18,5);
INSERT INTO "moyenne_matiere" VALUES (311,14.0,15.5,15.0,15.0,15.0,15.0,'2022-02-12 09:12:21.406395',26,19,2);
INSERT INTO "moyenne_matiere" VALUES (312,16.5,14.75,12.0,16.0,14.0,14.0,'2022-02-12 09:15:15.769052',26,20,3);
INSERT INTO "moyenne_matiere" VALUES (313,14.5,9.0,11.0,12.0,11.5,11.5,'2022-02-12 09:18:40.312220',26,21,8);
INSERT INTO "moyenne_matiere" VALUES (314,19.0,18.5,14.5,19.0,16.75,16.75,'2022-02-12 09:19:28.852573',26,22,1);
INSERT INTO "moyenne_matiere" VALUES (315,15.25,12.0,8.0,14.0,11.0,11.0,'2022-02-12 09:22:42.533187',26,23,9);
INSERT INTO "moyenne_matiere" VALUES (316,16.0,12.0,9.5,14.0,11.75,11.75,'2022-02-12 09:23:37.120439',26,24,7);
INSERT INTO "moyenne_matiere" VALUES (317,14.5,15.5,13.0,15.0,14.0,14.0,'2022-02-12 09:26:55.657540',26,25,4);
INSERT INTO "moyenne_matiere" VALUES (318,13.0,12.5,14.5,13.0,13.75,13.75,'2022-02-12 09:27:38.577395',26,26,6);
INSERT INTO "moyenne_matiere" VALUES (319,12.0,12.0,9.0,12.0,10.5,10.5,'2022-02-14 05:54:05.605622',22,17,9);
INSERT INTO "moyenne_matiere" VALUES (320,14.0,15.25,13.0,15.0,14.0,14.0,'2022-02-14 05:54:34.368790',22,18,5);
INSERT INTO "moyenne_matiere" VALUES (321,14.0,18.0,16.0,16.0,16.0,16.0,'2022-02-14 05:55:24.695902',22,19,2);
INSERT INTO "moyenne_matiere" VALUES (322,13.0,16.0,14.0,14.0,14.0,14.0,'2022-02-14 05:55:52.965179',22,20,6);
INSERT INTO "moyenne_matiere" VALUES (323,13.0,14.0,7.0,14.0,10.5,10.5,'2022-02-14 05:56:17.673876',22,21,10);
INSERT INTO "moyenne_matiere" VALUES (324,15.0,17.0,17.0,16.0,16.5,16.5,'2022-02-14 05:56:47.696775',22,22,1);
INSERT INTO "moyenne_matiere" VALUES (325,13.0,15.0,11.0,14.0,12.5,12.5,'2022-02-14 05:57:52.967007',22,23,7);
INSERT INTO "moyenne_matiere" VALUES (326,13.0,18.0,14.0,16.0,15.0,15.0,'2022-02-14 05:58:14.921964',22,24,4);
INSERT INTO "moyenne_matiere" VALUES (327,14.0,17.0,16.0,16.0,16.0,16.0,'2022-02-14 05:59:03.822515',22,25,3);
INSERT INTO "moyenne_matiere" VALUES (328,13.0,11.0,10.0,12.0,11.0,11.0,'2022-02-14 05:59:40.710696',22,26,8);
INSERT INTO "moyenne_matiere" VALUES (329,10.25,11.0,9.0,11.0,10.0,10.0,'2022-02-14 06:00:25.487771',18,17,10);
INSERT INTO "moyenne_matiere" VALUES (330,14.0,16.0,18.0,15.0,16.5,16.5,'2022-02-14 06:01:03.857858',18,18,3);
INSERT INTO "moyenne_matiere" VALUES (331,16.0,16.0,18.0,16.0,17.0,17.0,'2022-02-14 06:01:27.637586',18,19,2);
INSERT INTO "moyenne_matiere" VALUES (332,14.0,14.0,16.0,14.0,15.0,15.0,'2022-02-14 06:01:49.065163',18,20,6);
INSERT INTO "moyenne_matiere" VALUES (333,11.0,13.0,13.0,12.0,12.5,12.5,'2022-02-14 06:02:15.322846',18,21,9);
INSERT INTO "moyenne_matiere" VALUES (334,16.0,18.0,18.0,17.0,17.5,17.5,'2022-02-14 06:02:46.610166',18,22,1);
INSERT INTO "moyenne_matiere" VALUES (335,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-14 06:03:06.483032',18,23,8);
INSERT INTO "moyenne_matiere" VALUES (336,15.0,17.0,17.0,16.0,16.5,16.5,'2022-02-14 06:03:31.632102',18,24,4);
INSERT INTO "moyenne_matiere" VALUES (337,13.0,15.0,17.0,14.0,15.5,15.5,'2022-02-14 06:04:07.558214',18,25,5);
INSERT INTO "moyenne_matiere" VALUES (338,15.0,16.0,12.0,16.0,14.0,14.0,'2022-02-14 06:04:45.054240',18,26,7);
INSERT INTO "moyenne_matiere" VALUES (339,10.25,15.0,8.0,13.0,10.5,10.5,'2022-02-14 06:05:23.839056',14,17,7);
INSERT INTO "moyenne_matiere" VALUES (340,14.0,10.0,16.0,12.0,14.0,14.0,'2022-02-14 06:05:50.561236',14,18,4);
INSERT INTO "moyenne_matiere" VALUES (341,15.0,15.0,15.0,15.0,15.0,15.0,'2022-02-14 06:06:06.270008',14,19,3);
INSERT INTO "moyenne_matiere" VALUES (342,16.0,12.0,12.0,14.0,13.0,13.0,'2022-02-14 06:06:23.357004',14,20,5);
INSERT INTO "moyenne_matiere" VALUES (343,11.0,6.25,9.0,9.0,9.0,9.0,'2022-02-14 06:06:56.050309',14,21,10);
INSERT INTO "moyenne_matiere" VALUES (344,20.0,17.25,19.0,19.0,19.0,19.0,'2022-02-14 06:07:40.691103',14,22,1);
INSERT INTO "moyenne_matiere" VALUES (345,12.0,8.0,11.0,10.0,10.5,10.5,'2022-02-14 06:08:39.329061',14,23,8);
INSERT INTO "moyenne_matiere" VALUES (346,11.0,13.0,9.0,12.0,10.5,10.5,'2022-02-14 06:09:03.033794',14,24,9);
INSERT INTO "moyenne_matiere" VALUES (347,17.0,9.0,12.0,13.0,12.5,12.5,'2022-02-14 06:09:22.946027',14,25,6);
INSERT INTO "moyenne_matiere" VALUES (348,16.0,13.25,16.0,15.0,15.5,15.5,'2022-02-14 06:09:47.645764',14,26,2);
INSERT INTO "moyenne_matiere" VALUES (349,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-14 06:10:32.457709',30,17,2);
INSERT INTO "moyenne_matiere" VALUES (350,13.0,10.25,11.5,12.0,11.75,11.75,'2022-02-14 06:10:59.753883',30,18,7);
INSERT INTO "moyenne_matiere" VALUES (351,14.0,12.0,13.0,13.0,13.0,13.0,'2022-02-14 06:11:19.986904',30,19,4);
INSERT INTO "moyenne_matiere" VALUES (352,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-14 06:11:44.578305',30,20,5);
INSERT INTO "moyenne_matiere" VALUES (353,11.0,11.0,11.0,11.0,11.0,11.0,'2022-02-14 06:12:03.136277',30,21,8);
INSERT INTO "moyenne_matiere" VALUES (354,14.0,16.0,15.0,15.0,15.0,15.0,'2022-02-14 06:12:22.450277',30,22,1);
INSERT INTO "moyenne_matiere" VALUES (355,13.0,13.0,13.0,13.0,13.0,13.0,'2022-02-14 06:12:39.648225',30,23,6);
INSERT INTO "moyenne_matiere" VALUES (356,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-14 06:13:01.347491',30,24,9);
INSERT INTO "moyenne_matiere" VALUES (357,8.0,8.0,8.0,8.0,8.0,8.0,'2022-02-14 06:13:13.254581',30,25,10);
INSERT INTO "moyenne_matiere" VALUES (358,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-14 06:13:27.068754',30,26,3);
INSERT INTO "moyenne_matiere" VALUES (359,9.0,5.0,10.0,7.0,8.5,25.5,'2022-02-14 06:34:34.559190',6,41,5);
INSERT INTO "moyenne_matiere" VALUES (360,6.0,4.0,6.0,5.0,5.5,16.5,'2022-02-14 06:34:53.353910',6,42,18);
INSERT INTO "moyenne_matiere" VALUES (361,8.0,6.0,5.0,7.0,6.0,18.0,'2022-02-14 06:35:08.206072',6,43,17);
INSERT INTO "moyenne_matiere" VALUES (362,6.0,4.0,8.0,5.0,6.5,19.5,'2022-02-14 06:35:32.156037',6,44,12);
INSERT INTO "moyenne_matiere" VALUES (363,6.0,8.0,7.0,7.0,7.0,21.0,'2022-02-14 06:37:36.027004',6,45,9);
INSERT INTO "moyenne_matiere" VALUES (364,6.0,3.0,9.0,4.0,6.5,19.5,'2022-02-14 06:37:56.391012',6,46,13);
INSERT INTO "moyenne_matiere" VALUES (365,9.0,9.0,8.0,9.0,8.5,25.5,'2022-02-14 06:38:20.825732',6,47,6);
INSERT INTO "moyenne_matiere" VALUES (366,7.0,10.0,8.0,8.0,8.0,24.0,'2022-02-14 06:38:47.028211',6,48,7);
INSERT INTO "moyenne_matiere" VALUES (367,7.0,5.0,4.0,6.0,5.0,15.0,'2022-02-14 06:39:13.559378',6,49,19);
INSERT INTO "moyenne_matiere" VALUES (368,9.0,8.0,5.0,8.0,6.5,19.5,'2022-02-14 06:39:39.123773',6,50,14);
INSERT INTO "moyenne_matiere" VALUES (369,4.0,4.0,5.0,4.0,4.5,13.5,'2022-02-14 06:40:00.872963',6,51,21);
INSERT INTO "moyenne_matiere" VALUES (370,16.0,18.0,18.0,17.0,17.5,52.5,'2022-02-14 06:40:29.573728',6,52,1);
INSERT INTO "moyenne_matiere" VALUES (371,10.0,12.0,8.0,11.0,9.5,28.5,'2022-02-14 06:41:04.519222',6,53,4);
INSERT INTO "moyenne_matiere" VALUES (372,8.0,6.0,6.0,7.0,6.5,19.5,'2022-02-14 06:41:33.007761',6,54,15);
INSERT INTO "moyenne_matiere" VALUES (373,6.0,7.0,4.0,6.0,5.0,15.0,'2022-02-14 06:42:13.133482',6,55,20);
INSERT INTO "moyenne_matiere" VALUES (374,8.0,5.0,8.0,6.0,7.0,21.0,'2022-02-14 06:42:50.931458',6,56,10);
INSERT INTO "moyenne_matiere" VALUES (375,8.0,9.0,7.0,8.0,7.5,22.5,'2022-02-14 06:43:18.063810',6,57,8);
INSERT INTO "moyenne_matiere" VALUES (376,3.25,10.0,7.0,7.0,7.0,21.0,'2022-02-14 06:44:14.609253',6,58,11);
INSERT INTO "moyenne_matiere" VALUES (377,17.0,13.0,9.0,15.0,12.0,36.0,'2022-02-14 06:45:11.993843',6,59,2);
INSERT INTO "moyenne_matiere" VALUES (378,6.0,8.0,6.0,7.0,6.5,19.5,'2022-02-14 06:45:36.343047',6,60,16);
INSERT INTO "moyenne_matiere" VALUES (379,10.0,10.0,12.0,10.0,11.0,33.0,'2022-02-14 06:45:58.788053',6,61,3);
INSERT INTO "moyenne_matiere" VALUES (380,13.25,12.0,11.0,13.0,12.0,24.0,'2022-02-14 06:47:13.130243',12,41,2);
INSERT INTO "moyenne_matiere" VALUES (381,13.0,8.0,7.0,10.0,8.5,17.0,'2022-02-14 06:47:33.033207',12,42,14);
INSERT INTO "moyenne_matiere" VALUES (382,12.0,11.0,7.0,12.0,9.5,19.0,'2022-02-14 06:47:52.076344',12,43,10);
INSERT INTO "moyenne_matiere" VALUES (383,13.0,9.0,7.0,11.0,9.0,18.0,'2022-02-14 06:48:21.613701',12,44,13);
INSERT INTO "moyenne_matiere" VALUES (384,8.0,8.0,7.0,8.0,7.5,15.0,'2022-02-14 06:50:06.880387',12,45,19);
INSERT INTO "moyenne_matiere" VALUES (385,11.0,13.0,7.0,12.0,9.5,19.0,'2022-02-14 06:50:45.413229',12,46,11);
INSERT INTO "moyenne_matiere" VALUES (386,14.0,12.0,8.0,13.0,10.5,21.0,'2022-02-14 06:51:14.894163',12,47,8);
INSERT INTO "moyenne_matiere" VALUES (387,13.0,15.0,9.0,14.0,11.5,23.0,'2022-02-14 16:21:38.701011',12,48,6);
INSERT INTO "moyenne_matiere" VALUES (388,10.0,8.0,8.0,9.0,8.5,17.0,'2022-02-14 16:22:04.076070',12,49,15);
INSERT INTO "moyenne_matiere" VALUES (389,13.0,10.0,7.0,12.0,9.5,19.0,'2022-02-14 16:22:31.343698',12,50,12);
INSERT INTO "moyenne_matiere" VALUES (390,9.0,11.0,7.0,10.0,8.5,17.0,'2022-02-14 16:23:28.799916',12,51,16);
INSERT INTO "moyenne_matiere" VALUES (391,14.0,12.0,11.0,13.0,12.0,24.0,'2022-02-14 16:24:33.210560',12,52,3);
INSERT INTO "moyenne_matiere" VALUES (392,13.0,12.0,11.0,12.0,11.5,23.0,'2022-02-14 16:25:57.729137',12,53,7);
INSERT INTO "moyenne_matiere" VALUES (393,10.0,8.0,6.0,9.0,7.5,15.0,'2022-02-14 16:26:56.900407',12,54,20);
INSERT INTO "moyenne_matiere" VALUES (394,10.0,9.0,6.0,10.0,8.0,16.0,'2022-02-14 16:27:20.485064',12,55,17);
INSERT INTO "moyenne_matiere" VALUES (395,12.0,11.0,9.0,12.0,10.5,21.0,'2022-02-14 16:28:41.692134',12,56,9);
INSERT INTO "moyenne_matiere" VALUES (396,13.0,10.0,12.0,12.0,12.0,24.0,'2022-02-14 16:29:25.953172',12,57,4);
INSERT INTO "moyenne_matiere" VALUES (397,11.0,9.0,6.0,10.0,8.0,16.0,'2022-02-14 16:30:02.684057',12,58,18);
INSERT INTO "moyenne_matiere" VALUES (398,11.0,14.0,13.0,12.0,12.5,25.0,'2022-02-14 16:30:31.134176',12,59,1);
INSERT INTO "moyenne_matiere" VALUES (399,11.0,6.25,6.0,9.0,7.5,15.0,'2022-02-14 16:30:52.060295',12,60,21);
INSERT INTO "moyenne_matiere" VALUES (400,12.0,11.0,12.0,12.0,12.0,24.0,'2022-02-14 16:31:22.631806',12,61,5);
INSERT INTO "moyenne_matiere" VALUES (401,5.0,5.0,8.0,5.0,6.5,13.0,'2022-02-15 04:29:47.370164',16,41,8);
INSERT INTO "moyenne_matiere" VALUES (402,3.0,4.0,4.0,4.0,4.0,8.0,'2022-02-15 04:30:01.242377',16,42,19);
INSERT INTO "moyenne_matiere" VALUES (403,6.0,4.0,7.0,5.0,6.0,12.0,'2022-02-15 04:30:33.043295',16,43,12);
INSERT INTO "moyenne_matiere" VALUES (404,2.0,4.0,5.0,3.0,4.0,8.0,'2022-02-15 04:31:02.903683',16,44,20);
INSERT INTO "moyenne_matiere" VALUES (405,4.0,2.0,7.0,3.0,5.0,10.0,'2022-02-15 04:31:26.079886',16,45,16);
INSERT INTO "moyenne_matiere" VALUES (406,5.0,1.0,4.0,3.0,3.5,7.0,'2022-02-15 04:31:57.259000',16,46,21);
INSERT INTO "moyenne_matiere" VALUES (407,4.0,6.0,12.0,5.0,8.5,17.0,'2022-02-15 04:32:19.693112',16,47,3);
INSERT INTO "moyenne_matiere" VALUES (408,5.0,6.0,8.0,6.0,7.0,14.0,'2022-02-15 04:32:56.366076',16,48,7);
INSERT INTO "moyenne_matiere" VALUES (409,3.0,7.0,10.0,5.0,7.5,15.0,'2022-02-15 04:33:33.395033',16,49,5);
INSERT INTO "moyenne_matiere" VALUES (410,4.0,4.0,7.0,4.0,5.5,11.0,'2022-02-15 04:34:01.042332',16,50,15);
INSERT INTO "moyenne_matiere" VALUES (411,3.0,4.0,9.0,4.0,6.5,13.0,'2022-02-15 04:35:27.079387',16,51,9);
INSERT INTO "moyenne_matiere" VALUES (412,4.0,3.0,6.0,4.0,5.0,10.0,'2022-02-15 04:35:55.229638',16,52,17);
INSERT INTO "moyenne_matiere" VALUES (413,6.0,5.0,6.0,6.0,6.0,12.0,'2022-02-15 04:37:25.881282',16,53,13);
INSERT INTO "moyenne_matiere" VALUES (414,5.0,3.0,11.0,4.0,7.5,15.0,'2022-02-15 04:38:00.678090',16,54,6);
INSERT INTO "moyenne_matiere" VALUES (415,4.0,2.0,7.0,3.0,5.0,10.0,'2022-02-15 04:38:54.408200',16,55,18);
INSERT INTO "moyenne_matiere" VALUES (416,4.25,5.0,8.0,5.0,6.5,13.0,'2022-02-15 04:39:42.517407',16,56,10);
INSERT INTO "moyenne_matiere" VALUES (417,2.25,7.0,8.0,5.0,6.5,13.0,'2022-02-15 04:41:40.228935',16,57,11);
INSERT INTO "moyenne_matiere" VALUES (418,5.0,5.0,7.0,5.0,6.0,12.0,'2022-02-15 04:42:24.818420',16,58,14);
INSERT INTO "moyenne_matiere" VALUES (419,7.0,7.0,14.0,7.0,10.5,21.0,'2022-02-15 04:42:57.376320',16,59,1);
INSERT INTO "moyenne_matiere" VALUES (420,5.0,4.25,11.0,5.0,8.0,16.0,'2022-02-15 04:43:50.119269',16,60,4);
INSERT INTO "moyenne_matiere" VALUES (421,7.25,8.0,13.0,8.0,10.5,21.0,'2022-02-15 04:44:31.542310',16,61,2);
INSERT INTO "moyenne_matiere" VALUES (422,7.0,5.0,4.0,6.0,5.0,10.0,'2022-02-15 04:46:04.651194',24,41,12);
INSERT INTO "moyenne_matiere" VALUES (423,3.0,7.0,5.0,5.0,5.0,10.0,'2022-02-15 04:46:28.072857',24,42,13);
INSERT INTO "moyenne_matiere" VALUES (424,6.0,6.0,5.0,6.0,5.5,11.0,'2022-02-15 04:46:54.668424',24,43,10);
INSERT INTO "moyenne_matiere" VALUES (425,5.0,8.0,10.0,6.0,8.0,16.0,'2022-02-15 04:47:38.752230',24,44,5);
INSERT INTO "moyenne_matiere" VALUES (426,3.0,5.0,3.0,4.0,3.5,7.0,'2022-02-15 04:48:22.081844',24,45,17);
INSERT INTO "moyenne_matiere" VALUES (427,4.0,7.0,5.0,6.0,5.5,11.0,'2022-02-15 04:49:01.836877',24,46,11);
INSERT INTO "moyenne_matiere" VALUES (428,9.0,8.0,7.0,8.0,7.5,15.0,'2022-02-15 04:49:28.256767',24,47,6);
INSERT INTO "moyenne_matiere" VALUES (429,7.25,10.0,6.0,9.0,7.5,15.0,'2022-02-15 04:50:07.257549',24,48,7);
INSERT INTO "moyenne_matiere" VALUES (430,5.25,8.0,5.0,7.0,6.0,12.0,'2022-02-15 04:50:55.076168',24,49,8);
INSERT INTO "moyenne_matiere" VALUES (431,5.0,5.0,5.0,5.0,5.0,10.0,'2022-02-15 04:52:06.080281',24,54,14);
INSERT INTO "moyenne_matiere" VALUES (432,3.0,5.0,6.0,4.0,5.0,10.0,'2022-02-15 04:52:45.068247',24,55,15);
INSERT INTO "moyenne_matiere" VALUES (433,7.0,9.0,10.0,8.0,9.0,18.0,'2022-02-15 04:53:23.618720',24,56,4);
INSERT INTO "moyenne_matiere" VALUES (434,11.25,12.0,10.0,12.0,11.0,22.0,'2022-02-15 04:54:06.213203',24,57,1);
INSERT INTO "moyenne_matiere" VALUES (435,6.0,6.0,3.0,6.0,4.5,9.0,'2022-02-15 04:54:42.539547',24,58,16);
INSERT INTO "moyenne_matiere" VALUES (436,11.25,12.0,7.0,12.0,9.5,19.0,'2022-02-15 04:55:14.040265',24,59,2);
INSERT INTO "moyenne_matiere" VALUES (437,7.0,7.0,5.0,7.0,6.0,12.0,'2022-02-15 04:55:30.577085',24,60,9);
INSERT INTO "moyenne_matiere" VALUES (438,12.0,12.0,7.0,12.0,9.5,19.0,'2022-02-15 04:55:48.143504',24,61,3);
INSERT INTO "moyenne_matiere" VALUES (439,16.0,15.25,10.0,16.0,13.0,26.0,'2022-02-15 04:56:59.861215',20,41,6);
INSERT INTO "moyenne_matiere" VALUES (440,17.0,11.0,11.0,14.0,12.5,25.0,'2022-02-15 04:57:20.289324',20,42,7);
INSERT INTO "moyenne_matiere" VALUES (441,17.0,11.0,8.0,14.0,11.0,22.0,'2022-02-15 04:57:49.641361',20,43,14);
INSERT INTO "moyenne_matiere" VALUES (442,18.0,10.0,9.0,14.0,11.5,23.0,'2022-02-15 04:58:21.651652',20,44,11);
INSERT INTO "moyenne_matiere" VALUES (443,11.0,8.25,8.0,10.0,9.0,18.0,'2022-02-15 04:59:12.052509',20,45,19);
INSERT INTO "moyenne_matiere" VALUES (444,10.0,10.0,9.0,10.0,9.5,19.0,'2022-02-15 04:59:46.116540',20,46,18);
INSERT INTO "moyenne_matiere" VALUES (445,18.0,16.0,14.0,17.0,15.5,31.0,'2022-02-15 05:01:00.486429',20,47,2);
INSERT INTO "moyenne_matiere" VALUES (446,13.0,13.0,7.0,13.0,10.0,20.0,'2022-02-15 05:01:26.140877',20,48,17);
INSERT INTO "moyenne_matiere" VALUES (447,13.0,10.25,10.0,12.0,11.0,22.0,'2022-02-15 05:01:59.788570',20,49,15);
INSERT INTO "moyenne_matiere" VALUES (448,13.0,11.0,10.0,12.0,11.0,22.0,'2022-02-15 05:05:57.008083',20,50,16);
INSERT INTO "moyenne_matiere" VALUES (449,14.0,10.0,12.0,12.0,12.0,24.0,'2022-02-15 05:06:32.700340',20,51,9);
INSERT INTO "moyenne_matiere" VALUES (450,17.0,9.0,11.0,13.0,12.0,24.0,'2022-02-15 05:07:06.584139',20,52,10);
INSERT INTO "moyenne_matiere" VALUES (451,16.0,14.0,13.0,15.0,14.0,28.0,'2022-02-15 05:07:43.508569',20,53,4);
INSERT INTO "moyenne_matiere" VALUES (452,10.0,4.0,11.0,7.0,9.0,18.0,'2022-02-15 05:08:17.354762',20,54,20);
INSERT INTO "moyenne_matiere" VALUES (453,14.0,4.0,9.0,9.0,9.0,18.0,'2022-02-15 05:08:51.947779',20,55,21);
INSERT INTO "moyenne_matiere" VALUES (454,15.0,9.0,11.0,12.0,11.5,23.0,'2022-02-15 05:09:40.996303',20,56,12);
INSERT INTO "moyenne_matiere" VALUES (455,15.0,14.25,14.0,15.0,14.5,29.0,'2022-02-15 05:10:28.967517',20,57,3);
INSERT INTO "moyenne_matiere" VALUES (456,15.0,7.0,12.0,11.0,11.5,23.0,'2022-02-15 05:11:07.304279',20,58,13);
INSERT INTO "moyenne_matiere" VALUES (457,16.0,16.0,16.0,16.0,16.0,32.0,'2022-02-15 05:11:34.313656',20,59,1);
INSERT INTO "moyenne_matiere" VALUES (458,15.0,7.0,14.0,11.0,12.5,25.0,'2022-02-15 05:11:58.576335',20,60,8);
INSERT INTO "moyenne_matiere" VALUES (459,15.0,14.25,13.0,15.0,14.0,28.0,'2022-02-15 05:12:28.789467',20,61,5);
INSERT INTO "moyenne_matiere" VALUES (460,13.0,8.25,10.5,11.0,10.75,21.5,'2022-02-15 05:14:09.648756',28,41,6);
INSERT INTO "moyenne_matiere" VALUES (461,9.0,9.0,9.0,9.0,9.0,18.0,'2022-02-15 05:14:24.988314',28,42,14);
INSERT INTO "moyenne_matiere" VALUES (462,6.25,9.0,5.5,8.0,6.75,13.5,'2022-02-15 05:14:53.681636',28,43,20);
INSERT INTO "moyenne_matiere" VALUES (463,12.0,9.25,9.0,11.0,10.0,20.0,'2022-02-15 05:15:42.498094',28,44,11);
INSERT INTO "moyenne_matiere" VALUES (464,8.5,7.0,5.0,8.0,6.5,13.0,'2022-02-15 05:16:17.649075',28,45,21);
INSERT INTO "moyenne_matiere" VALUES (465,7.25,10.0,6.0,9.0,7.5,15.0,'2022-02-15 05:16:57.877361',28,46,17);
INSERT INTO "moyenne_matiere" VALUES (466,8.75,14.5,9.0,12.0,10.5,21.0,'2022-02-15 05:18:01.840004',28,47,8);
INSERT INTO "moyenne_matiere" VALUES (467,9.0,12.25,8.0,11.0,9.5,19.0,'2022-02-15 05:18:59.897255',28,48,12);
INSERT INTO "moyenne_matiere" VALUES (468,7.0,12.75,4.0,10.0,7.0,14.0,'2022-02-15 05:20:01.431360',28,49,18);
INSERT INTO "moyenne_matiere" VALUES (469,9.0,12.5,7.5,11.0,9.25,18.5,'2022-02-15 05:21:28.722652',28,50,13);
INSERT INTO "moyenne_matiere" VALUES (470,8.0,11.5,11.5,10.0,10.75,21.5,'2022-02-15 05:22:11.998754',28,51,7);
INSERT INTO "moyenne_matiere" VALUES (471,11.0,10.5,10.0,11.0,10.5,21.0,'2022-02-15 05:22:52.359068',28,52,9);
INSERT INTO "moyenne_matiere" VALUES (472,11.0,13.0,10.0,12.0,11.0,22.0,'2022-02-15 05:23:28.203606',28,53,5);
INSERT INTO "moyenne_matiere" VALUES (473,8.0,7.5,7.5,8.0,7.75,15.5,'2022-02-15 05:24:17.413464',28,54,16);
INSERT INTO "moyenne_matiere" VALUES (474,9.0,10.5,10.5,10.0,10.25,20.5,'2022-02-15 05:24:56.906219',28,55,10);
INSERT INTO "moyenne_matiere" VALUES (475,8.75,12.5,16.0,11.0,13.5,27.0,'2022-02-15 05:26:29.615523',28,56,3);
INSERT INTO "moyenne_matiere" VALUES (476,11.0,12.5,11.5,12.0,11.75,23.5,'2022-02-15 05:27:17.783917',28,57,4);
INSERT INTO "moyenne_matiere" VALUES (477,10.0,13.25,6.0,12.0,9.0,18.0,'2022-02-15 05:28:10.106948',28,58,15);
INSERT INTO "moyenne_matiere" VALUES (478,13.5,18.5,14.0,16.0,15.0,30.0,'2022-02-15 05:28:40.261300',28,59,1);
INSERT INTO "moyenne_matiere" VALUES (479,8.0,7.25,6.0,8.0,7.0,14.0,'2022-02-15 05:29:42.320663',28,60,19);
INSERT INTO "moyenne_matiere" VALUES (480,12.5,17.0,14.5,15.0,14.75,29.5,'2022-02-15 05:30:25.613685',28,61,2);
INSERT INTO "moyenne_matiere" VALUES (481,6.25,11.0,10.0,9.0,9.5,19.0,'2022-02-15 05:31:51.789558',8,41,10);
INSERT INTO "moyenne_matiere" VALUES (482,5.25,8.0,11.0,7.0,9.0,18.0,'2022-02-15 05:32:39.462301',8,42,14);
INSERT INTO "moyenne_matiere" VALUES (483,7.5,8.0,11.0,8.0,9.5,19.0,'2022-02-15 05:33:07.301983',8,43,11);
INSERT INTO "moyenne_matiere" VALUES (484,8.0,7.5,8.0,8.0,8.0,16.0,'2022-02-15 05:34:52.187909',8,44,18);
INSERT INTO "moyenne_matiere" VALUES (485,4.0,5.5,4.0,5.0,4.5,9.0,'2022-02-15 05:35:32.072234',8,45,21);
INSERT INTO "moyenne_matiere" VALUES (486,6.0,4.0,8.0,5.0,6.5,13.0,'2022-02-15 05:36:29.637482',8,46,19);
INSERT INTO "moyenne_matiere" VALUES (487,6.25,9.0,12.0,8.0,10.0,20.0,'2022-02-15 05:37:14.779166',8,47,8);
INSERT INTO "moyenne_matiere" VALUES (488,9.25,10.0,15.0,10.0,12.5,25.0,'2022-02-15 05:38:05.041959',8,48,3);
INSERT INTO "moyenne_matiere" VALUES (489,4.0,9.25,10.0,7.0,8.5,17.0,'2022-02-15 05:38:59.019659',8,49,17);
INSERT INTO "moyenne_matiere" VALUES (490,10.5,11.0,14.0,11.0,12.5,25.0,'2022-02-15 05:39:46.371597',8,50,4);
INSERT INTO "moyenne_matiere" VALUES (491,7.0,8.25,11.0,8.0,9.5,19.0,'2022-02-15 05:40:59.251258',8,51,12);
INSERT INTO "moyenne_matiere" VALUES (492,11.5,16.0,12.0,14.0,13.0,26.0,'2022-02-15 05:41:49.640198',8,52,2);
INSERT INTO "moyenne_matiere" VALUES (493,6.75,9.5,12.0,8.0,10.0,20.0,'2022-02-15 05:42:43.600148',8,53,9);
INSERT INTO "moyenne_matiere" VALUES (494,7.0,6.5,11.0,7.0,9.0,18.0,'2022-02-15 05:43:24.537114',8,54,15);
INSERT INTO "moyenne_matiere" VALUES (495,4.5,5.5,8.0,5.0,6.5,13.0,'2022-02-15 05:44:02.748042',8,55,20);
INSERT INTO "moyenne_matiere" VALUES (496,9.25,14.0,13.0,12.0,12.5,25.0,'2022-02-15 05:44:43.427797',8,56,5);
INSERT INTO "moyenne_matiere" VALUES (497,10.0,11.5,11.0,11.0,11.0,22.0,'2022-02-15 05:45:12.831259',8,57,7);
INSERT INTO "moyenne_matiere" VALUES (498,9.75,6.5,11.0,8.0,9.5,19.0,'2022-02-15 05:46:18.235388',8,58,13);
INSERT INTO "moyenne_matiere" VALUES (499,10.0,11.5,16.0,11.0,13.5,27.0,'2022-02-15 05:47:01.925529',8,59,1);
INSERT INTO "moyenne_matiere" VALUES (500,3.25,8.0,12.0,6.0,9.0,18.0,'2022-02-15 05:47:25.979836',8,60,16);
INSERT INTO "moyenne_matiere" VALUES (501,9.25,12.0,12.0,11.0,11.5,23.0,'2022-02-15 05:47:50.645679',8,61,6);
INSERT INTO "moyenne_matiere" VALUES (502,2.0,2.0,2.0,2.0,2.0,2.0,'2022-02-15 05:48:44.276115',32,41,19);
INSERT INTO "moyenne_matiere" VALUES (503,5.0,5.0,5.0,5.0,5.0,5.0,'2022-02-15 05:49:13.965519',32,42,18);
INSERT INTO "moyenne_matiere" VALUES (504,2.0,2.0,2.0,2.0,2.0,2.0,'2022-02-15 05:49:38.413934',32,43,20);
INSERT INTO "moyenne_matiere" VALUES (505,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:15:07.193816',32,44,11);
INSERT INTO "moyenne_matiere" VALUES (506,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:15:44.184622',32,45,12);
INSERT INTO "moyenne_matiere" VALUES (507,14.0,14.0,14.0,14.0,14.0,14.0,'2022-02-15 06:16:17.224933',32,46,1);
INSERT INTO "moyenne_matiere" VALUES (508,12.0,14.0,13.0,13.0,13.0,13.0,'2022-02-15 06:16:49.811071',32,47,2);
INSERT INTO "moyenne_matiere" VALUES (509,14.0,12.0,13.0,13.0,13.0,13.0,'2022-02-15 06:17:22.961595',32,48,3);
INSERT INTO "moyenne_matiere" VALUES (510,11.0,13.0,12.0,12.0,12.0,12.0,'2022-02-15 06:17:46.492535',32,49,4);
INSERT INTO "moyenne_matiere" VALUES (511,12.0,12.0,12.0,12.0,12.0,12.0,'2022-02-15 06:20:11.476951',32,50,5);
INSERT INTO "moyenne_matiere" VALUES (512,12.0,12.0,12.0,12.0,12.0,12.0,'2022-02-15 06:20:33.360982',32,51,6);
INSERT INTO "moyenne_matiere" VALUES (513,11.0,11.0,11.0,11.0,11.0,11.0,'2022-02-15 06:20:55.886599',32,52,10);
INSERT INTO "moyenne_matiere" VALUES (514,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:21:17.395201',32,53,13);
INSERT INTO "moyenne_matiere" VALUES (515,12.0,12.0,12.0,12.0,12.0,12.0,'2022-02-15 06:21:38.766564',32,54,7);
INSERT INTO "moyenne_matiere" VALUES (516,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:22:01.548275',32,55,14);
INSERT INTO "moyenne_matiere" VALUES (517,13.0,11.0,12.0,12.0,12.0,12.0,'2022-02-15 06:22:51.311677',32,56,8);
INSERT INTO "moyenne_matiere" VALUES (518,2.0,2.0,2.0,2.0,2.0,2.0,'2022-02-15 06:23:12.377262',32,57,21);
INSERT INTO "moyenne_matiere" VALUES (519,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:23:42.801893',32,58,15);
INSERT INTO "moyenne_matiere" VALUES (520,10.0,10.0,10.0,10.0,10.0,10.0,'2022-02-15 06:24:04.993549',32,59,16);
INSERT INTO "moyenne_matiere" VALUES (521,13.0,11.0,12.0,12.0,12.0,12.0,'2022-02-15 06:24:34.081754',32,60,9);
INSERT INTO "moyenne_matiere" VALUES (522,10.0,8.0,9.0,9.0,9.0,9.0,'2022-02-15 06:25:06.689077',32,61,17);
INSERT INTO "classe" VALUES (1,'6ème','Col','2022-02-03 22:56:04.441025',1,6,15,NULL,10.17,NULL,NULL,NULL,10.17,NULL,NULL,NULL,10.17,NULL,NULL);
INSERT INTO "classe" VALUES (2,'5ème','Col','2022-02-03 22:56:47.089939',1,1,10,NULL,10.06,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "classe" VALUES (3,'4ème','Col','2022-02-03 22:57:19.158557',1,3,14,NULL,8.72,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "classe" VALUES (4,'3ème','Col','2022-02-03 22:57:51.417396',1,11,21,NULL,8.81,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "eleve" VALUES (1,'ADZI','Abra Eyram','Féminin','Nouvelle','2022-02-08 05:17:43.328588',1,10.17,NULL,NULL,10,NULL,NULL,91.5,9,NULL);
INSERT INTO "eleve" VALUES (2,'AGBOH','Mawouko Fiacre','Masculin','Nouveau','2022-02-08 05:19:26.600152',1,8.61,NULL,NULL,12,NULL,NULL,77.5,9,NULL);
INSERT INTO "eleve" VALUES (3,'AMEY','Kokou Timothée','Masculin','Nouveau','2022-02-08 05:27:19.027854',1,10.47,NULL,NULL,9,NULL,NULL,94.25,9,'');
INSERT INTO "eleve" VALUES (4,'AMOUZOU-LANTTAH','K. Prosper','Masculin','Nouveau','2022-02-08 05:28:45.222540',1,10.94,NULL,NULL,6,NULL,NULL,98.5,9,NULL);
INSERT INTO "eleve" VALUES (5,'ASSIGNON','Komi Florent','Masculin','Nouveau','2022-02-08 05:31:16.818584',1,5.08,NULL,NULL,15,NULL,NULL,45.75,9,NULL);
INSERT INTO "eleve" VALUES (6,'ATOPANI','Koami Alfred','Masculin','Nouveau','2022-02-08 05:34:49.740702',1,10.67,NULL,NULL,7,NULL,NULL,96.0,9,NULL);
INSERT INTO "eleve" VALUES (7,'CODJOVI','Prince Renaldo','Masculin','Nouveau','2022-02-08 05:35:40.121096',1,10.14,NULL,NULL,11,NULL,NULL,91.25,9,NULL);
INSERT INTO "eleve" VALUES (8,'DEMAGNA','Afiwa Estelle','Féminin','Nouvelle','2022-02-08 05:36:42.882454',1,14.56,NULL,NULL,1,NULL,NULL,131.0,9,'');
INSERT INTO "eleve" VALUES (9,'DJIBOM','Somahé Ariel','Masculin','Nouveau','2022-02-08 05:37:34.165940',1,10.64,NULL,NULL,8,NULL,NULL,95.75,9,NULL);
INSERT INTO "eleve" VALUES (10,'FAGBEGNON','Akouvi Elisabeth','Féminin','Nouvelle','2022-02-08 05:38:23.555682',1,10.61,NULL,NULL,9,NULL,NULL,95.5,9,NULL);
INSERT INTO "eleve" VALUES (11,'KANGNI','Folli Samson','Masculin','Nouveau','2022-02-08 05:38:23.651680',1,7.14,NULL,NULL,14,NULL,NULL,64.25,9,NULL);
INSERT INTO "eleve" VALUES (12,'KOFFI','Kouamé Elisée','Masculin','Nouveau','2022-02-08 05:40:46.469910',1,12.28,NULL,NULL,3,NULL,NULL,110.5,9,NULL);
INSERT INTO "eleve" VALUES (13,'KOUMAKOU','Kokouvi Samson','Masculin','Nouveau','2022-02-08 05:41:41.133063',1,8.39,NULL,NULL,13,NULL,NULL,75.5,9,NULL);
INSERT INTO "eleve" VALUES (14,'NOUTOHOU','Kossi Elom','Masculin','Nouveau','2022-02-08 05:42:29.446390',1,11.58,NULL,NULL,4,NULL,NULL,104.25,9,'');
INSERT INTO "eleve" VALUES (16,'SODOGADJI','Adjo Eugénie','Féminin','Nouvelle','2022-02-08 05:43:18.760481',1,12.64,NULL,NULL,2,NULL,NULL,113.75,9,'');
INSERT INTO "eleve" VALUES (17,'ADZI','Kossi','Masculin','Redoublant','2022-02-08 15:29:16.019661',2,10.06,NULL,NULL,9,NULL,NULL,90.5,9,NULL);
INSERT INTO "eleve" VALUES (18,'AGNAMAH','Koami  Francis','Masculin','Nouveau','2022-02-08 15:32:15.426106',2,13.33,NULL,NULL,4,NULL,NULL,120.0,9,NULL);
INSERT INTO "eleve" VALUES (19,'ALATE','Roméo','Masculin','Nouveau','2022-02-08 15:32:41.289507',2,14.69,NULL,NULL,2,NULL,NULL,132.25,9,NULL);
INSERT INTO "eleve" VALUES (20,'ANANI','Afiwa  Djigbodi B.','Féminin','Nouvelle','2022-02-08 15:34:04.541950',2,13.92,NULL,NULL,3,NULL,NULL,125.25,9,NULL);
INSERT INTO "eleve" VALUES (21,'DJIBOM','Kinmidé Eléonore','Féminin','Nouvelle','2022-02-08 15:36:05.398291',2,9.67,NULL,NULL,10,NULL,NULL,87.0,9,NULL);
INSERT INTO "eleve" VALUES (22,'EKOUE-BLA','Ayoko  Lynne','Féminin','Nouvelle','2022-02-08 15:37:49.284927',2,15.17,NULL,NULL,1,NULL,NULL,136.5,9,NULL);
INSERT INTO "eleve" VALUES (23,'GBEKOU','Adjo Pauline Eyram','Féminin','Nouvelle','2022-02-08 15:38:33.636236',2,11.36,NULL,NULL,8,NULL,NULL,102.25,9,NULL);
INSERT INTO "eleve" VALUES (24,'GOUDEAGBE','Emmanuel','Masculin','Nouveau','2022-02-08 15:39:16.532982',2,11.53,NULL,NULL,6,NULL,NULL,103.75,9,NULL);
INSERT INTO "eleve" VALUES (25,'KPOGNO','Romaric','Masculin','Nouveau','2022-02-08 15:39:53.838485',2,13.22,NULL,NULL,5,NULL,NULL,119.0,9,NULL);
INSERT INTO "eleve" VALUES (26,'KPOGNON','Yaovi Bernard','Masculin','Nouveau','2022-02-08 15:40:35.836619',2,11.39,NULL,NULL,7,NULL,NULL,102.5,9,NULL);
INSERT INTO "eleve" VALUES (27,'AGBELESSESSY','K. E. Stanley','Masculin','Nouveau','2022-02-08 15:41:47.548156',3,8.72,NULL,NULL,10,NULL,NULL,139.5,16,NULL);
INSERT INTO "eleve" VALUES (28,'AGBOOLA','Precious','Masculin','Nouveau','2022-02-08 15:42:25.236733',3,11.34,NULL,NULL,2,NULL,NULL,181.5,16,NULL);
INSERT INTO "eleve" VALUES (29,'BAKARI','Rockyb','Masculin','Nouveau','2022-02-08 15:42:55.655932',3,11.81,NULL,NULL,1,NULL,NULL,189.0,16,NULL);
INSERT INTO "eleve" VALUES (30,'GAGLO','Amah  Dopé','Féminin','Nouvelle','2022-02-08 15:43:20.488376',3,8.81,NULL,NULL,8,NULL,NULL,141.0,16,NULL);
INSERT INTO "eleve" VALUES (31,'GNANLANDJO','Marcelline','Féminin','Nouvelle','2022-02-08 15:43:57.196913',3,10.53,NULL,NULL,6,NULL,NULL,168.5,16,NULL);
INSERT INTO "eleve" VALUES (32,'KANGNI','Folli','Masculin','Nouveau','2022-02-08 15:44:30.019981',3,8.28,NULL,NULL,11,NULL,NULL,132.5,16,NULL);
INSERT INTO "eleve" VALUES (33,'KOUDOLY','Morino','Masculin','Nouveau','2022-02-08 15:45:36.570318',3,7.97,NULL,NULL,12,NULL,NULL,127.5,16,NULL);
INSERT INTO "eleve" VALUES (34,'KOUSSOUGBO','Kossi Daniel','Masculin','Nouveau','2022-02-08 15:46:31.067023',3,6.97,NULL,NULL,14,NULL,NULL,111.5,16,NULL);
INSERT INTO "eleve" VALUES (35,'KPOGNON','Kossi  D’Aquin','Masculin','Nouveau','2022-02-08 15:50:16.718269',3,9.34,NULL,NULL,7,NULL,NULL,149.5,16,NULL);
INSERT INTO "eleve" VALUES (36,'KUDJRAKO','Yawo  Germain','Masculin','Nouveau','2022-02-08 15:51:06.382610',3,8.81,NULL,NULL,9,NULL,NULL,141.0,16,NULL);
INSERT INTO "eleve" VALUES (37,'LADZRO','Akouvi  Aimée','Féminin','Nouvelle','2022-02-08 15:52:11.916684',3,10.91,NULL,NULL,4,NULL,NULL,174.5,16,NULL);
INSERT INTO "eleve" VALUES (38,'SENA','Foli Yves','Masculin','Nouveau','2022-02-08 15:52:48.794265',3,7.84,NULL,NULL,13,NULL,NULL,125.5,16,NULL);
INSERT INTO "eleve" VALUES (39,'SOSSOU','Yawa Glwadys','Féminin','Nouvelle','2022-02-08 15:53:25.294130',3,10.66,NULL,NULL,5,NULL,NULL,170.5,16,NULL);
INSERT INTO "eleve" VALUES (40,'YEME','Norbert','Masculin','Nouveau','2022-02-08 15:53:57.452887',3,10.94,NULL,NULL,3,NULL,NULL,175.0,16,NULL);
INSERT INTO "eleve" VALUES (41,'AGBETO','Kokou Bernard','Masculin','Nouveau','2022-02-08 15:54:52.552882',4,8.81,NULL,NULL,9,NULL,NULL,141.0,16,NULL);
INSERT INTO "eleve" VALUES (42,'AGNAMAH','Komi Sylvain','Masculin','Nouveau','2022-02-08 15:55:32.914160',4,7.34,NULL,NULL,17,NULL,NULL,117.5,16,NULL);
INSERT INTO "eleve" VALUES (43,'AGNIGBADEDJI','Kodjo Guy','Masculin','Redoublant','2022-02-08 15:56:48.712094',4,7.28,NULL,NULL,19,NULL,NULL,116.5,16,NULL);
INSERT INTO "eleve" VALUES (44,'AHOSSOUDE','Yawa','Féminin','Nouvelle','2022-02-08 15:57:53.807302',4,8.16,NULL,NULL,11,NULL,NULL,130.5,16,NULL);
INSERT INTO "eleve" VALUES (45,'AKAKPO','Luc Moise','Masculin','Redoublant','2022-02-08 15:58:30.949043',4,6.44,NULL,NULL,21,NULL,NULL,103.0,16,NULL);
INSERT INTO "eleve" VALUES (46,'AKAKPOSSA','Koffi Thomas','Masculin','Redoublant','2022-02-08 15:59:11.931503',4,7.34,NULL,NULL,18,NULL,NULL,117.5,16,'');
INSERT INTO "eleve" VALUES (47,'AMELESSODJI','Kodjo Manasse','Masculin','Redoublant','2022-02-08 15:59:55.352512',4,10.22,NULL,NULL,4,NULL,NULL,163.5,16,NULL);
INSERT INTO "eleve" VALUES (48,'AMOUSSOU','André Franck  Gadoufio','Masculin','Redoublant','2022-02-08 16:00:25.404948',4,9.56,NULL,NULL,7,NULL,NULL,153.0,16,NULL);
INSERT INTO "eleve" VALUES (49,'AVEGAN','Adjo Mélanie','Féminin','Redoublante','2022-02-08 16:00:54.325570',4,7.75,NULL,NULL,14,NULL,NULL,124.0,16,NULL);
INSERT INTO "eleve" VALUES (50,'BOGLA','Ayélé Comfort','Féminin','Nouvelle','2022-02-08 16:01:49.215524',4,7.94,NULL,NULL,13,NULL,NULL,127.0,16,NULL);
INSERT INTO "eleve" VALUES (51,'CODJOVI','Dora','Féminin','Nouvelle','2022-02-08 16:03:04.459752',4,7.5,NULL,NULL,16,NULL,NULL,120.0,16,NULL);
INSERT INTO "eleve" VALUES (52,'De SOUZA','Emmanuella','Féminin','Nouvelle','2022-02-08 16:03:43.794574',4,10.53,NULL,NULL,3,NULL,NULL,168.5,16,NULL);
INSERT INTO "eleve" VALUES (53,'DOUHADJI','Akouvi Reine','Féminin','Redoublante','2022-02-08 16:04:18.767079',4,8.97,NULL,NULL,8,NULL,NULL,143.5,16,NULL);
INSERT INTO "eleve" VALUES (54,'HODZI','Amah  Gisèle','Féminin','Nouvelle','2022-02-08 16:07:06.144029',4,7.69,NULL,NULL,15,NULL,NULL,123.0,16,NULL);
INSERT INTO "eleve" VALUES (55,'KAMASSAH','Kossivi  Boris','Masculin','Nouveau','2022-02-08 16:07:41.880313',4,7.03,NULL,NULL,20,NULL,NULL,112.5,16,NULL);
INSERT INTO "eleve" VALUES (56,'KEGLO','Akakpovi','Masculin','Nouveau','2022-02-08 16:08:47.826512',4,10.0,NULL,NULL,5,NULL,NULL,160.0,16,NULL);
INSERT INTO "eleve" VALUES (57,'KOKOU','Koffi Josué','Masculin','Redoublant','2022-02-08 16:09:18.915160',4,9.88,NULL,NULL,6,NULL,NULL,158.0,16,NULL);
INSERT INTO "eleve" VALUES (58,'KOUGBLENOU','Amélé','Féminin','Nouvelle','2022-02-08 16:09:50.662258',4,8.0,NULL,NULL,12,NULL,NULL,128.0,16,NULL);
INSERT INTO "eleve" VALUES (59,'LADZRO','Dopé Fortunée','Féminin','Redoublante','2022-02-08 16:10:29.934596',4,12.5,NULL,NULL,1,NULL,NULL,200.0,16,NULL);
INSERT INTO "eleve" VALUES (60,'N’KPEAVO','Ayélé  Charlotte','Féminin','Nouvelle','2022-02-08 16:11:04.120077',4,8.22,NULL,NULL,10,NULL,NULL,131.5,16,NULL);
INSERT INTO "eleve" VALUES (61,'SOSSOU','Akossiwa Routh','Féminin','Redoublante','2022-02-08 16:11:59.943902',4,11.66,NULL,NULL,2,NULL,NULL,186.5,16,NULL);
INSERT INTO "examen" VALUES (1,'2022-03-04 17:26:27.235128',1);
INSERT INTO "examen_classe" VALUES (1,1,1);
INSERT INTO "examen_classe" VALUES (2,1,2);
INSERT INTO "examen_classe" VALUES (3,1,3);
INSERT INTO "examen_classe" VALUES (4,1,4);
INSERT INTO "facultative" VALUES (1,0,1,'2022-03-07 04:41:58.615317',13);
INSERT INTO "facultative" VALUES (2,0,1,'2022-03-07 04:42:20.505148',14);
INSERT INTO "facultative" VALUES (3,0,1,'2022-03-07 04:42:46.434492',16);
INSERT INTO "facultative_classe" VALUES (1,1,1);
INSERT INTO "facultative_classe" VALUES (2,1,2);
INSERT INTO "facultative_classe" VALUES (3,1,3);
INSERT INTO "facultative_classe" VALUES (4,1,4);
INSERT INTO "facultative_classe" VALUES (5,2,1);
INSERT INTO "facultative_classe" VALUES (6,2,2);
INSERT INTO "facultative_classe" VALUES (7,2,3);
INSERT INTO "facultative_classe" VALUES (8,2,4);
INSERT INTO "facultative_classe" VALUES (9,3,1);
INSERT INTO "facultative_classe" VALUES (10,3,2);
INSERT INTO "facultative_classe" VALUES (11,3,3);
INSERT INTO "facultative_classe" VALUES (12,3,4);
INSERT INTO "enseignant" VALUES (1,'LAWSON KPAVUVU','Fessu','','',NULL,NULL,NULL,'2022-02-07 13:32:57.898088',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (2,'LAWSON KPAVUVU','Fessu','','',NULL,NULL,NULL,'2022-02-07 13:38:53.413008',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (3,'SESSI','Koudjo','','',NULL,NULL,NULL,'2022-02-07 14:38:04.768191',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (4,'SESSI','Koudjo','','',NULL,NULL,NULL,'2022-02-07 16:59:23.775436',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (5,'GAGLO','Ayao Apélété','','',NULL,NULL,NULL,'2022-02-07 18:27:09.862584',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (6,'GATO','Yao Jeannot','','',NULL,NULL,NULL,'2022-02-07 18:28:04.755424',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (7,'ELAVAGNON','Djifa','','',NULL,NULL,NULL,'2022-02-07 18:29:13.218639',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (8,'JOHNSON','A. Basilia','','',NULL,NULL,NULL,'2022-02-07 18:30:47.340152',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (9,'GERALDO','Al-Kabirou','','',NULL,NULL,NULL,'2022-02-07 18:34:26.739359',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (10,'AGBEKPONOU','Komi Apélété','','',NULL,NULL,NULL,'2022-02-07 18:35:13.173494',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (11,'APETSI','Kodjovi','','',NULL,NULL,NULL,'2022-02-07 18:35:45.163074',NULL,1,0,NULL);
INSERT INTO "enseignant" VALUES (12,'AWOTO','A. Toundé','','',NULL,NULL,NULL,'2022-02-07 18:36:23.617988',NULL,1,0,NULL);
INSERT INTO "etablissement" VALUES (1,'COMPLEXE SCOLAIRE IVOIRE','Adakpamé, Lomé-Togo',92595152,'csivoire@gmail.com','2022-02-03 16:43:49.649022',5,1,'ets/lplivoire.PNG','ets/plan/fond.png','8266',0);
INSERT INTO "dre" VALUES (2,'Grand Lomé','Ministère des Enseignements Primaire, Secondaire, Technique et de l''Artisanat','Direction de l''Enseignement du Grand Lomé','TG',NULL,NULL,'2022-02-03 11:00:48.068821','pays/drapeau.png','');
INSERT INTO "inspection" VALUES (1,'Grand Lomé Est',NULL,NULL,'2022-02-03 13:13:58.217969',2,'Lomé','Inspection de l''Enseignement Secondaire Général Grang Lomé Est');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "matiere_classe_classe_id_e88f742e" ON "matiere_classe" (
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "matiere_classe_matiere_id_c331fe14" ON "matiere_classe" (
	"matiere_id"
);
CREATE INDEX IF NOT EXISTS "matiere_classe_enseignant_id_25a1fa34" ON "matiere_classe" (
	"enseignant_id"
);
CREATE INDEX IF NOT EXISTS "decoupage_anneescolaire_id_cd40441d" ON "decoupage" (
	"anneescolaire_id"
);
CREATE INDEX IF NOT EXISTS "moyenne_periode_id_e0002f36" ON "moyenne" (
	"periode_id"
);
CREATE INDEX IF NOT EXISTS "moyenne_matiere_matiere_id_f27fffce" ON "moyenne_matiere" (
	"matiere_id"
);
CREATE INDEX IF NOT EXISTS "moyenne_matiere_eleve_id_7f15f988" ON "moyenne_matiere" (
	"eleve_id"
);
CREATE INDEX IF NOT EXISTS "classe_etbs_id_25e339b6" ON "classe" (
	"etbs_id"
);
CREATE INDEX IF NOT EXISTS "eleve_classe_id_0717a3b4" ON "eleve" (
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "examen_periode_id_10b1d726" ON "examen" (
	"periode_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "examen_classe_examen_id_classe_id_320ae4fa_uniq" ON "examen_classe" (
	"examen_id",
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "examen_classe_examen_id_d077c855" ON "examen_classe" (
	"examen_id"
);
CREATE INDEX IF NOT EXISTS "examen_classe_classe_id_07a378fb" ON "examen_classe" (
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "facultative_matiere_id_349175b8" ON "facultative" (
	"matiere_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "facultative_classe_facultative_id_classe_id_6fa283b2_uniq" ON "facultative_classe" (
	"facultative_id",
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "facultative_classe_facultative_id_667d95eb" ON "facultative_classe" (
	"facultative_id"
);
CREATE INDEX IF NOT EXISTS "facultative_classe_classe_id_eca238c4" ON "facultative_classe" (
	"classe_id"
);
CREATE INDEX IF NOT EXISTS "enseignant_etbs_id_daa7d966" ON "enseignant" (
	"etbs_id"
);
CREATE INDEX IF NOT EXISTS "etablissement_inspection_id_11970eb6" ON "etablissement" (
	"inspection_id"
);
CREATE INDEX IF NOT EXISTS "inspection_dre_id_6652d48f" ON "inspection" (
	"dre_id"
);
COMMIT;
