K8S_INGRESS_IP=$(kubectl get -n observability ingress -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')

USER="test_user"
PASSWORD="very_scure_password"
USER_CREDENTIALS='{"username": "'$USER'", "password": "'$PASSWORD'"}'

# 1. Create user
curl -Ss -H "Content-Type: application/json" -d "$USER_CREDENTIALS" "http://$K8S_INGRESS_IP/users"

# 2. Obtain JWT Token
# CAUTION: jq command must be installed
JWT_TOKEN=$(curl -Ss -H "Content-Type: application/json" -d "$USER_CREDENTIALS" "http://$K8S_INGRESS_IP/login" | jq -r '.token')

# 3. Create application
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" -H "Content-Type: application/json" -d '{"name": "test_app"}' "http://$K8S_INGRESS_IP/applications"

# 4. List applications
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" "http://$K8S_INGRESS_IP/applications"

# 5. Add some logs to application "1"
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" -H "Content-Type: application/json" -d '{"ip_address": "1.2.3.4", "request": {"some_parameter_a": "some_value_a_1", "some_parameter_b": "some_value_b_1"}}' "http://$K8S_INGRESS_IP/logs/1"
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" -H "Content-Type: application/json" -d '{"ip_address": "1.2.3.4", "request": {"some_parameter_a": "some_value_a_2", "some_parameter_b": "some_value_b_2"}}' "http://$K8S_INGRESS_IP/logs/1"
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" -H "Content-Type: application/json" -d '{"ip_address": "1.2.3.4", "request": {"some_parameter_a": "some_value_a_3", "some_parameter_b": "some_value_b_3"}}' "http://$K8S_INGRESS_IP/logs/1"

# 7. List logs of application "1"
curl -Ss -H "Authorization: Bearer ${JWT_TOKEN}" "http://$K8S_INGRESS_IP/logs/1"