OutlookIntegration - Add-in Installation and Registration Manual
---
Version: `1.5.0-preview.1` - `2023-12-11` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Documentation/Bot%20Installation%20and%20Registration%20Manual.md)

Table of contents
---
<!--TOC-->
- [1. Entra ID (Azure AD) Application registration](#1-entra-id-azure-ad-application-registration)
- [2. Add-in Service Installation](#2-add-in-service-installation)
  - [Installation as Windows Service](#installation-as-windows-service)
  - [Installation as Docker Container via Docker Compose](#installation-as-docker-container-via-docker-compose)
  - [Installation as Kubernetes Deployment via HELM Chart](#installation-as-kubernetes-deployment-via-helm-chart)
- [3. Configure the Add-in microservice](#3-configure-the-add-in-microservice)
- [4. Create a personalized Office Add-in using your add-in service](#4-create-a-personalized-office-add-in-using-your-add-in-service)
- [5. Publish your Office Add-in to your Organization/Users](#5-publish-your-office-add-in-to-your-organizationusers)
- [8. Use the Add-in](#8-use-the-add-in)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Entra ID (Azure AD) Application registration

1.  Open the [Entra ID - App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM) portal.

2.  Add a new registration and give it a fitting name.\
    ![New App registration](Images/Entra%20ID%20App%20registration%20New.png)

3.  Write down the *Application ID* (e.g. `4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`) and  *Tenant ID* (e.g. `9776b2ed-e415-439d-9582-85719af85979`).\
    ![App registration ID](Images/Entra%20ID%20App%20registration%20ID.png)

4.  Under **Certificates & secrets** → **Client secrets** add a client secret and write it down (e.g. `UUC8Q[...]`).\
    ![App registration secret](Images/Entra%20ID%20App%20registration%20Secret.png)

5.  Under **API permissions** make sure that you have at least `Mail.Read` and `User.Read` delegated permissions.\
    Once you have added the permissions, use **Grant admin consent for MyCompany** and make sure all permissions have admin consent.\
    ![App registration permissions](Images/Entra%20ID%20App%20registration%20Permissions.png)
    > Note: The `User.Read` permission can be replaced by `openid` which is even less permissive.

6.  Under **Manifest** change `accessTokenAcceptedVersion` to `2` (default: `null`).\
    ![App registration token version](Images/Entra%20ID%20App%20registration%20TokenVersion.png)

7.  Under **Expose an API**
    > Note: If you do not know the addess yet, you can skip the following steps and return here later. But remember to do so or you will be not be able to authenticate when using the *Outlook add-in*.
    1.  Under **Application ID URI** click **Add**.\
    You should see something like `api://4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`. Replace the `api://` with the public base address of you *add-in* service (e.g. `https://addin.MyCompany.com/4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`).
    2.  Under **Scopes defined by this API** click **Add a scope** and set
        - Scope name: `access_as_user`
        - Who can consent: `Admins and users`
        - Admin consent display name: `Read user email`
        - Admin consent description: `Allows the app to read user's email.`
        - User consent display name: `Read your email`
        - User consent description: `Allows the app to read your email.`
    3.  Under **Authorized client applications** click **Add a client application** and enter *Client ID*: `ea5a67f6-b6f3-4338-b240-c655ddc3cc8e` (Outlook) for the created scope.\
    ![App registration expose an API](Images/Entra%20ID%20App%20registration%20Expose.png)
    > If you want to know more about the process you can read the Microsoft article [Register an Office Add-in that uses single sign-on (SSO) with the Microsoft identity platform](https://learn.microsoft.com/en-us/office/dev/add-ins/develop/register-sso-add-in-aad-v2).

As a result of this chapter you should have the following information at your disposal:
* Entra ID Application ID (e.g. `4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`)
* Entry ID Application ID URI (e.g. `https://addin.MyCompany.com/4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`)
* Entra ID Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
* Entra ID Client Secret (e.g. `UUC8Q[...]`)

# 2. Add-in Service Installation
There are different kinds of installation. You may choose the one best suiting your needs.
* Windows Service \
   ✔ lightweight \
   ✔ easy to install, update and configure \
   ⚠ Windows only \
   ℹ .NET required (installed automatically)
* Docker Container via Docker Compose \
   ✔ containerized \
   ✔ cross platform \
   ⚠ Docker with [Docker Compose v2](https://docs.docker.com/compose/) required
* Kubernetes Deployment via [HELM Chart](https://helm.sh/) \
   ✔ containerized \
   ✔ scalable \
   ✔ cross platform \
   ⚠ Kubernetes installation required \
   ⚠ [HELM](https://helm.sh/docs/intro/install/) installation required \
   ⚠ Experience with Kubernetes and HELM Charts required

## Installation as Windows Service

**Installation**

1.  Download Installation from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBRroSWVY6LvkpI3NymPsTwQ?e=qkZS75)
1.  Install `OutlookIntegration Setup 1.5.0.exe`
    > Note: This will automatically install .NET 8.0 if necessary
1.  (Optional, verify running) Open a browser and navigate to \
    http://localhost:8010 \
    You should be greeted with the message\
    `Welcome to the OutlookIntegration Microservice`
1.	Allow inbound traffic to the service.
    > The default port used is `8010`. You may change the port number at any time.
    * Use a Reverse Proxy, like IIS [Application Request Routing](https://www.iis.net/downloads/microsoft/application-request-routing) to redirect traffic to port `8010`.
        > This is the **recommended** option, as you can perform TLS/SSL termination before hitting the service and running the service in combination with other apps.

    *OR*

    * Configure your Windows Firewall to allow inbound traffic to port `8010`
        > Note: You must configure a certificate to use TLS/SSL (see *Configuration*).

1.  As a result of the previous steps you should have a publically accessible and TLS secured endpoint like **https://addin.MyCompany.com**. \
    We will use this address in the next steps.

**Upgrade an existing Installation**

1.	Install `OutlookIntegration Setup vNext.exe` \
    This will upgrade your existing installation.

**Configuration**

If port `8010` (default) is already in use or you want to set any other option, then navigate to the directory \
`%ProgramData%\freedom manufaktur\OutlookIntegration` \
This directory contains the configuration for the app `appsettings.json` as well as some other app files.
Editing `appsettings.json` will show something like
```
{
  "$Note": "Please refer to https://github.com/freedom-manufaktur/OutlookIntegration for how and where to edit this file.",
  "$Help.Urls": "Enter the URLs you want the App to be available at. For example https://+:8011;http://+:8010",
  "Urls": "http://+:8010",
  [...]
  "Api": {
    "$Help.EnableDetailedErrorMessages": "Enable to include the full stack trace when an error occurs while calling the API.",
    "EnableDetailedErrorMessages": false
  }
}
```
*After changing `appsettings.json` you must restart the `OutlookIntegration` Service.*

**Monitoring / Debugging**

The installation creates a new Windows Service that should be running for the service to be available

![Windows Service](Images/Windows%20Service.png)

The installation also creates a new Windows Event Log source `OutlookIntegration`. Please start the *Event Viewer* or any other Event Log monitoring tool to view the application logs.

![Event Viewer](Images/Windows%20Service%20Event%20Log.png)

---

## Installation as Docker Container via Docker Compose

**Installation and Configuration**

1. Download the **outlook-integration** Docker image from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBRroSWVY6LvkpI3NymPsTwQ?e=qkZS75) and register it with your image repository.

1. Download the Docker Compose YAML files from [OutlookIntegration Docker Compose Download](https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Docker%20Compose).

1. Adjust the `compose.env` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `docker compose --env-file .\compose.env up` to deploy the app.

**Monitoring / Debugging**

> The Docker Compose file contains a [healthcheck](https://docs.docker.com/compose/compose-file/05-services/#healthcheck) definition that includes basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Docker Desktop \
![Docker Compose Container Running](Images/Docker%20Compose%20Running.png)

---

## Installation as Kubernetes Deployment via HELM Chart

**Installation and Configuration**

1. Download the **outlook-integration** Docker image from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBRroSWVY6LvkpI3NymPsTwQ?e=qkZS75) and register it with your image repository.

1. Download the HELM Chart files from [OutlookIntegration HELM Chart Download](https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/HELM%20Chart).

1. Adjust the `values.yaml` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `helm upgrade outlook-integration . --install` to deploy the app.
1. Use the command `helm test outlook-integration` to test the deployed app. \
   Expecting to see `Phase: Succeeded`.

**Monitoring / Debugging**

> The Kubernetes Deployment contains [readiness and liveness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) that include basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Kubernetes Dashboard \
![Docker Kubernetes Running](Images/Kubernetes%20Running.png)

# 3. Configure the Add-in microservice
As a result of the previous chapters you should have the following information at your disposal:
* Entra ID Application ID (e.g. `4796b8e0-b713-42f7-9d9e-b5abb6dd49c2`)
* Entra ID Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
* Entra ID Client Secret (e.g. `UUC8Q[...]`)
* Add-in Service URL (e.g. `https://addin.MyCompany.com`)
* Integration Platform URL (e.g. `https://whoosh.oktopus`)
  > We will not cover this here, please contact support@gentlemengroup.de.
* Integration Platform API Key (e.g. `d2hvb3[...]`)
* (Optional) A License Key (e.g. `eyJMaWNlbnN[...]`)
  > You may enter your license later, but you will receive an unlicensed message. Acquire a license by contacting support@gentlemengroup.de.

Let's put all this together.

1.  Base on the type of installation you used, open your `appsettings.json`, `compose.env` or `values.yaml` file.

2.  Enter the information from above into the corresponding properties. *We use the Windows service as an example.*
    ```
    {
      "AzureAD": {
        "ApplicationId": "4796b8e0-b713-42f7-9d9e-b5abb6dd49c2",
        "TenantId": "9776b2ed-e415-439d-9582-85719af85979",
        "ClientSecret": "UUC8Q[...]"
      },
      "Oktopus": {
        "Url": "https://whoosh.oktopus",
        "ApiKey": "d2hvb3[...]"
      },
      "License": {
        "Key": "eyJMaWNlbnN[...]"    
      }
    }
    ```
    > Note: All non-relevant properties have been omitted for better readability.

3.  Restart the *OutlookIntegration* Service/Container.

4.  (Optional) Open a browser and enter the URL of **your** bot and append `/healthcheck` \
    For example **`https://addin.MyCompany.com/healthcheck`** \
    This should result in a page where everything has the status **Healthy**.
    ```
    {
      "status": "Healthy",
      "components": [
        {
          "name": "AzureBot",
          "status": "Healthy"
        },
        {
          "name": "UsuBot",
          "status": "Healthy"
        },
        {
          "name": "UsuKnowledgeManager",
          "status": "Healthy"
        },
        {
          "name": "License",
          "status": "Healthy"
        }
      ]
    }
    ```
    If that is not the case, please go back to the previous steps and try again.

    > You now have a working Teams Bot that can be used in **any** Teams App.
      Read the next chapter on how to create a Teams App.

# 4. Create a personalized Office Add-in using your add-in service

1. TODO

1. Your Add-in is now ready!

# 5. Publish your Office Add-in to your Organization/Users

1.  TODO
    
    > Note: **The publish process usually takes about 1-5 minutes** without any visual indication. \
      After successful submission, it should look like this. \
      ![Published App](Images/Teams%20Admin%20Center%20Publish%20App%20Success.png)
    
    > Note: When deploying the app via policy, or submitting an update it will take **up to 24 hours** before your users will receive the app.
    For testing, you may sign out/in of Teams to refresh your apps.

# 8. Use the Add-in
As a Microsoft Outlook user of your organization.

1.  TODO

3.  Done!
    > Congratulations on successfully installing, configuring, registering and using the **OutlookIntegration**.

# Need support?
If you have any questions regarding the installation and configuration of the OutlookIntegration, contact us at
* All questions regarding the OutlookIntegration \
    support@gentlemengroup.de (Gentlemen Group)
* All questions around the *OutlookIntegration Microservice* / *Teams App Registration* \
    support@freedom-manufaktur.com (freedom manufaktur)
* All questions regarding the USU Knowledge Manager itself \
    support@usu.com (USU)
