package tw.iii.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import tw.iii.model.MessageHandler;
import tw.iii.model.VisualizationHandshakeInterceptor;



@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		  registry.addHandler(new MessageHandler(), "/websocket")//設定連結
	        .addInterceptors(new VisualizationHandshakeInterceptor());
		
		 
		
	}

}