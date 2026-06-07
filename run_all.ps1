$ErrorActionPreference = "Stop"

Write-Host "1. Käivitan Docker teenused..."
docker compose up -d --build

Write-Host "2. Paigaldan Python paketid..."
pip install requests pandas

Write-Host "3. Käivitan Python skriptid..."
python scripts\01_MTR_alusandmed.py
python scripts\02_MTR_to_csv.py
python scripts\03_MTA_jooksvad_alusandmed.py
python scripts\04_MTA_varasemad_alusandmed.py
python scripts\05_MTR_andmed_jagamiseks.py

Write-Host "4. Käivitan SQL skriptid andmebaasis..."
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/06_uute_tabelite_laadimine.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/07_MTR_MTA_andmed_juurde.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/08_andmete_jagamine_maksu_algus.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/09_kvaliteedikontroll.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/10_kokkuvqte.sql

Write-Host ""
Write-Host "Valmis!"
Write-Host "Dashboard: http://localhost:8501"