## Delete old resources

```bash
kubectl delete secret hello-world-tls
kubectl delete ingresses --all
```

## Apply the issuer

### Create the CA secret

```bash
kubectl create secret tls my-ca --cert=ca.cert --key=ca.key
```

### Create the issuer

```bash
kubectl apply -f 00-issuer.yaml
```

### Create the certificate object

```bash
kubectl apply -f 10-certificate.yaml
```

### See the issuer, cert and secrt

```bash
kubectl get issuer,cert,secret
```

```
NAME                               READY   AGE
issuer.cert-manager.io/my-issuer   True    4m6s

NAME                                          READY   SECRET            AGE
certificate.cert-manager.io/hello-world-crt   True    hello-world-tls   2m11s

NAME                         TYPE                                  DATA   AGE
secret/default-token-rn2wx   kubernetes.io/service-account-token   3      30m
secret/hello-world-tls       kubernetes.io/tls                     3      62s
secret/my-ca                 kubernetes.io/tls                     2      5m13s
secret/regcred               kubernetes.io/dockerconfigjson        1      30m
```

### Apply the ingress object

```bash
kubectl apply -f 20-ingress.yaml
```

### Curl the endpoing

```bash
curl -kv https://hw.workshop.dev.example.com
```
