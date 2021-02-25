package tw.iii.model;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class VisualizationHandshakeInterceptor extends HttpSessionHandshakeInterceptor{

	
	 @Override
	    public boolean beforeHandshake(ServerHttpRequest request,
	                                   ServerHttpResponse response, WebSocketHandler wsHandler,
	                                   Map<String, Object> attributes) throws Exception {
		//获取请求参数，首先我们要获取HttpServletRequest对象才能获取请求参数；当ServerHttpRequset的层次结构打开后其子类可以获取到我们想要的http对象，那么就简单了。
		//我这里是把获取的请求数据绑定到session的map对象中（attributes）	　　　　
	        HttpServletRequest servletRequest = ((ServletServerHttpRequest) request).getServletRequest();
	        String id = servletRequest.getSession().getId();
	        System.out.println("beforeHandshake: \n"+id);
	        String user =null;
	        user = servletRequest.getParameter("user");
	        if(user!=null) {
	        attributes.put("user",user);
	        }
	        return super.beforeHandshake(request, response, wsHandler, attributes);
	    }

	    @Override
	    public void afterHandshake(ServerHttpRequest request,
	                               ServerHttpResponse response, WebSocketHandler wsHandler,
	                               Exception ex) {
	        System.out.println("After Handshake");
	        super.afterHandshake(request, response, wsHandler, ex);
	    }
}
