import os
import sys
import time
from jwt import JWT, jwk_from_pem

pem_file_path = os.getenv('PEM_FILE_PATH')
app_id = os.getenv('APP_ID')
print(f'app_id: {app_id}')

if not pem_file_path or not app_id:
    print("Both PEM_FILE_PATH and APP_ID environment variables are required.")
    sys.exit(1)

with open(pem_file_path, 'rb') as pem_file:
    signing_key = jwk_from_pem(pem_file.read())

payload = {
    # Issued at time
    'iat': int(time.time()),
    # JWT expiration time (10 minutes maximum)
    'exp': int(time.time()) + 600,
    # GitHub App's identifier
    'iss': app_id
}

# Create JWT
jwt_instance = JWT()
encoded_jwt = jwt_instance.encode(payload, signing_key, alg='RS256')

print(f"JWT:  {encoded_jwt}")