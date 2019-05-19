# Rahti 0 to 1

This demo repository shows how to deploy your applications in Rahti (OpenShift based Container Cloud) directly from GitHub (using S2I utility). Further, in this demo we explore some advance features/utilities of Rahti platform like auto-triggering builds, pod auto scaling etc.

## From Rahti Web Interface
1. Create a new project with the "Create Project" button.
  * Add project description as your CSC project for ex. "csc_project: project_100123"
2. Select the new project by clicking its name under "My Projects".
3. Click the blue "Browse Catalog" button.
4. Select "Python".
5. Follow the instructions of the wizard which shows up. When it asks for
   "Application Name" and "Git Repository", enter these:
   * Application name: < your-application-name >
   * Git repository: https://github.com/shukapoo/rahti-demo.git
   * Set ENV variable as APP_FILE=src/app.py in deployment config
7. Select the "Overview" tab from the menu on the left to find the application
   deployment and a URL that has been created to point to it.
<<<<<<< HEAD
8. You can now configure GitHub webhook for your application, this will trigger your application builds automatically when there are push events in your GitHub code. [Instructions.](https://docs.openshift.com/container-platform/3.5/dev_guide/builds/triggering_builds.html#github-webhooks)
9. Configure horizontal pod scaler. Using horizantal pod scaler, OpenShift platform like Rahti can scale up your application pods depending upon pods computational metrics like CPU usage. You can set Autoscaler definition on Rahti WebUI using Deployments>Your Application Name >Autoscale
=======
8. You can now configure GitHub webhook for your application, this will trigger your application builds automatically when there are push events in your GitHub code.[Instructions](https://docs.openshift.com/container-platform/3.5/dev_guide/builds/triggering_builds.html#github-webhooks)
9. Configure horizontal pod scaler. Using horizontal pod scaler, OpenShift platform like Rahti can scale up your application pods depending upon pods computational metrics like CPU usage. You can set Autoscaler definition on Rahti WebUI using Deployments>Your Application Name >Autoscale
>>>>>>> a8b136395a2a014f012390f93f5a89c82b447714
10. Run load against your webservice & check if autoscaling works! You can use example load bash script from this repo, usage

```bash
bash load.sh <your-application-url>
 ```
## Using OC Command Line tool
1. Download & Install OC CLI tool [Instructions](https://docs.okd.io/latest/cli_reference/get_started_cli.html)
2. Login to Rahti using the `oc login` command. You can find
   instructions in the [Rahti documentation](https://rahti.csc.fi/usage/cli/):

   ```bash
   oc login https://rahti.csc.fi:8443 --token=<hidden token from Rahti>
   ```
3. To begin with, you need to create your Rahti project, you could do so by using oc OC tool
 ```bash
oc new-project <your Rahti project name> --description="csc_project: <your CSC project name>"
for example:
oc new-project demo --description="csc_project: project_100123"
```
4. Deploy your python application from GitHub using [S2I utility](https://docs.openshift.com/container-platform/3.6/creating_images/s2i.html). With OpenShift's S2I utility, you can directly deploy your applications in Rahti from application source code hosted in some VCS for ex. GitHub.
```bash
# In this example we use the current repository to deploy a demo Python Flask web application.
oc new-app https://github.com/shukapoo/rahti-demo.git --name web-demo -e APP_FILE=src/app.py
```
5. Create route & expose your application towards internet

```bash
oc create route edge demo-route --insecure-policy='Redirect' --service web-demo
```
6. Configure GitHub WebHooks
You can setup GitHub webhooks, this will trigger your application builds automatically when you push changes to your GitHub code. Please follow instructions [here](https://docs.openshift.com/container-platform/3.5/dev_guide/builds/triggering_builds.html#github-webhooks) to setup your GitHub webhook.

7. Configure horizontal pod Autoscaler. Using horizontal pod scaler, OpenShift platform like Rahti can scale up your application pods depending upon pods computational metrics like CPU usage.
 ```bash
   oc autoscale dc/<your-application-name> --min 1 --max 3 --cpu-percent=10
   ```
8. Run load against your webservice & check if autoscaling works! You can use example load bash script from this repo, usage

```bash
bash load.sh <your-application-url>
 ```
