#              ReleaseName
helm uninstall outlook-integration
kubectl delete -n default pod outlook-integration-outlook-integration-test-connection --ignore-not-found=true