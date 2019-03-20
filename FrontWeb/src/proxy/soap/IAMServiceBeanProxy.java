package proxy.soap;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Vector;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.soap.Constants;
import org.apache.soap.Fault;
import org.apache.soap.SOAPException;
import org.apache.soap.encoding.SOAPMappingRegistry;
import org.apache.soap.rpc.Call;
import org.apache.soap.rpc.Parameter;
import org.apache.soap.rpc.Response;
import org.apache.soap.transport.http.SOAPHTTPConnection;

import com.front.service.ServiceConstant;

public class IAMServiceBeanProxy {
    private final static transient Logger log = LogManager.getLogger(IAMServiceBeanProxy.class);
    private Call call;

    private URL url = null;

    private String stringURL = "http://localhost:9080/IAMWebService/servlet/rpcrouter";

    private java.lang.reflect.Method setTcpNoDelayMethod;

    private String stringUserName = "";

    private String stringPassword = "";

    private String stringAuthen = "";

    public IAMServiceBeanProxy(String url, String userName, String password, String authen) {
        try {
            if (url.startsWith("https")) {
                System.setProperty("javax.net.ssl.trustStore", ServiceConstant.TRUST_STORE);
                System.setProperty("javax.net.ssl.trustStorePassword", ServiceConstant.TRUST_STORE_PASSWORD);
            }
            setTcpNoDelayMethod = SOAPHTTPConnection.class.getMethod("setTcpNoDelay", new Class[] { Boolean.class });
            this.stringUserName = userName;
            this.stringPassword = password;
            this.stringURL = url;
            this.stringAuthen = authen;
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        call = createCall();
    }

    public IAMServiceBeanProxy() {
        try {
            setTcpNoDelayMethod = SOAPHTTPConnection.class.getMethod("setTcpNoDelay", new Class[] { Boolean.class });
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        call = createCall();
    }

    public synchronized void setEndPoint(URL url) {
        this.url = url;
    }

    public synchronized URL getEndPoint() throws MalformedURLException {
        return getURL();
    }

    private URL getURL() throws MalformedURLException {
        if (url == null && stringURL != null && stringURL.length() > 0) {
            url = new URL(stringURL);
        }
        return url;
    }

    public synchronized java.lang.String getAuthentication(java.lang.String userName, java.lang.String password) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getAuthentication");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        Parameter passwordParam = new Parameter("password", java.lang.String.class, password, Constants.NS_URI_SOAP_ENC);
        params.addElement(passwordParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized boolean accessObject(java.lang.String objectName, java.lang.String accessName, java.lang.String userName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("accessObject");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter objectNameParam = new Parameter("objectName", java.lang.String.class, objectName, Constants.NS_URI_SOAP_ENC);
        params.addElement(objectNameParam);
        Parameter accessNameParam = new Parameter("accessName", java.lang.String.class, accessName, Constants.NS_URI_SOAP_ENC);
        params.addElement(accessNameParam);
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.Boolean) refValue.getValue()).booleanValue();
        }
    }

    public synchronized java.lang.String getRole(java.lang.String userName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getRole");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String changePassword(java.lang.String userName, java.lang.String newPassword) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("changePassword");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        Parameter newPasswordParam = new Parameter("newPassword", java.lang.String.class, newPassword, Constants.NS_URI_SOAP_ENC);
        params.addElement(newPasswordParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getExcludeUser(java.lang.String objectName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getExcludeUser");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter objectNameParam = new Parameter("objectName", java.lang.String.class, objectName, Constants.NS_URI_SOAP_ENC);
        params.addElement(objectNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getSystemID(java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getSystemID");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getAccessOfObjectRole(java.lang.String objectName, java.lang.String roleName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getAccessOfObjectRole");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter objectNameParam = new Parameter("objectName", java.lang.String.class, objectName, Constants.NS_URI_SOAP_ENC);
        params.addElement(objectNameParam);
        Parameter roleNameParam = new Parameter("roleName", java.lang.String.class, roleName, Constants.NS_URI_SOAP_ENC);
        params.addElement(roleNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getObjectInRole(java.util.Vector roleName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getObjectInRole");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter roleNameParam = new Parameter("roleName", java.util.Vector.class, roleName, Constants.NS_URI_SOAP_ENC);
        params.addElement(roleNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getFirstName(java.lang.String userName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getFirstName");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getAccessOfObjectUser(java.lang.String objectName, java.lang.String userName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getAccessOfObjectUser");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter objectNameParam = new Parameter("objectName", java.lang.String.class, objectName, Constants.NS_URI_SOAP_ENC);
        params.addElement(objectNameParam);
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized int getSizeOfRole(java.lang.String roleName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getSizeOfRole");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter roleNameParam = new Parameter("roleName", java.lang.String.class, roleName, Constants.NS_URI_SOAP_ENC);
        params.addElement(roleNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.Integer) refValue.getValue()).intValue();
        }
    }

    public synchronized java.lang.String getSurName(java.lang.String userName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getSurName");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getIncludeUser(java.lang.String objectName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getIncludeUser");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter objectNameParam = new Parameter("objectName", java.lang.String.class, objectName, Constants.NS_URI_SOAP_ENC);
        params.addElement(objectNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getObjectInUser(java.lang.String userName, java.lang.String systemName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getObjectInUser");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter userNameParam = new Parameter("userName", java.lang.String.class, userName, Constants.NS_URI_SOAP_ENC);
        params.addElement(userNameParam);
        Parameter systemNameParam = new Parameter("systemName", java.lang.String.class, systemName, Constants.NS_URI_SOAP_ENC);
        params.addElement(systemNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    public synchronized java.lang.String getParentOfRole(java.lang.String roleName) throws Exception {
        String targetObjectURI = "http://tempuri.org/com.ge.iam.webservice.IAMServiceBean";
        String SOAPActionURI = "";

        if (getURL() == null) {
            throw new SOAPException(Constants.FAULT_CODE_CLIENT, "A URL must be specified via IAMServiceBeanProxy.setEndPoint(URL).");
        }

        call.setMethodName("getParentOfRole");
        call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);
        call.setTargetObjectURI(targetObjectURI);
        Vector params = new Vector();
        Parameter roleNameParam = new Parameter("roleName", java.lang.String.class, roleName, Constants.NS_URI_SOAP_ENC);
        params.addElement(roleNameParam);
        call.setParams(params);
        Response resp = call.invoke(getURL(), SOAPActionURI);

        //Check the response.
        if (resp.generatedFault()) {
            Fault fault = resp.getFault();
            call.setFullTargetObjectURI(targetObjectURI);
            throw new SOAPException(fault.getFaultCode(), fault.getFaultString());
        } else {
            Parameter refValue = resp.getReturnValue();
            return ((java.lang.String) refValue.getValue());
        }
    }

    protected Call createCall() {
        SOAPHTTPConnection soapHTTPConnection = new SOAPHTTPConnection();
        if (setTcpNoDelayMethod != null) {
            try {
                setTcpNoDelayMethod.invoke(soapHTTPConnection, new Object[] { Boolean.TRUE });
            } catch (Exception ex) {
            }
        }
        Call call = new Call();

        if (this.stringAuthen.equalsIgnoreCase("Y")) {
            soapHTTPConnection.setUserName(stringUserName);
            soapHTTPConnection.setPassword(stringPassword);
        }
        call.setSOAPTransport(soapHTTPConnection);
        SOAPMappingRegistry smr = call.getSOAPMappingRegistry();
        return call;
    }
}
