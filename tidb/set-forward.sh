#!/bin/sh
kubectl port-forward -n tidb-cluster svc/basic-tidb 4000 > pf4000.out &
# 转发到Grafana
# kubectl port-forward -n tidb-cluster svc/basic-grafana 3000 > pf3000.out &