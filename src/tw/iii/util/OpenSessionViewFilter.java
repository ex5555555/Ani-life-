package tw.iii.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


public class OpenSessionViewFilter implements Filter {
	
	private SessionFactory sessionFactory;
	
	

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		ServletContext application=filterConfig.getServletContext();
		WebApplicationContext context=WebApplicationContextUtils.getWebApplicationContext(application);
		sessionFactory =context.getBean("sessionFactory",SessionFactory.class);
	}



	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		 	
	        Session session = sessionFactory.getCurrentSession();
	        
	       
        try {
        	session.beginTransaction();
        	System.out.println("開始交易");
        	
        	
        	chain.doFilter(req, resp);
        	
        	
        	session.getTransaction().commit();
        	System.out.println("交易完成");
        }catch(Exception e) {
        	session.getTransaction().rollback();
        	System.out.println("交易失敗、還原");
        	e.printStackTrace();
        	
        }finally {
        	System.out.println("Session closed");
        	
        }
	}



	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
