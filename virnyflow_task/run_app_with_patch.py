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
    
    # Execute app.py as a script (preserves __name__ == "__main__" behavior)
    # This way app.py's main code will execute
    import runpy
    print("🚀 Starting app.py...")
    runpy.run_path('app.py', run_name='__main__')
