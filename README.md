# KërDoctor
> **"Kër" signifie *maison* en Wolof. KërDoctor, c'est la santé à domicile.**

**Télémédecine intelligente par la voix pour les travailleurs du secteur informel au Sénégal**

En moins de **2 minutes**, n'importe quel utilisateur peut :
1. Décrire ses symptômes **en Wolof, Français ou Pulaar** — par la voix
2. Recevoir une **analyse IA immédiate** avec niveau d'urgence
3. Être mis en contact avec un **médecin qualifié**
4. Payer via **Wave ou Orange Money** — seulement **2 500 FCFA**

[![FastAPI](https://img.shields.io/badge/FastAPI-0.111.0-009688?style=flat&logo=fastapi)](https://fastapi.tiangolo.com)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=flat&logo=postgresql)](https://postgresql.org)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=flat&logo=python)](https://python.org)
[![Railway](https://img.shields.io/badge/Deploy-Railway-0B0D0E?style=flat&logo=railway)](https://railway.app)

---

## Le problème que nous résolvons

Au Sénégal, **96% de la population active** travaille dans le secteur informel — soit plus de **5,7 millions de personnes** sans couverture maladie, sans assurance, sans congé maladie.

Quand ils tombent malades, ils font face à 4 obstacles majeurs :

- **Perte de temps** — une consultation à l'hôpital prend 3 à 8 heures. Une journée entière de revenu perdue.
- **Perte de revenu** — entre 5 000 et 15 000 FCFA de revenu journalier sacrifié, plus les frais de transport.
- **Barrière linguistique** — les médecins consultent en français. La majorité de nos utilisateurs parle Wolof ou Pulaar.
- **Automédication dangereuse** — incapables d'accéder aux soins, ils achètent des médicaments sans ordonnance, aggravant leur état.

**Résultat** : un cercle vicieux — la maladie mène à la pauvreté, la pauvreté empêche les soins.

---

## Notre solution

KërDoctor est une plateforme mobile de santé vocale et intelligente, conçue spécifiquement pour les travailleurs informels d'Afrique.

### Comment ça marche — 4 étapes

```
1. L'utilisateur parle       →  Décrit ses symptômes en Wolof, Pulaar ou Français
2. L'IA analyse              →  Triage automatique en moins de 2 minutes
3. Connexion au médecin      →  Consultation voix ou vidéo avec un médecin certifié
4. Paiement & Ordonnance     →  2 500 FCFA via Wave ou Orange Money + prescription numérique
```

### Avantages clés

- Interface **100% vocale** — aucune lecture ni écriture requise
- **Zéro déplacement** — consultation depuis le lieu de travail
- **Dossier médical numérique** — historique accessible à chaque consultation
- **Rappels médicaments automatiques** — notifications push post-consultation
- **Mode hors ligne** — via Vosk pour les zones à faible connectivité

---

## Modèle économique

### Tarification — Pay-per-use + Abonnement

| Offre | Prix | Cible |
|-------|------|-------|
| Consultation à l'acte | **2 500 FCFA** | Travailleur informel individuel |
| Abonnement mensuel | **8 000 FCFA / mois** | Travailleurs réguliers (illimité) |
| Pack famille | **15 000 FCFA / mois** | Foyer — jusqu'à 5 membres |
| Partenariat association | **Sur devis** | Associations de commerçants, coopératives |

### Sources de revenus

1. **Commission par consultation** — KërDoctor prélève 30% sur chaque consultation (le médecin reçoit 70%)
2. **Abonnements utilisateurs** — revenus récurrents mensuels prévisibles
3. **Partenariats cliniques** — cliniques partenaires paient pour apparaître en première position
4. **Partenariats pharmaceutiques** — commissions sur les pharmacies partenaires référencées dans l'app
5. **Données agrégées anonymisées** — rapports de santé publique pour ONG et institutions (données non personnelles, conformes CDP)

### Projection de revenus

| Scénario | Utilisateurs actifs | Revenus mensuels |
|----------|-------------------|-----------------|
| MVP (6 mois) | 500 | ~1,25M FCFA |
| Phase 1 (12 mois) | 5 000 | ~12,5M FCFA |
| Phase 2 (18 mois) | 50 000 | ~125M FCFA |
| Phase 3 (24 mois) | 100 000+ | **250M+ FCFA** |

---

## Stade de développement

### Statut actuel — Avril 2026

| Composant | Statut | Détail |
|-----------|--------|--------|
| Frontend Flutter | ✅ Fonctionnel | 8 écrans complets, déployé |
| Backend FastAPI | 🟡 En cours | Auth + Triage vocal opérationnels |
| Base de données PostgreSQL | ✅ Opérationnelle | Schéma complet, Railway |
| Triage IA (Groq + Whisper) | 🟡 En cours | Intégration en cours de tests |
| Paiement Wave | 📅 Planifié | V1 — fin avril 2026 |
| Matching médecin | 📅 Planifié | V1 — fin avril 2026 |
| Mode Wolof / Pulaar | 🟡 En cours | Fine-tuning Whisper sur données locales |

### Ce que nous avons livré

- Application Flutter avec 8 écrans fonctionnels (Welcome, Home, Symptom Check, Triage, Checkout, Find Doctor, Video Call, Rappels)
- Backend API REST avec authentification JWT complète
- Architecture PostgreSQL avec schéma médical structuré
- Repository GitHub structuré avec documentation
- **Sélection comme unique équipe représentant l'UASZ au niveau national — Hult Prize 2026**

---

## Next Steps — Roadmap

| Phase | Période | Objectif | Statut |
|-------|---------|----------|--------|
| MVP | Jusqu'au 30 avril 2026 | Auth + Triage vocal + Paiement Wave | 🟡 En cours |
| V1 | Mai 2026 | Matching médecin + Consultation vidéo + Orange Money | 📅 Planifié |
| Beta | Juin 2026 | WhatsApp IVR + Ordonnances numériques + Pulaar | 📅 Planifié |
| Pilote terrain | Juillet 2026 | 500 premiers utilisateurs — marchés de Ziguinchor | 📅 Planifié |
| Expansion | Septembre 2026 | Dakar — 5 000 utilisateurs | 📅 Planifié |

---

## Challenges actuels & Besoins

### Challenges techniques

- **Reconnaissance vocale Wolof/Pulaar** — les modèles Whisper et Vosk manquent de données d'entraînement en langues locales. Nous collectons activement des datasets vocaux.
- **Connectivité** — certaines zones ont une connexion 2G instable. Solution en cours : mode USSD pour les utilisateurs sans smartphone.
- **Conformité médicale** — obtenir les accréditations nécessaires auprès de l'Ordre des Médecins du Sénégal pour la télémédecine.

### Challenges business

- **Confiance utilisateur** — éduquer les travailleurs informels à adopter la consultation digitale.
- **Recrutement médecins** — constituer un réseau de médecins partenaires motivés et disponibles.
- **Conformité CDP** — déclaration en cours auprès de la Commission de Protection des Données pour les données de santé vocales (Loi 2008-12).

### Ce dont nous avons besoin

| Besoin | Pourquoi | Impact |
|--------|----------|--------|
| **Financement technique** | Serveurs, APIs Groq/Whisper à l'échelle, développement | Accélérer le MVP complet |
| **Financement terrain** | Agents communautaires, démo marchés, formation | Acquérir les 500 premiers utilisateurs |
| **Mentorat médical** | Partenariat Ordre des Médecins, protocoles télémédecine | Légitimité et conformité |
| **Réseau partenaires** | Cliniques, associations informelles, ONG santé | Distribution et crédibilité |

### Comment le financement contribue

Un financement de démarrage nous permettrait de :

1. **Finaliser le MVP complet** (backend + IA + paiement) en 30 jours
2. **Lancer le pilote terrain** à Ziguinchor avec 500 utilisateurs réels
3. **Fine-tuner les modèles vocaux** sur le Wolof et le Pulaar
4. **Recruter 20 médecins partenaires** et formaliser les accords
5. **Obtenir les certifications** médicales et de protection des données

---

## Architecture

```
KërDoctor/
├── backend/                    ← API FastAPI (Saïd Deme)
│   ├── app/
│   │   ├── core/               ← Config, sécurité, dépendances
│   │   ├── db/                 ← Connexion PostgreSQL
│   │   ├── models/             ← Tables de la base de données
│   │   ├── schemas/            ← Validation Pydantic
│   │   ├── services/           ← Auth, Triage IA, Paiement
│   │   └── routers/            ← Endpoints API REST
│   └── migrations/             ← Migrations Alembic
└── frontend/                   ← App Flutter (Ndeye Maty Ba)
    └── lib/
        ├── screens/            ← 8 écrans de l'application
        ├── services/           ← Appels API
        ├── models/             ← Modèles de données
        └── config/
            └── api_config.dart ← URL API centralisée (variable d'env)
```

---

## Stack technologique

| Couche | Technologie | Pourquoi ce choix |
|--------|-------------|-------------------|
| Backend API | Python + FastAPI | Async natif, validation auto, docs Swagger |
| Base de données | PostgreSQL 15 | ACID, JSON natif, données médicales structurées |
| Cache | Redis | Sessions, rate limiting |
| Speech-to-Text | Faster-Whisper + Vosk | Multilingue FR/Wolof, open-source, mode offline |
| Triage IA | Groq API (Llama 3) | Inférence rapide, coût maîtrisé à l'échelle |
| Frontend | Flutter (Dart) | iOS + Android — un seul codebase |
| Paiement | Wave API + Orange Money | Leaders Mobile Money Sénégal |
| Téléphonie | Africa's Talking | IVR + SMS + WhatsApp |
| Déploiement | Railway | Auto-scaling, CI/CD GitHub natif |

---

## Installation — Backend

### Prérequis
- Python 3.12+
- PostgreSQL 15+
- Redis
- Docker (optionnel)

```bash
# 1. Clone le repo
git clone https://github.com/maty382/KerDoctor.git
cd KerDoctor/backend

# 2. Environnement virtuel
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# 3. Variables d'environnement
cp .env.example .env
# Remplis le .env avec tes valeurs

# 4. PostgreSQL avec Docker
docker run -d \
  --name kerdoctor-db \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=kerdoctor \
  -p 5432:5432 \
  postgres:15

# 5. Migrations
alembic upgrade head

# 6. Lancer le serveur
uvicorn app.main:app --reload --port 8000
```

Documentation Swagger disponible sur : `http://localhost:8000/docs`

### Variables d'environnement (.env)

```env
DATABASE_URL=postgresql+asyncpg://postgres:secret@localhost:5432/kerdoctor
REDIS_URL=redis://localhost:6379/0
JWT_SECRET_KEY=change-this-to-a-random-secret
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=60
REFRESH_TOKEN_EXPIRE_DAYS=7
GROQ_API_KEY=your-groq-api-key
APP_ENV=development
API_BASE_URL=http://localhost:8000
```

---

## Installation — Frontend Flutter

```bash
cd KerDoctor/frontend
flutter pub get
flutter run
```

L'URL de l'API est centralisée dans `lib/config/api_config.dart` :

```dart
// Modifier uniquement cette constante pour changer d'environnement
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8000/api/v1',
);
```

---

## API — Endpoints principaux

### Authentification

| Méthode | Endpoint | Description | Auth |
|---------|----------|-------------|------|
| POST | `/api/v1/auth/register` | Inscription patient ou médecin | ❌ |
| POST | `/api/v1/auth/login` | Connexion → JWT tokens | ❌ |
| POST | `/api/v1/auth/refresh` | Renouvelle les tokens | ❌ |
| POST | `/api/v1/auth/logout` | Déconnexion | ✅ |
| GET | `/api/v1/auth/me` | Profil utilisateur connecté | ✅ |

### Triage Vocal IA

| Méthode | Endpoint | Description | Auth |
|---------|----------|-------------|------|
| POST | `/api/v1/triage/voice` | Upload audio → analyse IA | ✅ Patient |
| GET | `/api/v1/triage/history` | Historique des triages | ✅ |

### Exemple — Triage vocal

```bash
curl -X POST "${API_BASE_URL}/api/v1/triage/voice" \
  -H "Authorization: Bearer <access_token>" \
  -F "audio_file=@symptomes.wav" \
  -F "language=fr"
```

Réponse :
```json
{
  "id": "uuid",
  "urgency_level": 2,
  "summary": "Le patient décrit des maux de tête et de la fièvre.",
  "advice": "Prenez du paracétamol. Consultez un médecin si la fièvre dépasse 39°C.",
  "transcript": "J'ai mal à la tête depuis ce matin et j'ai de la fièvre",
  "language": "fr",
  "created_at": "2026-04-25T10:00:00"
}
```

---

## Niveaux d'urgence

> ⚠️ **Disclaimer médical important** : KërDoctor est un outil d'orientation et de triage. Il ne pose pas de diagnostic médical. Les résultats du triage sont des recommandations indicatives qui ne remplacent en aucun cas l'avis d'un professionnel de santé qualifié. En cas d'urgence vitale, contactez immédiatement le SAMU (15) ou les secours locaux.

| Niveau | Description | Action recommandée |
|--------|-------------|-------------------|
| 🔴 1 — Critique | Symptômes potentiellement graves | **Recommandation d'appeler le 15** — avec validation explicite de l'utilisateur |
| 🟡 2 — Modéré | Consultation nécessaire sous 24-48h | Matching avec médecin disponible |
| 🟢 3 — Non urgent | Conseils médicaux suffisants | Conseils + pharmacie partenaire proche |

---

## Sécurité & Conformité

- Chiffrement **TLS 1.3** pour toutes les communications
- Mots de passe hashés avec **bcrypt**
- Authentification **JWT** (access 1h + refresh 7j) avec rotation automatique
- Rate limiting : **20 triages/jour/utilisateur**
- Chiffrement **AES-256** des données médicales au repos
- Conformité **Loi sénégalaise 2008-12** sur la protection des données personnelles
- Déclaration en cours auprès de la **Commission de Protection des Données (CDP)** pour le traitement des données de santé vocales
- Architecture inspirée des principes **HIPAA** et **RGPD** pour la gestion des données médicales

---

## Modèle de données

```
users           — Tous les utilisateurs (patients, médecins, admins)
doctors         — Profils médecins (spécialité, CNOM, langues parlées)
refresh_tokens  — Tokens JWT de rafraîchissement
triages         — Résultats d'analyses vocales IA
consultations   — Sessions de consultation médecin-patient
payments        — Transactions Wave / Orange Money
prescriptions   — Ordonnances numériques avec QR Code
reminders       — Rappels médicaments automatiques
reviews         — Notes et avis post-consultation
```

---

## Équipe

| Membre | Rôle | Responsabilités |
|--------|------|-----------------|
| **Saïd Deme** | Backend & AI Lead | FastAPI, PostgreSQL, Whisper, Groq, Railway, CI/CD |
| **Ndeye Maty Ba** | Frontend & DB Lead | Flutter, UI/UX, Intégration paiements, Modèle de données |
| **Ndeye Diouka Deme** | Business & Medical Lead | Partenariats médecins, Conformité CDP, Stratégie Hult Prize |

---

## Marché & Impact

- **TAM** : 18 millions de personnes au Sénégal
- **SAM** : 5,7 millions de travailleurs informels (96% de la population active)
- **SOM** : 2,3 millions d'utilisateurs accessibles (40% de pénétration smartphone)
- **Réplicabilité** : Mali, Guinée, Côte d'Ivoire — même modèle, mêmes langues, même problème
- **ODD ciblés** : ODD 3 (Santé), ODD 1 (Pauvreté), ODD 8 (Travail décent)

---

## Licence

Projet propriétaire — Équipe KërDoctor  
Hult Prize 2026 — Phase Nationale Sénégal  
Tous droits réservés — Non destiné à une distribution publique sans accord de l'équipe.

---

*KërDoctor — La santé accessible à tous, dans ta langue, depuis chez toi.*
