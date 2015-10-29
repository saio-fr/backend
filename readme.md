# Backend service

### Purpose

This repo is a starting point for our future backend service.

### How to use

**1) If you haven't did it yet or if it is set to another project, configure your gcloud cli:**

```
gcloud auth login
gcloud config set project saio-fr
```

**2) Run a development environment by executing:**

```
npm run setup.dev.environment
```

This will pull & run all our services from google container registry.

Some data will fill our database. You can edit it with SQL syntax:

```
vim tasks/import.sql
```

**3) Run the node server on localhost**

Linux
```
npm start
```

Mac
```
npm start -- --ws-url ws://<MY-DOCKER-IP>:8081
```
where <MY-DOCKER-IP> is the virtual machine ip on which you are using docker.

**4) You are reading to go**

Open http://localhost:5000/login on any browser. This is an example login page. You can try to log in using the default dev user:

```
user: dev@saio.fr
password: dev
```

If everything goes well, you can see "logged" in the browser console.

**HAPPY CODING!**
