# Example - Using GST and BAM to generate a JSON REST Web service and Web service server

This simple example includes a business application diagram (.4ba) with a JSON Web Service Server and a JSON Web Service.

This project was used to discuss the URLs you would write for a non-Genero JSON Web Client using this generated service. See http://4js.com/online_documentation/fjs-gst-manual-html/#gst-topics/c_gst_bam_json_client_intro.html

## Examining the Web service object

In the .4ba diagram, click on the Web service object. Then, in the Properties view, note the Service Name property. It is set to Customers. This is where the service name is set. 

Open the Web service object and the .4wsj file opens. It shows three records: Accounts (Master), Orders, and Lineitems. It shows the relationshops between the three records.

## Specify the default client interaction for the Web server

In the Projects view, select the WebServer application node. Then, in the Properties view, note the Application Server entries. The Web service property is set to true, and the Web service URL suffix is set to "REST/Customers/Accounts('dupont')". This setting will send this URL to the Web service server when the application is run, displaying the results for a single account in a browser.

Before testing this application, ensure you have configured GST to use the Web client.
