package tw.iii.config;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;

public class WebSecurityConfig extends AbstractSecurityWebApplicationInitializer {
		/*
		 *	 設置編碼
		 */
	@Override
	protected void beforeSpringSecurityFilterChain(ServletContext servletContext) {
		//insertFilters(servletContext,MultipartResolver());
		FilterRegistration.Dynamic characterEncodingFilter = servletContext.addFilter("encodingFilter", new CharacterEncodingFilter());
        characterEncodingFilter.setInitParameter("encoding", "UTF-8");
        characterEncodingFilter.setInitParameter("forceEncoding", "true");
        characterEncodingFilter.addMappingForUrlPatterns(null, false, "/*");
	}

	
	
	
}
