## Create a private key

```bash
openssl genrsa 4096 > hello-world.key
```

## Generate a self-signed certificate

```bash
openssl req -new -x509 -key hello-world.key -subj '/C=US/ST=California/L=Palo Alto/O=VMware, Inc/OU=Tanzu Labs/CN=hw.workshop.dev.example.com/'> hello-world.crt
```

## Create a kubernetes tls secret

```bash
kubectl create secret tls hello-world-tls --key=hello-world.key --cert=hello-world.crt
```

## Verify insecure ingress currently

```bash
kubectl get ingresses
```

...should see the following. Note that only port 80 is listening...

```
NAME          CLASS    HOSTS                        ADDRESS       PORTS   AGE
hello-world   <none>   hw.workshop.dev.example.com   10.122.0.96   80      3s
```

## Diff the ingress object to see the changes

```bash
diff -u ../10-insecure-ingress/00-ingress.yaml 00-ingress.yaml
```

...should look like this:

```
--- ../10-insecure-ingress/00-ingress.yaml      2023-02-01 20:15:02.286335000 +0000
+++ 00-ingress.yaml     2023-02-01 20:38:41.030267000 +0000
@@ -1,9 +1,12 @@
 apiVersion: networking.k8s.io/v1
 kind: Ingress
 metadata:
-  annotations:
   name: hello-world
 spec:
+  tls:
+  - hosts:
+    - hw.workshop.dev.example.com
+    secretName: hello-world-tls
   rules:
   - host: hw.workshop.dev.example.com
     http:
```

## Apply the new ingress object

```bash
kubectl apply -f 00-ingress.yaml
```

## See that port 443 is now being listened on

```bash
kubectl get ingresses
```

```
NAME          CLASS    HOSTS                        ADDRESS       PORTS     AGE
hello-world   <none>   hw.workshop.dev.example.com   10.122.0.96   80, 443   4m13s
```

## Curl the https endpoint

```bash
curl https://hw.workshop.dev.example.com -kv
```
