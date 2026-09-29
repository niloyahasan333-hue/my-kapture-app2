#!/bin/bash

# =====================================================================================
# 🔑 KEYSTORE GENERATION SCRIPT FOR MALWARE APPLICATION
# =====================================================================================

# --- Configuration Variables ---
KEYSTORE_NAME="app/release.keystore"
KEY_ALIAS="KEY_ALIAS_MALWARE"
KEY_PASSWORD="YOUR_STRONG_KEY_PASSWORD_HERE" # <--- !!! MUST BE CHANGED !!!
KEY_STORE_PASSWORD="YOUR_MASTER_STORE_PASSWORD_HERE" # <--- !!! MUST BE CHANGED !!!
KEY_EXPIRY_YEARS=10000
KEY_ALGORITHM="RSA"
KEY_SIZE=2048
KEY_DNAME="CN=Android, OU=Development, O=MyApp, L=Rangpur, ST=Rangpur, C=BD"

echo "--- 🔑 Initiating Keystore Generation Process ---"

# 1. Check if Java is installed (Prerequisite Check)
if ! command -v java &amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;java >/dev/null 2>&1; then
    echo "🔴 ERROR: Java Runtime Environment (JRE) not found. Please install Java to proceed."
    exit 1
fi

# 2. Check if the output directory exists (Best Practice)
OUTPUT_DIR=$(dirname "$KEYSTORE_NAME")
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "ℹ️ Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

echo "------------------------------------------------------------------"
echo "Starting Keytool command..."

# 3. Execute Keytool Command (The Core Action)
keytool -genkeypair \
    -v \
    -keystore "$KEYSTORE_NAME" \
    -alias "$KEY_ALIAS" \
    -keyalg "$KEY_ALGORITHM" \
    -keysize "$KEY_SIZE" \
    -validity $KEY_EXPIRY_YEARS \
    -storepass "$KEY_STORE_PASSWORD" \
    -keypass "$KEY_PASSWORD" \
    -dname "$KEY_DNAME"

# 4. Verification
if [ $? -eq 0 ]; then
    echo "=================================================================="
    echo "✅ SUCCESS: Keystore '$KEYSTORE_NAME' generated successfully!"
    echo "   Action Required: Set these values in your CI/CD secrets or workflow file."
    echo "=================================================================="
else
    echo "=================================================================="
    echo "❌ FAILURE: Keytool command failed. Review the output above."
    echo "=================================================================="
fi
