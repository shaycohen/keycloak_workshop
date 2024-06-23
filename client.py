from keycloak import KeycloakOpenID

# Initiate client
keycloak_openid = KeycloakOpenID(server_url="http://keycloak:8080/auth/",
                                 client_id="app-html5",
                                 realm_name="quickstart",
                                 client_secret_key="secret")

# Get WellKnown Configuration
try: 
    config_well_know = keycloak_openid.well_know()
    print('certs', keycloak_openid.certs())
except Exception as e: 
    print(e, flush=True)
    import pdb; pdb.set_trace()

# Get a User Token
try: 
    token = keycloak_openid.token("alice", "password")
    userinfo = keycloak_openid.userinfo(token['access_token'])
    print('token', token)
    print('userinfo', userinfo)
except Exception as e: 
    print(e, flush=True)
    import pdb; pdb.set_trace()
