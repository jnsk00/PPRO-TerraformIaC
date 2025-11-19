# PPRO-Terraform: Infrastructure as Code (IaC) - Praktická Demonstrace

## 🎯 Cíl Semestrálního Projektu
Tento projekt slouží jako **praktická část** prezentace na téma **Infrastructure as Code (IaC)** s využitím nástroje **Terraform**. Cílem je demonstrovat kompletní automatizovaný proces nasazení moderní mikroslužby, čímž navazujeme na znalosti z předmětů jako Docker, Kubernetes a CI/CD.

### Anotace projektu
> "Praktická část naváže na znalosti studentů z předchozích cvičení, jako jsou Docker, Kubernetes, mikroslužby a CI/CD, a ukáže, jak lze automatizovaně nasadit Spring Boot aplikaci v Kotlinu do lokálního prostředí spravovaného Terraformem. Přínosem prezentace a workshopu bude demonstrace propojení vývojového procesu s automatizovaným nasazením infrastruktury."

---

## 🛠️ Použité Technologie a Architektura

| Oblast | Technologie | Účel v projektu |
| :--- | :--- | :--- |
| **Aplikace** | Spring Boot (Kotlin) | Jednoduchá REST API mikroslužba ("Hello World"). |
| **Kontejnerizace** | Docker | Kontejnerizace aplikace pro zajištění přenositelnosti. |
| **Orchestrace** | Kubernetes (lokální) | Správa a běh kontejnerů (Deployment, Service). |
| **IaC** | **Terraform** | Deklarativní definice a správa celé infrastruktury (Docker Image + Kubernetes zdroje). |
| **Automatizace** | GitHub Actions | CI/CD pipeline pro validaci a plánování změn infrastruktury. |

## 📂 Struktura Repozitáře

PPRO-Terraform/
├── .github/workflows/
│   └── terraform-ci.yml  # CI/CD pipeline (pro validaci kódu)
├── spring-app/
│   ├── build.gradle.kts  # Sestavení aplikace
│   ├── Dockerfile        # Definice kontejneru
│   └── src/              # Zdrojový kód aplikace
└── terraform/
├── providers.tf      # Konfigurace providerů (Docker, Kubernetes)
├── variables.tf      # Vstupní parametry (port, repliky)
├── main.tf           # Hlavní logika nasazení (Image Build, Deployment, Service)
└── outputs.tf        # Výstupy (přístupový port)
└── README.md


---

## ⚙️ Lokální Demonstrace (Workshop)

Tato sekce slouží k praktické ukázce nasazení.

### Předpoklady
*   Nainstalovaný a spuštěný **Docker**.
*   Nainstalovaný a spuštěný **Kubernetes cluster** (např. Minikube, Docker Desktop K8s).
*   Nainstalovaný **Terraform CLI**.

### 1. Inicializace Terraformu

Přejděte do adresáře `terraform` a inicializujte pracovní prostor. Tím se stáhnou potřebné providery.

```bash
cd terraform
terraform init
```

2. Plánování změn (Dry Run)

Terraform ukáže, co přesně se chystá vytvořit, aniž by provedl jakékoli změny. Zde demonstrujeme princip deklarativní definice.

```bash
terraform plan
```
3. Aplikace konfigurace (Nasazení)

Tento krok provede kompletní nasazení:
1. Sestaví Docker image z spring-app/Dockerfile.
2. Vytvoří Kubernetes Deployment s 2 replikami.
3. Vytvoří Kubernetes Service typu NodePort.

```bash
terraform apply
```
Po výzvě zadejte yes.

4. Ověření a přístup

Po úspěšném nasazení získáte z výstupu outputs.tf port, na kterém aplikace běží.

Pro Minikube:
```bash
minikube service spring-app-demo
```
Obecně: Aplikace je dostupná na adrese http://<IP_adresa_clusteru>:<NodePort>.

5. Úklid

Demonstrujte idempotentnost a snadný úklid infrastruktury.
```bash
terraform destroy
```

🌐 CI/CD Integrace (GitHub Actions )

V souboru .github/workflows/terraform-ci.yml je definována pipeline, která se spouští při každé změně kódu.
Demonstrované principy CI/CD:
Validace: Kontrola syntaxe a správnosti Terraform kódu (terraform validate).
Plánování: Vytvoření náhledu změn (terraform plan), který slouží pro revizi kódu a schválení nasazení.
