# Some setup notes for the workshop

oc login <url> --username admin

oc apply -k https://github.com/redhat-cop/gitops-catalog/openshift-pipelines-operator/overlays/latest

export NAMESPACE=soe-build

oc new-project soe-run
oc new-project soe-build

oc create serviceaccount podman-builder -n ${NAMESPACE}
oc adm policy add-scc-to-user privileged -z podman-builder -n ${NAMESPACE}


# Create the auth file
podman login registry.redhat.io --authfile=auth.json
podman login quay.io --authfile=auth.json
oc create secret generic registry-credentials --from-file=.dockerconfigjson=auth.json --type=kubernetes.io/dockerconfigjson -n $NAMESPACE
rm auth.json


# Create RHEL entitlements
oc get secret etc-pki-entitlement -n openshift-config-managed -o json | \
  jq 'del(.metadata.resourceVersion)' | jq 'del(.metadata.creationTimestamp)' | \
  jq 'del(.metadata.uid)' | jq 'del(.metadata.namespace)' | \
  oc -n $NAMESPACE create -f -

