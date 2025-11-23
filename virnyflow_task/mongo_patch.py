"""
Monkey patch to disable SSL/TLS for local MongoDB connections.
This patches pymongo.MongoClient to remove tlsCAFile parameter for local connections.
"""
print("🔧 Applying MongoDB SSL patch...")
import pymongo
from pymongo import MongoClient as OriginalMongoClient
import re
print("✅ MongoDB SSL patch module loaded")


def _is_local_connection(host):
    """Check if connection string points to local MongoDB"""
    if not host:
        return False
    local_patterns = [
        r'localhost',
        r'127\.0\.0\.1',
        r'^mongodb://mongodb',  # Docker service name pattern (must be at start)
        r'mongodb://mongodb:',  # Docker service name
        r':27017',  # Default MongoDB port (likely local)
    ]
    host_lower = host.lower()
    for pattern in local_patterns:
        if re.search(pattern, host_lower):
            return True
    return False


def patched_mongo_client(*args, **kwargs):
    """Patched MongoClient that removes SSL for local connections"""
    # Check if connection string is provided (first positional arg or in kwargs)
    connection_string = None
    if args and isinstance(args[0], str):
        connection_string = args[0]
    elif 'host' in kwargs:
        connection_string = kwargs['host']
    
    # Always check for local connections and disable SSL
    if connection_string and _is_local_connection(connection_string):
        # Remove ALL SSL-related parameters for local connections
        kwargs.pop('tlsCAFile', None)
        kwargs.pop('tls', None)
        kwargs.pop('ssl', None)
        kwargs.pop('ssl_cert_reqs', None)
        kwargs.pop('tlsAllowInvalidCertificates', None)
        kwargs.pop('tlsCertificateKeyFile', None)
        kwargs.pop('tlsCertificateKeyFilePassword', None)
        kwargs.pop('tlsCAFile', None)
        kwargs.pop('tlsDisableCertificateValidation', None)
        # Explicitly disable TLS
        kwargs['tls'] = False
        kwargs['ssl'] = False
        print(f"🔧 Patched MongoClient: Disabled SSL for connection: {connection_string[:50]}...")
    
    # Call original MongoClient
    return OriginalMongoClient(*args, **kwargs)


# Apply monkey patch
pymongo.MongoClient = patched_mongo_client
print("✅ Patched pymongo.MongoClient")

# Also patch motor if it's used
try:
    import motor.motor_asyncio
    from motor.motor_asyncio import AsyncIOMotorClient as OriginalAsyncIOMotorClient
    
    def patched_async_mongo_client(*args, **kwargs):
        """Patched AsyncIOMotorClient that removes SSL for local connections"""
        # Check if connection string is provided (first positional arg or in kwargs)
        connection_string = None
        if args and isinstance(args[0], str):
            connection_string = args[0]
        elif 'host' in kwargs:
            connection_string = kwargs['host']
        
        if connection_string and _is_local_connection(connection_string):
            # Remove ALL SSL-related parameters for local connections
            kwargs.pop('tlsCAFile', None)
            kwargs.pop('tls', None)
            kwargs.pop('ssl', None)
            kwargs.pop('ssl_cert_reqs', None)
            kwargs.pop('tlsAllowInvalidCertificates', None)
            kwargs.pop('tlsCertificateKeyFile', None)
            kwargs.pop('tlsCertificateKeyFilePassword', None)
            kwargs.pop('tlsCAFile', None)
            kwargs.pop('tlsDisableCertificateValidation', None)
            # Explicitly disable TLS
            kwargs['tls'] = False
            kwargs['ssl'] = False
            print(f"🔧 Patched AsyncIOMotorClient: Disabled SSL for connection: {connection_string[:50]}...")
        
        return OriginalAsyncIOMotorClient(*args, **kwargs)
    
    motor.motor_asyncio.AsyncIOMotorClient = patched_async_mongo_client
    print("✅ Patched motor.AsyncIOMotorClient")
except ImportError:
    print("⚠️  Motor not available, skipping AsyncIOMotorClient patch")

