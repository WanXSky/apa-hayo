#!/bin/bash

# ============================================
# INSTALL REVIACTYL PANEL THEME
# ============================================

set -e

PTERO_DIR="/var/www/pterodactyl"

echo "==> Masuk ke direktori Pterodactyl"
cd $PTERO_DIR

echo "==> Menghapus file lama"
rm -rf *

echo "==> Mengunduh Reviactyl Panel Theme"
curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz

echo "==> Mengekstrak file"
tar -xzvf panel.tar.gz

echo "==> Mengatur permission"
chmod -R 755 storage/* bootstrap/cache/

echo "==> Install dependency dengan Composer"
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

echo "==> Menjalankan migrasi database"
php artisan migrate --seed --force

echo "==> Mengatur ownership file"
chown -R www-data:www-data $PTERO_DIR/*

echo "==> Restart service Pterodactyl"
systemctl restart pteroq.service

echo "==> INSTALL REVIACTYL PANEL THEME SELESAI ✅"
