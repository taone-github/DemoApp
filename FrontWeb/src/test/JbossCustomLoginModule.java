package test;

//import java.io.IOException;
//import java.security.acl.Group;
//import java.util.Map;
//
//import javax.security.auth.Subject;
//import javax.security.auth.callback.CallbackHandler;
//import javax.security.auth.login.LoginException;
//
//import org.jboss.security.SimpleGroup;
//import org.jboss.security.SimplePrincipal;
//import org.jboss.security.auth.spi.UsernamePasswordLoginModule;
//import org.jboss.security.auth.spi.UsersRolesLoginModule;

public class JbossCustomLoginModule 
//extends UsernamePasswordLoginModule 
{
//
//	public void initialize(Subject subject, CallbackHandler callbackHandler, Map sharedState, Map options) {
//
//		super.initialize(subject, callbackHandler, sharedState, options);
//	}
//
//	/**
//	 * 
//	 * (required) The UsernamePasswordLoginModule modules compares the result of
//	 * this
//	 * 
//	 * method with the actual password.
//	 * 
//	 */
//
//	@Override
//	protected String getUsersPassword() throws LoginException {
//
//		System.out.format("MyLoginModule: authenticating user '%s'\n", getUsername());
//
//		// Lets pretend we got the password from somewhere and that it's, by a
//		// chance, same as the username
//
//		String password = super.getUsername();
//
//		// Let's also pretend that we haven't got it in plain text but encrypted
//
//		// (the encryption being very simple, namely capitalization)
//
//		password = password.toUpperCase();
//
//		return password;
//	}
//
//	@Override
//	protected boolean validatePassword(String inputPassword, String expectedPassword) {
//
//		// Let's encrypt the password typed by the user in the same way as the
//		// stored password
//
//		// so that they can be compared for equality.
//
//		String encryptedInputPassword = (inputPassword == null) ? null : inputPassword.toUpperCase();
//		System.out.format("Validating that (encrypted) input psw '%s' equals to (encrypted) '%s'\n"
//				, encryptedInputPassword, expectedPassword);
//
//		// Password check strategy: find the password from your storage (e.g.
//		// DB) and check that it's equal
//
//		// with inputPassword. We always return true, meaning password check
//		// will be skipped
//
//		return true;
//	}
//
//	/**
//	 * 
//	 * (required) The groups of the user, there must be at least one group
//	 * called
//	 * 
//	 * "Roles" (though it likely can be empty) containing the roles the user
//	 * has.
//	 * 
//	 */
//
//	@Override
//
//	protected Group[] getRoleSets() throws LoginException {
//
//		SimpleGroup group = new SimpleGroup("Roles");
//
//		try {
//
//			System.out.println("Search here group for user: " + super.getUsername());
//
//			group.addMember(new SimplePrincipal("Manager"));
//
//		} catch (Exception e) {
//
//			throw new LoginException("Failed to create group member for " + group);
//
//		}
//
//		return new Group[] { group };
//
//	}

}
