# QeneRecon – Automated Subdomain Enumeration & Recon Framework

## Overview

- QeneRecon is a Bash-based automation tool for bug bounty hunters and penetration testers. It combines passive and active reconnaissance techniques to discover, validate, and analyze subdomains efficiently.

- Built under the Qene Tech brand, inspired by the meaning of Qene — uncovering hidden signals and deeper intelligence.

## Features

- Multi-source passive subdomain enumeration Integration with industry-standard recon tools Active enumeration (bruteforce and expansion) DNS resolution filtering (removes dead domains) HTTP probing with tech detection Optional subdomain takeover detection Clean and automated workflow

## Tools Used

- subfinder, amass, assetfinder, dnsx, httpx, puredns (optional), subzy (optional), jq, curl, awk

## Passive Sources

crt.sh, AlienVault OTX, URLScan, Web Archive, RapidDNS, HackerTarget, ThreatCrowd, CertSpotter, BufferOver

## Output Files

all_subdomains.txt – all discovered subdomains resolved.txt – valid (DNS-resolving) subdomains live.txt – live hosts with status, title, and technologies takeovers.txt – potential subdomain takeover results

## Usage

- `git clone https://github.com/mintaw/QeneRecon.git` 
- `cd QeneRecon`
- `chmod +x qene-recon.sh`
- `./qene-recon.sh example.com`

## Workflow

Passive enumeration → Merge → Resolve → Active enumeration → Final merge → HTTP probing → Takeover check

## Requirements

Linux environment (recommended Kali Linux), Go installed, internet connection

## Disclaimer

- For educational purposes and authorized testing only. Do not use without permission.
## Author

Qene Tech Cybersecurity | Bug Bounty | Recon Automation 
- YouTube: https://www.youtube.com/@qenetech
- TikTok: https://www.tiktok.com/@qenetech
- LinkedIn: https://www.linkedin.com/in/qmrxe/
- Telegram: https://t.me/qenetechchannel

=> "Turning hidden signals into intelligence."
