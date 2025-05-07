 Linux Binary Integrity Checker

This project is a Bash script that verifies the integrity of  Linux binaries by comparing their hash values before and after reinstalling a package.
I completed a portion of this project in my Linux System Administration course. It is designed for Debian-based Linux systems like Ubuntu or Kali.
The script checks binaries such as `gprof`, `setpci`, `xzless`, and `setarch`, logs the results, and alerts if any binary has been tampered with.

How to Run

Clone the repository:

```bash
git clone https://github.com/Lorenzettig7/Linux-Integrity-Check.git
cd Linux-Integrity-Check

Make the script executable:
chmod +x bash-version/check_integrity.sh

Run the script:
sudo ./bash-version/check_integrity.sh

