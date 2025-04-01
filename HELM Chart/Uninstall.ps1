#              ReleaseName
helm uninstall outlook-integration
kubectl delete -n default pod outlook-integration-test-connection --ignore-not-found=true
# HELM < 3.17.2 created this name (including the release name)
kubectl delete -n default pod outlook-integration-outlook-integration-test-connection --ignore-not-found=true