uwsgipaas
=========

The smallest PaaS. Ever.

Copy the app/ dir somewhere on a server. Run "python paas_api.py" from that
directory.

Make requests to the API port to deploy the example app

Deploy MyApp:       PUT /apps/MyApp
Check status:       GET /apps/MyApp
Delete MyApp:       DELETE /apps/MyApp
List deployed apps: GET /apps

