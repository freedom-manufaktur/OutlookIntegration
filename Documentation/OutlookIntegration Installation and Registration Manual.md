OutlookIntegration - Add-in Installation and Registration Manual
---
Version: `3.1.0` - `2025-10-17` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/OutlookIntegration/blob/main/Documentation/OutlookIntegration Installation and Registration Manual.md>)

Table of contents
---
<!--TOC-->
- [1. Add-in Service Installation](#1-add-in-service-installation)
  - [Installation as Windows Service](#installation-as-windows-service)
  - [Installation as Docker Container via Docker Compose](#installation-as-docker-container-via-docker-compose)
  - [Installation as Kubernetes Deployment via HELM Chart](#installation-as-kubernetes-deployment-via-helm-chart)
  - [Post Installation check](#post-installation-check)
- [2. Microsoft Entra (Azure AD) Application registration](#2-microsoft-entra-azure-ad-application-registration)
  - [Summary](#summary)
- [3. whoosh Oktopus installation](#3-whoosh-oktopus-installation)
  - [Install whoosh Oktopus](#install-whoosh-oktopus)
    - [Determin Oktopus API key](#determin-oktopus-api-key)
  - [Import Dispatcher workflows](#import-dispatcher-workflows)
  - [Post Installation check](#post-installation-check-1)
- [4. Configure the Add-in microservice](#4-configure-the-add-in-microservice)
- [5. Create a personalized Outlook Add-in using your Add-in service](#5-create-a-personalized-outlook-add-in-using-your-add-in-service)
- [6. Publish your Outlook Add-in to your Organization/Users](#6-publish-your-outlook-add-in-to-your-organizationusers)
  - [How to install (for personal use)](#how-to-install-for-personal-use)
  - [How to install (for organization)](#how-to-install-for-organization)
  - [Use the Add-in](#use-the-add-in)
- [What's new?](#whats-new)
  - [\[3.0.0\] - 2025-10-09](#300---2025-10-09)
  - [\[2.4.0\] - 2025-03-02](#240---2025-03-02)
  - [\[2.3.0\] - 2025-02-11](#230---2025-02-11)
  - [\[2.0.0\] - 2024-07-30](#200---2024-07-30)
  - [\[1.6.0\] - 2023-12-23](#160---2023-12-23)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Add-in Service Installation
There are different kinds of installation. You may choose the one best suiting your needs.
- Windows Service \
  ✔ lightweight \
  ✔ easy to install, update and configure \
  ⚠ Windows only \
  ℹ .NET required (installed automatically)
- Docker Container via Docker Compose \
  ✔ containerized \
  ✔ cross platform \
  ⚠ Docker with [Docker Compose v2](https://docs.docker.com/compose/) required
- Kubernetes Deployment via [HELM Chart](https://helm.sh/) \
  ✔ containerized \
  ✔ scalable \
  ✔ cross platform \
  ⚠ Kubernetes installation required \
  ⚠ [HELM](https://helm.sh/docs/intro/install/) installation required \
  ⚠ Experience with Kubernetes and HELM Charts required

## Installation as Windows Service

**Installation**

1.  Download Installation from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBneAXDiuF-EDpPlknhli9yA?e=55Cd6k)
1.  Install `OutlookIntegration Setup 3.0.0.exe`
    > Note: This will automatically install .NET 9.0 if necessary
1.  (Optional, verify running) Open a browser and navigate to \
    http://localhost:8010 \
    You should be greeted with the message\
    `Welcome to the OutlookIntegration Microservice`
1.	Allow inbound traffic to the service.
    > The default port used is `8010`. You may change the port number at any time.
    - Use a Reverse Proxy, like IIS [Application Request Routing](https://www.iis.net/downloads/microsoft/application-request-routing) to redirect traffic to port `8010`.
        > This is the **recommended** option, as you can perform TLS/SSL termination before hitting the service and running the service in combination with other apps.

    *OR*

    - Configure your Windows Firewall to allow inbound traffic to port `8010`
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

![Windows Service](<Images/Windows Service.png>)

The installation also creates a new Windows Event Log source `OutlookIntegration`. Please start the *Event Viewer* or any other Event Log monitoring tool to view the application logs.

![Event Viewer](<Images/Windows Service Event Log.png>)

---

## Installation as Docker Container via Docker Compose

**Installation and Configuration**

1. Download the **outlook-integration** Docker image from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBneAXDiuF-EDpPlknhli9yA?e=55Cd6k) and register it with your image repository.

1. Download the Docker Compose YAML files from [OutlookIntegration Docker Compose Download](<https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/Docker Compose>).

1. Adjust the `compose.env` with the required settings.

1. Use the command `docker compose --env-file .\compose.env up` to deploy the app.

**Monitoring / Debugging**

> The Docker Compose file contains a [healthcheck](<https://docs.docker.com/compose/compose-file/05-services/#healthcheck>) definition that includes basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Docker Desktop \
![Docker Compose Container Running](<Images/Docker Compose Running.png>)

---

## Installation as Kubernetes Deployment via HELM Chart

**Installation and Configuration**

1. Download the **outlook-integration** Docker image from [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBneAXDiuF-EDpPlknhli9yA?e=55Cd6k) and register it with your image repository.

1. Download the HELM Chart files from [OutlookIntegration HELM Chart Download](<https://github.com/freedom-manufaktur/OutlookIntegration/tree/main/HELM Chart>).

1. Adjust the `values.yaml` with the required settings.

1. Use the command `helm upgrade outlook-integration . --install` to deploy the app.
1. Use the command `helm test outlook-integration` to test the deployed app. \
   Expecting to see `Phase: Succeeded`.

**Monitoring / Debugging**

> The Kubernetes Deployment contains [readiness and liveness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) that include basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Kubernetes Dashboard \
![Docker Kubernetes Running](<Images/Kubernetes Running.png>)

## Post Installation check
As a result of this chapter you should have the following information at your disposal:
- Outlook Integration Service URL (e.g. `https://addin.MyCompany.com`)

You should be able to call `https://addin.MyCompany.com/healthcheck` from a users machine (use a regular browser) and get a `200 OK` response.

# 2. Microsoft Entra (Azure AD) Application registration
> ❓ Are you using Exchange Server (On-Premises)?\
> Read the [Exchange Server Manual](<Exchange Server Registration Manual.md#exchange-server-registration>) instead.

> ❗ Before you begin\
> You **should** know your *Outlook Integration Service URL* from the previous chapter.

1.  Open the [Entra admin center - App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM) portal.

2.  Add a **new registration** and give it a fitting **name**.\
    Under **Redirect URI** choose **Single-page application (SPA)** as platform and enter an URI in the form of\
    `brk-multihub://addin.MyCompany.com`.\
    Insert the domain name of **your** *Outlook Integration Service URL* after the `brk-multihub://`.\
    If your port number is non-standard, then also include it.\
    **Do not** include any path segments after the domain name.
    
    ![New App registration](<Images/Entra App registration New.png>)

3.  Write down the *Application ID* (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`) and  *Tenant ID* (e.g. `9776b2ed-e415-439d-9582-85719af85979`).\
    ![App registration ID](<Images/Entra App registration ID.png>)

4.  Under **API permissions** make sure that you have at least `Mail.Read` and `User.Read` delegated permissions.\
    Once you have added the permissions, use **Grant admin consent for MyCompany** and make sure all permissions have admin consent.\
    ![App registration permissions](<Images/Entra App registration Permissions.png>)
    > ℹ️ Microsoft states that the `User.Read` permission can be replaced by `openid` and `profile` which is even less permissive. We do **not** recommend this, as we had the most reliable results with `User.Read`.
    >
    > ℹ️ Microsoft also states that the `Files.ReadWrite` permission is required. We do **not** need this permission.

## Summary
As a result of this chapter you should have the following information at your disposal:
- Entra Application ID (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`)
- Entra Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)


# 3. whoosh Oktopus installation
Every successful interaction with the Add-in service will result in a call to *whoosh Oktopus* which provides a standardised API to any kind of ITSM tool.

## Install whoosh Oktopus
The *whoosh Oktopus* installation is described in this document:
[whoosh Oktopus Installation Manual](<https://github.com/freedom-manufaktur/Oktopus/blob/main/Documentation/Oktopus Installation Manual.md>)

### Determin Oktopus API key
1.  Go to `Settings` -> `Advanced settings` and write down the `Webhook base URL` and `Webhook API key`.

## Import Dispatcher workflows
1.  Download the `Oktopus Workflow.json` files from the corresponding Dispatcher folder and import them into Oktopus.
2.  Add a connection to all of the steps requiring one.
3.  Adjust the steps as required by your customization.

## Post Installation check
As a result of this chapter you should have the following information at your disposal:
- Oktopus URL (e.g. `https://oktopus.MyCompany.com`)
- Oktopus API key (e.g. `d2hvb3[...]`)
- Dispatcher prefix (e.g. `USU-Dispatcher`, `Ivanti-Dispatcher`, `SMAX-Dispatcher`)


# 4. Configure the Add-in microservice
As a result of the previous chapters you should have the following information at your disposal:
- Entra Application ID (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`)
- Entra Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
- Add-in Service URL (e.g. `https://addin.MyCompany.com`)
- Integration Platform URL (e.g. `https://oktopus.MyCompany.com`)
- Integration Platform API Key (e.g. `d2hvb3[...]`)
- Dispatcher prefix (e.g. `USU-Dispatcher`, `Ivanti-Dispatcher`, `SMAX-Dispatcher`)
- (Optional) A License Key (e.g. `eyJMaWNlbnN[...]`)
  > You may enter your license later, but you will receive an unlicensed message. Acquire a license by contacting [support@freedom-manufaktur.com](mailto:support@freedom-manufaktur.com).

Let's put all this together.

1.  Start your favorite HTTP Request tool like [Postman](https://www.postman.com/).

2.  (One time) Create a *Outlook Integration* tenant by sending the following request
    ```
    POST https://addin.MyCompany.com/api/Tenant/Create
    Authorization: Basic VGVuY[...]
    ```
    and writing down the response like
    ```
    {
      "Id": "3c4ba0e5-216b-411c-8aaa-765dec8b023f",
      "EntraIdApplicationId": null,
      "DispatcherId": null
    }
    ```

    You should write down the *Outlook Integration* *Tenant ID* (e.g. `3c4ba0e5-216b-411c-8aaa-765dec8b023f`) for future reference. You will need to use it to initialize or update the settings of set tenant.

3.  Set or update *Outlook Integration* tenant settings.
    ```
    POST https://addin.MyCompany.com/api/Tenant/3c4ba0e5-216b-411c-8aaa-765dec8b023f/Update
    Authorization: Basic VGVuY[...]
    Content (application/json):
    {
      "DispatcherId": "USU-Dispatcher",
      "EntraIdTenantId": "9776b2ed-e415-439d-9582-85719af85979",
      "EntraIdApplicationId": "577b6e4c-c8a2-4d93-98d2-284e8fb55622",
      "OktopusUrl": "https://oktopus.MyCompany.com",
      "OktopusApiKey": "d2hvb3[...]",
      "WorkflowPrefix": "USU-Dispatcher"
    }
    ```
    with the informative response
    ```
    {
      "DispatcherId": "USU-Dispatcher",
      "EntraIdTenantId": "9776b2ed-e415-439d-9582-85719af85979",
      "EntraIdApplicationId": "577b6e4c-c8a2-4d93-98d2-284e8fb55622",
      "EntraIdClientSecret": "",
      "OktopusUrl": "https://oktopus.MyCompany.com",
      "OktopusApiKey": "d2h***",
      "WorkflowPrefix": "USU-Dispatcher"
    }
    ```

4.  (Only when using Exchange Server (On-Premises))
    Perform an additional step, see [Exchange Server Manual](<Exchange Server Registration Manual.md#configure-the-add-in-microservice-for-exchange-web-services-ews>).

After successfully calling the settings API you can start using the Add-in.
Read the next chapter on how to create your Outlook Add-in.


# 5. Create a personalized Outlook Add-in using your Add-in service
As a result of the previous chapters you should have the following information at your disposal:
- Entra Application ID (e.g. `577b6e4c-c8a2-4d93-98d2-284e8fb55622`)
- Add-in Service URL (e.g. `https://addin.MyCompany.com`)
- Outlook Integration tenant ID (e.g. `3c4ba0e5-216b-411c-8aaa-765dec8b023f`)
- Dispatcher type (e.g. `USU`, `Ivanti`, `SMAX`)

Now we can create your Add-in manifest.
1.  Download `Dispatcher-Template.xml` [here](<../Add-in Template/Dispatcher-Template.xml>).
2.  Edit the file and replace the following placeholders with **your** values.
    - `{{OutlookIntegrationTenantId}}` -> `3c4ba0e5-216b-411c-8aaa-765dec8b023f`
    - `{{AddInServiceUrl}}` -> `https://addin.MyCompany.com`
    - `{{DispatcherType}}` -> `USU`
3.  Save file as `MyCompany.xml`.


# 6. Publish your Outlook Add-in to your Organization/Users
> ❓ Are you using Exchange Server (On-Premises)?\
> Read the [Exchange Server Manual](<Exchange Server Registration Manual.md#add-in-installation>) instead.

## How to install (for personal use)
1.  Visit legacy Outlook add-in store https://outlook.office365.com/mail/inclientstore
1.  Choose *My add-ins* -> *Custom Addins* -> *Add a custom add-in* -> *Add from File...*
1.  Select the your Add-in manifest (e.g. `MyCompany.xml`)

## How to install (for organization)
1.  Visit https://admin.microsoft.com/#/Settings/IntegratedApps (as Microsoft 365 admin)
1.  Select *Upload custom apps*
1.  Choose *App type* = *Office Add-in*
1.  Under *Choose how to upload app* select *Upload manifest file (.xml) from device* and upload your Add-in manifest file (e.g. `MyCompany.xml`)
1.  Follow the instructions until the Add-in has been successfully deployed
    > ℹ️ It takes ~24h (yes, one day) until the Add-in will appear for users.
    >
    > ℹ️ If anything fails, use the browser developer tools (F12) to get error messages (the UI typically  just shows generic fail messages).

## Use the Add-in
As a Microsoft Outlook user of your organization.

1.  Open [Outlook for the Web](https://outlook.office.com) or the desktop application.
1.  Select an email in your Inbox.
1.  Click the Apps icon and choose your Dispatcher.
    ![Outlook Add-in](<Images/Outlook Add-in open.png>)

> 🎉 **Congratulations**\
> You have successfully installed, configured and registered the **OutlookIntegration** and **Outlook Add-in**.


# What's new?
This section lists **important** changes to the documentation and Docker files.
Please read this list when upgrading an existing installation.
> The full app changelog can be found in the [OutlookIntegration Download](https://freedommanufaktur.sharepoint.com/:f:/g/El63_xb4uBZKt_uqMrKfeZoBneAXDiuF-EDpPlknhli9yA?e=55Cd6k)

## [3.0.0] - 2025-10-09
- Nested app authentication (NAA) is now used by default.
  > ⚠️ **Breaking**\
  > Existing installations must change their Entra app registration.
  > See [Microsoft Entra (Azure AD) Application registration](#2-microsoft-entra-azure-ad-application-registration).
  > 
  > You may temporarily disable NAA by setting `Advanced:DisableNestedAppAuth` to `true` in `appsettings.json`. This setting will be removed in a future version of the app.
- Added `TicketNumber` (in addition to `TicketNumberRegex`) option to `Get Dispatcher metadata` workflow response.
- *HELM Chart* has been updated for HELM 3.19.0.

## [2.4.0] - 2025-03-02
- Due to changes by Microsoft, you must use at least version 2.4.0 of the *OutlookIntegration Microservice*.
- *HELM Chart* has been updated for HELM 3.17.1.

## [2.3.0] - 2025-02-11
- Added `EnableTimeTracking` option to `Get Dispatcher metadata` workflow response.

## [2.0.0] - 2024-07-30
- Documentation, *Docker Compose* and *HELM Chart* have been updated with the new tenant managment, removing the need for environment variables/`appsettings.json`.

## [1.6.0] - 2023-12-23
- Documentation, *Docker Compose* and *HELM Chart* have been updated with `Oktopus:Url` and `Oktopus:ApiKey` variables.
  These can be left blank, unless you want to use the *Dispatcher* features.


# Need support?
If you have any questions regarding the installation and configuration of the OutlookIntegration, contact us at
- All questions regarding the *Dispatcher* \
  [services@gentlehuman.de](mailto:services@gentlehuman.de) (Gentlehuman Factory)
- All questions around the *OutlookIntegration Microservice* / *Outlook Add-in Registration* / *whoosh Oktopus* \
  [support@freedom-manufaktur.com](mailto:support@freedom-manufaktur.com) (freedom manufaktur)
- All questions regarding the *USU Service Manager* itself \
  [support@usu.com](mailto:support@usu.com) (USU)
- All questions regarding the *Ivanti Neurons for ITSM* / *Ivanti Service Manager* itself \
  https://www.ivanti.com/support (Ivanti)
