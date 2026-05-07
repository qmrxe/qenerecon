#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1
OUT="recon-$DOMAIN"

mkdir -p $OUT/{passive,active,resolved,final}

echo "[+] Starting recon on $DOMAIN"


echo "[+] Running subfinder..."
subfinder -d $DOMAIN -silent > $OUT/passive/subfinder.txt

echo "[+] Running assetfinder..."
assetfinder --subs-only $DOMAIN > $OUT/passive/assetfinder.txt

echo "[+] Running amass (passive)..."
amass enum -passive -d $DOMAIN -silent > $OUT/passive/amass.txt

echo "[+] Running custom curl sources..."

bash your_script.sh $DOMAIN
mv *.txt $OUT/passive/ 2>/dev/null || true

echo "[+] Merging passive results..."
cat $OUT/passive/*.txt | sort -u > $OUT/passive/all.txt

echo "[+] Resolving subdomains..."
dnsx -l $OUT/passive/all.txt -silent -o $OUT/resolved/dnsx.txt

echo "[+] Running amass active..."
amass enum -active -d $DOMAIN -silent > $OUT/active/amass_active.txt

if [ -f "/usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt" ]; then
  echo "[+] Running puredns brute..."
  puredns bruteforce /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt $DOMAIN \
    -r /root/resolvers.txt \
    -w $OUT/active/puredns.txt
fi

echo "[+] Combining all results..."
cat $OUT/passive/all.txt \
    $OUT/active/*.txt 2>/dev/null \
    | sort -u > $OUT/final/all_subdomains.txt


echo "[+] Final resolving..."
dnsx -l $OUT/final/all_subdomains.txt -silent \
| sort -u > $OUT/final/resolved.txt


echo "[+] Probing live hosts..."
httpx -l $OUT/final/resolved.txt -silent \
  -title -status-code -tech-detect \
  -o $OUT/final/live.txt

if command -v subzy &> /dev/null; then
  echo "[+] Checking subdomain takeover..."
  subzy run --targets $OUT/final/resolved.txt \
    > $OUT/final/takeovers.txt
fi

echo ""
echo "========== RESULTS =========="
echo "All subs:        $OUT/final/all_subdomains.txt"
echo "Resolved subs:   $OUT/final/resolved.txt"
echo "Live hosts:      $OUT/final/live.txt"
echo "Takeovers:       $OUT/final/takeovers.txt"
echo "============================="
