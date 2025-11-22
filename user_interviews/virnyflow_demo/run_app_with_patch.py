#!/usr/bin/env python3
"""
Wrapper script to apply MongoDB SSL patch before running app.py
"""
import sys
import os

# Add /app to path to import mongo_patch
sys.path.insert(0, '/app')

# Apply MongoDB patch BEFORE importing anything else
try:
    import mongo_patch
    print("✅ MongoDB SSL patch applied successfully")
except ImportError as e:
    print(f"⚠️  Warning: Could not import mongo_patch: {e}")
    print("Continuing without patch...")

# Now run app.py with the same arguments
if __name__ == "__main__":
    # Change to app directory
    os.chdir('/app')
    
    # Import app module - this will execute app.py's main code
    # We need to preserve sys.argv so app.py can parse its arguments
    import app

