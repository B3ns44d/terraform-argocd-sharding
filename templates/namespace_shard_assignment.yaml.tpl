apiVersion: mutations.gatekeeper.sh/v1alpha1
kind: Assign
metadata:
  name: "${shard_name}-namespace-assignment"
spec:
  applyTo:
    - groups: [ "argoproj.io" ]
      kinds: [ "Application" ]
      versions: [ "v1alpha1" ]
  location: "spec.destination.name"
  match:
    labelSelector:
      matchExpressions:
        - key: namespace
          operator: In
          values: ${jsonencode(namespace_list)}
  parameters:
    assign:
      value: "${shard_name}"
