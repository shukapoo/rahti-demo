# rahti-demo
Demos for Rahti OpenShift Cluster

#Create your Rahti project
```bash
# To begin with, you need to create your Rahti project, you could do so by using oc command line tool
oc new-project <your Rahti project name> --description="csc_project: <your CSC project name>"
for example:
oc new-project demo --description="csc_project: project_100123"
```
# Deploy your python application from GitHub using [S2I utility] (https://docs.openshift.com/container-platform/3.6/creating_images/s2i.html)

```bash
# With OpenShift's S2I utility, you can directly deploy your applications in Rahti from application source code hosted in some VCS for ex. GitHub.
In this example we use current repository to deploy a demo Python Flask web application.
oc new-app https://github.com/shukapoo/rahti-demo.git --name web-demo -e APP_FILE=src/app.py

```
# Create route & expose your application towards internet

```bash
oc create route edge demo-route --insecure-policy='Redirect' --service web-demo
```
# Configure GitHub WebHooks
You can setup GitHub webhooks, this will trigger your application builds automatically when you push changes to your GitHub code.
Please follow instructions [here] (https://docs.openshift.com/container-platform/3.5/dev_guide/builds/triggering_builds.html#github-webhooks) to setup your GitHub webhook.

#Configure horizantal pod Autoscaler
If you use horizantal pod autoscaler, system will automatically increase or decrease
