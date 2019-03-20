 /*
 * Created on Jul 14, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.front.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;


/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ServiceConstant {
    private final static transient Logger log = LogManager.getLogger(ServiceConstant.class);
    public static final String CONFIG_PATH = "";

	public static String LOOK_UP_PATH;
    public static String PROVIDER_URL;
    public static String LOG4J_CONFIG_PATH;
    public static String PDF_CONFIG_PATH;
    public static String TRUST_STORE;
    public static String TRUST_STORE_PASSWORD;
    public static String WS_IAM_URL;
    public static String WS_IAM_USERNAME;
    public static String WS_IAM_PASSWORD;
    public static String WS_IAM_AUTHEN;
    public static String ACCESS_LOG;

    static{
        try {
            FileInputStream fis = new FileInputStream(CONFIG_PATH+"conf.properties");
            Properties props = new Properties();
            props.load(fis);
            LOOK_UP_PATH = props.getProperty("LOOK_UP_PATH");
            PROVIDER_URL = props.getProperty("PROVIDER_URL");
            LOG4J_CONFIG_PATH = props.getProperty("LOG4J_CONFIG_PATH");
            PDF_CONFIG_PATH = props.getProperty("PDF_CONFIG_PATH");
            TRUST_STORE = props.getProperty("TRUST_STORE");
            TRUST_STORE_PASSWORD = props.getProperty("TRUST_STORE_PASSWORD");
            WS_IAM_URL = props.getProperty("WS_IAM_URL");
            WS_IAM_USERNAME = props.getProperty("WS_IAM_USERNAME");
            WS_IAM_PASSWORD = props.getProperty("WS_IAM_PASSWORD");
            WS_IAM_AUTHEN = props.getProperty("WS_IAM_AUTHEN");
            ACCESS_LOG = props.getProperty("ACCESS_LOG");
        } catch (FileNotFoundException e) {
            log.error(e.getMessage());
        } catch (IOException e) {
            log.error(e.getMessage());
        }
    }
}
