echo "creating alpine pod"
kubectl run alpine --namespace default --image=alpine --restart='Never' -- sh -c "sleep 3600"

echo "acessing alpine pod"
kubectl exec -i --tty alpine --namespace default -- sh -c "uptime"
