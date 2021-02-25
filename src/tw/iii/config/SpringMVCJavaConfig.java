package tw.iii.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;



@EnableAsync 
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"tw.iii"})
public class SpringMVCJavaConfig implements WebMvcConfigurer {

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
//   @Bean
//   public ContentNegotiatingViewResolver ContentNegotiatingViewResolver() {
//	   ContentNegotiatingViewResolver viewResolver = new ContentNegotiatingViewResolver();
//	   List<View> defaultViews = new ArrayList<View>();
//	    defaultViews.add(MappingJackson2JsonView());
//	    viewResolver.setDefaultViews(defaultViews);
//		return viewResolver;
//   }
//	
//	@Bean
//	public MappingJackson2JsonView MappingJackson2JsonView() {
//		MappingJackson2JsonView v = new MappingJackson2JsonView();
//		v.setPrettyPrint(true);
//		return v;
//	}
//	
//	
//	@Bean
//	public Jaxb2Marshaller getMarshaller() {
//	    Jaxb2Marshaller jaxb2Marshaller = new Jaxb2Marshaller();
//	    jaxb2Marshaller.setClassesToBeBound(House.class);
//
////	    final Map<String,Object> map = new HashMap<>();
////	    map.put("jaxb.formatted.output", true);
////
////	    jaxb2Marshaller.setMarshallerProperties(map);
//	    return jaxb2Marshaller;
//	}
	
	@Bean	
	public InternalResourceViewResolver viewResolver(){
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/");
		return viewResolver;
	}
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver  MultipartResolver() {
		CommonsMultipartResolver com = new CommonsMultipartResolver();
		com.setDefaultEncoding("UTF-8");
		return com;
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/css/");
	
		System.out.println("test2");
		
		
		
		
	}
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/login").setViewName("login.jsp");
		registry.addViewController("/perform_login").setViewName("login.jsp");
		registry.addViewController("/logoutPage").setViewName("logoutpage.jsp");
		registry.addViewController("/register.controller").setViewName("register.jsp");
		registry.addViewController("/productPage").setViewName("productPage.jsp");
		registry.addViewController("/").setViewName("home.jsp");
		
	}
	
}
