### Apply the issuer if it doesn't exist

```bash
kubectl get secret my-ca || kubectl create secret tls my-ca --key=../30-request-cert-from-cert-manager/ca.key --cert=../30-request-cert-from-cert-manager/ca.cert

kubectl get issuer my-issuer || kubectl apply -f ../30-request-cert-from-cert-manager/00-issuer.yaml
```

### Delete the existing ingress and cert object

```bash
kubectl delete ingress hello-world
kubectl delete cert hello-world-crt
```

### Apply the annotated ingress

```bash
kubectl apply -f 00-ingress.yaml
```

### View the certificate, csr, and secret, and ingress

```bash
kubectl get cert,cr,secret,ingress
```
...

```
NAME                                          READY   SECRET            AGE
certificate.cert-manager.io/hello-world-tls   True    hello-world-tls   52s

NAME                         TYPE                                  DATA   AGE
secret/default-token-rn2wx   kubernetes.io/service-account-token   3      39m
secret/hello-world-tls       kubernetes.io/tls                     3      9m35s
secret/my-ca                 kubernetes.io/tls                     2      4m38s
secret/regcred               kubernetes.io/dockerconfigjson        1      39m

NAME                                    CLASS    HOSTS                        ADDRESS       PORTS     AGE
ingress.networking.k8s.io/hello-world   <none>   hw.workshop.dev.example.com   10.122.0.96   80, 443   52s
```

### Curl the service

```bash
curl https://hw.workshop.dev.example.com -kv
```
