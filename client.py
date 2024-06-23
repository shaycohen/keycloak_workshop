from keycloak import KeycloakOpenID

# Configure client
keycloak_openid = KeycloakOpenID(server_url="http://keycloak:8080/auth/",
                                 client_id="app-html5",
                                 realm_name="quickstart",
                                 client_secret_key="secret")

# Get WellKnown
# config_well_known = keycloak_openid.well_known()

# Get Token
token = keycloak_openid.token("alice", "password")

# Get Userinfo
userinfo = keycloak_openid.userinfo(token['access_token'])
print('token', token)
print('userinfo', userinfo)
print('certs', keycloak_openid.certs())

