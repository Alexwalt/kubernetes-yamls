#!/bin/sh
TIDB_VERSION=v1.2.4



# TiDB Operator
kubectl apply -f crd.yaml
sleep 5s
kubectl get crd

helm repo add pingcap https://charts.pingcap.org/
kubectl create namespace tidb-admin

helm install --namespace tidb-admin tidb-operator pingcap/tidb-operator --version $TIDB_VERSION \
    --set operatorImage=registry.cn-beijing.aliyuncs.com/tidb/tidb-operator:$TIDB_VERSION \
    --set tidbBackupManagerImage=registry.cn-beijing.aliyuncs.com/tidb/tidb-backup-manager:$TIDB_VERSION \
    --set scheduler.kubeSchedulerImageName=registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler


kubectl get pods --namespace tidb-admin -l app.kubernetes.io/instance=tidb-operator
echo "---------------------wanting----------------------"
echo "tidb-controller-manager\tRunning"
echo "tidb-scheduler\tRunning"

kubectl create namespace tidb-cluster
kubectl -n tidb-cluster apply -f tidb-cluster.yaml

echo "---------------------wanting----------------------"
echo "namespace/tidb-cluster created\ntidbcluster.pingcap.com/basic created"

kubectl -n tidb-cluster apply -f tidb-monitor.yaml
echo "---------------------wanting----------------------"

echo "tidbmonitor.pingcap.com/basic created"

echo "quit by press ctrl+c "
watch kubectl get po -n tidb-cluster